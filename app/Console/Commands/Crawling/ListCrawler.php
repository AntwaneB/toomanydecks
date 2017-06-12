<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\CardPage;
use App\Models\Crawling\Crawler;
use Goutte\Client;
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
    }

	protected function currentPageCardPages()
	{
		$listCrawler = $this->httpClient->request('GET', $this->getNextPageURL());

		$listCrawler->filter($this->crawler->invidivual_selector)
					->each(function ($individualCard) {
						$cardPageURL = $individualCard->filter($this->crawler->url_selector)->attr('href');

						$cardPage = CardPage::firstOrCreate([
							'url' => $cardPageURL,
							'crawler_id' => $this->crawler->id
						]);
					});
	}

    protected function getNextPageURL()
    {
    	$url = $this->crawler->list_url;
    	$url = preg_replace('#\{page\}#', $this->currentPage, $url);

    	return $url;
    }

	abstract protected function hasNextPage();
}
