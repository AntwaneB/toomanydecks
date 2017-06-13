<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AlterTableCrawlersAddDataSelectors extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('crawling_crawlers', function (Blueprint $table) {
            $table->string('individual_selector')->nullable();
            $table->string('url_selector')->nullable();
            $table->string('brand_selector')->nullable();
            $table->string('name_selector')->nullable();
            $table->string('description_selector')->nullable();
            $table->string('in_stock_selector')->nullable();
            $table->string('price_selector')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('crawling_crawlers', function (Blueprint $table) {
            $table->dropColumn('individual_selector');
            $table->dropColumn('url_selector');
            $table->dropColumn('brand_selector');
            $table->dropColumn('name_selector');
            $table->dropColumn('description_selector');
            $table->dropColumn('in_stock_selector');
            $table->dropColumn('price_selector');
        });
    }
}
