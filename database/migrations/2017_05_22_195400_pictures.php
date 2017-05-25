<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Pictures extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pictures', function (Blueprint $table) {
            $table->increments('id');
			$table->integer('variation_id')->unsigned()->index();
			$table->enum('type', ['case', 'back', 'front', 'splash', 'other'])->default('other');
			$table->boolean('main')->default(false);
			$table->string('path');
            $table->timestamps();
            $table->softDeletes();

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
        Schema::dropIfExists('pictures');
    }
}
