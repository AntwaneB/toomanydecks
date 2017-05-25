<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateStoreVariationPivotTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('store_variation', function (Blueprint $table) {
            $table->integer('store_id')->unsigned()->index();
            $table->foreign('store_id')->references('id')->on('stores')->onDelete('cascade');
            $table->integer('variation_id')->unsigned()->index();
            $table->foreign('variation_id')->references('id')->on('variations')->onDelete('cascade');
            $table->primary(['store_id', 'variation_id']);

			$table->boolean('in_stock')->default(true);
			$table->double('price');
			$table->string('url');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::drop('store_variation');
    }
}
