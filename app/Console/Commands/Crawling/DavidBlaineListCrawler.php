<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\Crawler;
use App\Models\Store;

class DavidBlaineListCrawler extends ListCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:list:david-blaine';

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

	protected function hasNextPage()
	{
		return $this->currentPage < 1;
	}
}
