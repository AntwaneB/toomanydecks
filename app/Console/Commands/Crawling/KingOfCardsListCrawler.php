<?php

namespace App\Console\Commands\Crawling;

use App\Models\Crawling\Crawler;
use App\Models\Store;

class KingOfCardsListCrawler extends ListCrawler
{
	/**
	 * The name and signature of the console command.
	 *
	 * @var string
	 */
	protected $signature = 'crawler:list:king-of-cards';

	/**
	 * Create a new command instance.
	 *
	 * @return void
	 */
	public function __construct()
	{
		$store = Store::where('slug', 'king-of-cards')->firstOrFail();
		$crawler = Crawler::where('store_id', $store->id)->firstOrFail();

		parent::__construct($crawler);
	}

	protected function hasNextPage()
	{
		return $this->currentPage < 1;
	}
}
