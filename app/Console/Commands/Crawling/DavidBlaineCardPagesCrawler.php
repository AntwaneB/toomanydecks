<?php

namespace App\Console\Commands\Crawling;

use App\Models\Brand;
use App\Models\Crawling\Crawler;
use App\Models\Store;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;

class DavidBlaineCardPagesCrawler extends CardPagesCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:cards:david-blaine';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$store = Store::where('slug', 'david-blaine')->firstOrFail();
		$crawler = Crawler::where('store_id', $store->id)->firstOrFail();

		parent::__construct($crawler);
	}

	protected function getCardName(DOMCrawler $pageCrawler)
	{
		$name = $pageCrawler->filter('meta[property="og:title"]')->attr("content");
		$name = trim($name);

		return $name;
	}

	protected function getCardPrice(DOMCrawler $pageCrawler)
	{
		$price = $pageCrawler->filter('meta[property="og:price:amount"]')->attr("content");
		$price = trim($price);

		return $price;
	}

	protected function getCardDescription(DOMCrawler $pageCrawler)
	{
		$description = $pageCrawler->filter('meta[name="twitter:description"]')->attr("content");
		$description = trim($description);

		return $description;
	}

	protected function getCardBrand(DOMCrawler $pageCrawler)
	{
		$brand = Brand::where('slug', 'david-blaine')->firstOrFail();

		return $brand->id;
	}

	protected function getCardAvailability(DOMCrawler $pageCrawler)
	{
		return true;
	}
}
