<?php

namespace App\Console;

use App\Console\Commands\Crawling\ArtOfPlayCardPagesCrawler;
use App\Console\Commands\Crawling\ArtOfPlayListCrawler;
use App\Console\Commands\Crawling\BlackIncPlayingCardsCardPagesCrawler;
use App\Console\Commands\Crawling\BlackIncPlayingCardsListCrawler;
use App\Console\Commands\Crawling\DavidBlaineCardPagesCrawler;
use App\Console\Commands\Crawling\DavidBlaineListCrawler;
use App\Console\Commands\Crawling\JPPlayingCardsListCrawler;
use App\Console\Commands\Crawling\KingOfCardsListCrawler;
use App\Console\Commands\Crawling\Theory11CardPagesCrawler;
use App\Console\Commands\Crawling\Theory11ListCrawler;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        JPPlayingCardsListCrawler::class,
	    KingOfCardsListCrawler::class,
	    DavidBlaineListCrawler::class,
	    BlackIncPlayingCardsListCrawler::class,
	    Theory11ListCrawler::class,
	    ArtOfPlayListCrawler::class,

	    BlackIncPlayingCardsCardPagesCrawler::class,
	    DavidBlaineCardPagesCrawler::class,
	    Theory11CardPagesCrawler::class,
	    ArtOfPlayCardPagesCrawler::class,
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        // $schedule->command('inspire')
        //          ->hourly();
    }

    /**
     * Register the Closure based commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        require base_path('routes/console.php');
    }
}
