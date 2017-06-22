<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterTableCrawlingCardDataAddVariationId extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('crawling_card_data', function (Blueprint $table) {
            $table->integer('variation_id')->nullable()->unsigned()->index();

	        $table->foreign('variation_id')->references('id')->on('variations')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('crawling_card_data', function (Blueprint $table) {
            $table->dropColumn('variation_id');
        });
    }
}
