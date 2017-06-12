<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCrawlingTableCrawlers extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('crawling_crawlers', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('store_id')->unsigned()->index();

            $table->string('list_url');
            $table->string('list_frequency')->default('0 3 * * *');
	        $table->boolean('last_list_run_success')->default(true);
	        $table->dateTime('last_list_run')->nullable();
	        $table->dateTime('last_list_completion')->nullable();
	        $table->enum('list_state', ['RUNNING', 'ON', 'OFF'])->default('OFF');

	        $table->string('cards_frequency')->default('0 3 * * *');
	        $table->boolean('last_cards_run_success')->default(true);
	        $table->dateTime('last_cards_run')->nullable();
	        $table->dateTime('last_cards_completion')->nullable();
	        $table->enum('cards_state', ['RUNNING', 'ON', 'OFF'])->default('OFF');

            $table->timestamps();
            $table->softDeletes();

	        $table->foreign('store_id')->references('id')->on('stores')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('crawlers');
    }
}
