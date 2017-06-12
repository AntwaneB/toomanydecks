<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCrawlingTableCardPages extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('crawling_card_pages', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('crawler_id')->unsigned()->index();

	        $table->integer('card_id')->unsigned()->index()->nullable();

            $table->string('url')->unique();
	        $table->boolean('last_run_success')->default(true);
	        $table->dateTime('last_run')->nullable();
	        $table->dateTime('last_completion')->nullable();

	        $table->timestamps();
	        $table->softDeletes();

	        $table->foreign('crawler_id')->references('id')->on('crawling_crawlers')->onDelete('cascade');
	        $table->foreign('card_id')->references('id')->on('cards')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card_pages');
    }
}
