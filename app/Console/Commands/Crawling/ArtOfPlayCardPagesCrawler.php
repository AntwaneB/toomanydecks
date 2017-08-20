<?php

namespace App\Console\Commands\Crawling;

use App\Models\Brand;
use App\Models\Crawling\Crawler;
use App\Models\Store;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;


class ArtOfPlayCardPagesCrawler extends CardPagesCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:cards:art-of-play';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$store = Store::where('slug', 'art-of-play')->firstOrFail();
		$crawler = Crawler::where('store_id', $store->id)->firstOrFail();

		parent::__construct($crawler);
	}

	protected function getCardName(DOMCrawler $pageCrawler)
	{
		$d = json_decode($pageCrawler->filter('script[type="application/ld+json"]')->last()->text());

		return $d->name;
	}

	protected function getCardDescription(DOMCrawler $pageCrawler)
	{
		$d = json_decode($pageCrawler->filter('script[type="application/ld+json"]')->last()->text());

		return $d->description;
	}

	protected function getCardPrice(DOMCrawler $pageCrawler)
	{
		$d = json_decode($pageCrawler->filter('script[type="application/ld+json"]')->last()->text());

		return $d->offers->price;
	}

	protected function getCardAvailability(DOMCrawler $pageCrawler)
	{
		$d = json_decode($pageCrawler->filter('script[type="application/ld+json"]')->last()->text());

		return $d->offers->availability == "InStock";
	}
}