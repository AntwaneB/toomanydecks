<?php

namespace App\Console\Commands\Crawling;

use App\Models\Brand;
use App\Models\Crawling\Crawler;
use App\Models\Store;
use Symfony\Component\DomCrawler\Crawler as DOMCrawler;

class Theory11CardPagesCrawler extends CardPagesCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:cards:theory11';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$store = Store::where('slug', 'theory11')->firstOrFail();
		$crawler = Crawler::where('store_id', $store->id)->firstOrFail();

		parent::__construct($crawler);
	}

	protected function getCardBrand(DOMCrawler $pageCrawler)
	{
		$brand = Brand::where('slug', 'theory11')->firstOrFail();

		return $brand->id;
	}

	protected function getCardName(DOMCrawler $pageCrawler)
	{
		$name = $pageCrawler->filter('meta[property="og:title"]')->attr("content");
		$name = trim($name);

		return $name;
	}

	protected function getCardDescription(DOMCrawler $pageCrawler)
	{
		$description = $pageCrawler->filter('meta[name="twitter:description"]')->attr("content");
		$description = trim($description);

		return $description;
	}

	protected function getCardPrice(DOMCrawler $pageCrawler)
	{
		$price = null;

		try
		{
			$price = $pageCrawler->filter('meta[name="twitter:data1"]')->attr("content");
			$price = preg_replace('#[$€£]#', '', $price);
			$price = trim($price);

			if ($price == 'FREE')
				$price = 0;
		}
		catch (\Exception $e)
		{
			$price = $pageCrawler->filter($this->crawler->price_selector)->text();
			$price = preg_replace('#[€$£]#', '', $price);
			$price = trim($price);
			$price = floatval($price);
		}

		return $price;
	}
}
