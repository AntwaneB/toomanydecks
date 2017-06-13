<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\CardPage;
use App\Models\Crawling\Crawler;
use Goutte\Client;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;
use Illuminate\Console\Command;

abstract class ListCrawler extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'crawler:list:';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Store list crawler';

    protected $httpClient;
    protected $crawler;
    protected $currentPage = 0;

    protected $cardPagesCount = [
    	'new' => 0,
	    'old' => 0,
    ];

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct(Crawler $crawler)
    {
        parent::__construct();

        $this->httpClient = new Client();
        $this->crawler = $crawler;
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
    	if ($this->crawler->list_state != 'ON')
    		return;

	    $this->info("[List Crawler - " . $this->crawler->store->name . "] START");

    	$this->crawler->last_list_run = new \DateTime();
    	$this->crawler->list_state = 'RUNNING';
    	$this->crawler->save();

	    while ($this->hasNextPage())
	    {
	    	$this->currentPage++;

	    	$this->currentPageCardPages();
	    }

	    $this->crawler->last_list_run_success = true;
	    $this->crawler->last_list_completion = new \DateTime();
	    $this->crawler->list_state = 'ON';
	    $this->crawler->save();

	    $this->info("[List Crawler - " . $this->crawler->store->name . "] END (" . $this->cardPagesCount['new'] . " new, " . $this->cardPagesCount['old'] . " updated)");
    }

	protected function currentPageCardPages()
	{
		$this->info("[List Crawler - " . $this->crawler->store->name . "] Crawling page $this->currentPage");

		$listCrawler = $this->httpClient->request('GET', $this->getNextPageURL());

		$listCrawler->filter($this->crawler->individual_selector)
					->each(function (DOMCrawler $individualCard) {
						$cardPageURL = $individualCard->filter($this->crawler->url_selector)->link()->getUri();

						$cardPage = CardPage::firstOrNew([
							'url' => $cardPageURL,
							'crawler_id' => $this->crawler->id
						]);

						$this->cardPagesCount[$cardPage->exists ? 'old' : 'new']++;

						$cardPage->save();
					});

		$this->info("[List Crawler - " . $this->crawler->store->name . "] Done crawling page $this->currentPage");
	}

    protected function getNextPageURL()
    {
    	$url = $this->crawler->list_url;
    	$url = preg_replace('#\{page\}#', $this->currentPage, $url);

    	return $url;
    }

	abstract protected function hasNextPage();
}
