<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\CardData;
use App\Models\Crawling\CardPage;
use App\Models\Crawling\Crawler;
use Goutte\Client;
use Illuminate\Console\Command;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;

class CardPagesCrawler extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'crawler:cards:';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Card pages crawler';

	protected $httpClient;
	protected $crawler;

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
	    if ($this->crawler->cards_state != 'ON')
		    return;

	    $this->info("[Cards Crawler - " . $this->crawler->store->name . "] START");

	    $this->crawler->last_cards_run = new \DateTime();
	    $this->crawler->cards_state = 'RUNNING';
	    $this->crawler->save();

	    try
	    {
		    foreach ($this->crawler->cardPages as $cardPage)
		    {
			    $this->getCard($cardPage);
		    }

		    $this->crawler->last_cards_run_success = true;
		    $this->crawler->last_cards_completion = new \DateTime();
	    }
	    catch (\Exception $e)
	    {
		    $this->error($e->getMessage());

		    $this->crawler->last_cards_run_success = false;
	    }

	    $this->crawler->cards_state = 'ON';
	    $this->crawler->save();

	    $this->info("[Cards Crawler - " . $this->crawler->store->name . "] END");
    }

    private function getCard(CardPage $cardPage)
    {
	    $cardPage->last_run = new \DateTime();
	    $cardPage->save();

	    $this->info("[Cards Crawler - " . $this->crawler->store->name . "] Crawling URL " . $cardPage->url);

	    $pageCrawler = $this->httpClient->request('GET', $cardPage->url);

	    $cardData = CardData::firstOrNew(['card_page_id' => $cardPage->id]);
	    $cardData->brand_id = $this->getCardBrand($pageCrawler);
	    $cardData->name = $this->getCardName($pageCrawler);
	    $cardData->description = $this->getCardDescription($pageCrawler);
	    $cardData->in_stock = $this->getCardAvailability($pageCrawler);
	    $cardData->price = $this->getCardPrice($pageCrawler);
	    $cardData->save();

	    $this->info("[Cards Crawler - " . $this->crawler->store->name . "] Done crawling URL " . $cardPage->url);

	    $cardPage->last_run_success = true;
	    $cardPage->last_completion = new \DateTime();
	    $cardPage->save();
    }

    protected function getCardBrand(DOMCrawler $pageCrawler)
    {
		return null;
    }

	protected function getCardName(DOMCrawler $pageCrawler)
    {
	    $name = $pageCrawler->filter($this->crawler->name_selector)->text();
	    $name = trim($name);

		return $name;
    }

	protected function getCardDescription(DOMCrawler $pageCrawler)
    {
	    $description = $pageCrawler->filter($this->crawler->description_selector)->text();
	    $description = trim($description);

	    return $description;
    }

	protected function getCardAvailability(DOMCrawler $pageCrawler)
    {
	    return null;
    }

	protected function getCardPrice(DOMCrawler $pageCrawler)
    {
	    $price = $pageCrawler->filter($this->crawler->price_selector)->text();
	    $price = preg_replace('#[€$£]#', '', $price);
	    $price = trim($price);
	    $price = floatval($price);

	    return $price;
    }
}
