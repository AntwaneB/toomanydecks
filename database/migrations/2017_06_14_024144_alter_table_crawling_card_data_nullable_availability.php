<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterTableCrawlingCardDataNullableAvailability extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('crawling_card_data', function (Blueprint $table) {
	        $table->boolean('in_stock')->default(true)->nullable()->change();
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
	        $table->boolean('in_stock')->default(true)->change();
        });
    }
}
