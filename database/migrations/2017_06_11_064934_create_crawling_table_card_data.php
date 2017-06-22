<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCrawlingTableCardData extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('crawling_card_data', function (Blueprint $table) {
            $table->increments('id');
	        $table->integer('card_page_id')->unsigned()->index();

	        $table->integer('card_id')->unsigned()->index()->nullable();

	        $table->integer('brand_id')->unsigned()->index()->nullable();
	        $table->string('name');
	        $table->text('description')->nullable();
	        $table->boolean('in_stock')->default(true);
	        $table->double('price');

	        $table->timestamps();
	        $table->softDeletes();

	        $table->foreign('card_page_id')->references('id')->on('crawling_card_pages')->onDelete('cascade');
	        $table->foreign('card_id')->references('id')->on('cards')->onDelete('cascade');
	        $table->foreign('brand_id')->references('id')->on('brands')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('card_data');
    }
}
