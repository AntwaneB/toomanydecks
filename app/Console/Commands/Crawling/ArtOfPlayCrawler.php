<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\Crawler;
use App\Models\Store;

class ArtOfPlayCrawler extends ListCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:list:art-of-play';

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

	protected function hasNextPage()
	{
		return $this->currentPage < 5;
	}
}
