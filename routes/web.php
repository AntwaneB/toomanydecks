<?php

use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', ['as' => 'app.index', 'uses' => 'AppController@index']);

Route::resource('brands', 'BrandController');

Route::resource('cards', 'CardController');

Route::group(['prefix' => '/crawlers'], function(){
	Route::get('/artofplay', function(){
		Artisan::call('db:seed', ['--class' => 'ArtOfPlayCrawlerSeeder']);
		Artisan::output();
	});
});