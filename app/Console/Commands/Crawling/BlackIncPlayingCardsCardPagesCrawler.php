<?php

namespace App\Console\Commands\Crawling;

use App\Models\Brand;
use App\Models\Crawling\Crawler;
use App\Models\Store;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;

class BlackIncPlayingCardsCardPagesCrawler extends CardPagesCrawler
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'crawler:cards:black-ink-playing-cards';

    /**
     * Create a new command instance.
     *
     * @return void
     */
	public function __construct()
	{
		$store = Store::where('slug', 'black-ink-playing-cards')->firstOrFail();
		$crawler = Crawler::where('store_id', $store->id)->firstOrFail();

		parent::__construct($crawler);
	}

	protected function getCardBrand(DOMCrawler $pageCrawler)
	{
		$brand = Brand::where('slug', 'black-ink-playing-cards')->firstOrFail();

		return $brand->id;
	}

	protected function getCardAvailability(DOMCrawler $pageCrawler)
	{
		return true;
	}
}
