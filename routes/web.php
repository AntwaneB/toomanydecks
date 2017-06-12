<?php

use Illuminate\Support\Facades\Artisan;

Route::get('/', 'AppController@index')->name('app.index');
Route::get('/about', 'AppController@about')->name('app.about');

Route::resource('brands', 'BrandController');

Route::resource('cards', 'CardController');

Route::resource('stores', 'StoreController');

Route::group(['prefix' => '/admin', 'as' => 'admin.', 'namespace' => 'Admin'], function()
{
    Route::get('/', 'AdminController@index')->name('index');

    Route::resource('cards', 'CardController');

    Route::resource('brands', 'BrandController');

    Route::resource('variations', 'VariationController');

    Route::resource('stores', 'StoreController');

    Route::group(['prefix' => '/crawlers', 'as' => 'crawlers.'], function(){
    	Route::get('/{crawler}/run', 'CrawlerController@run')->name('run');
    	Route::get('/{crawler}/list-toggle', 'CrawlerController@listToggle')->name('list-toggle');
    	Route::get('/{crawler}/cards-toggle', 'CrawlerController@cardsToggle')->name('cards-toggle');
    });
    Route::resource('crawlers', 'CrawlerController');
});




Route::group(['prefix' => '/crawlers'], function()
{
	Route::get('/artofplay', function(){
		Artisan::call('db:seed', ['--class' => 'ArtOfPlayCrawlerSeeder']);
		Artisan::output();
	});

	Route::get('/ellusionist', function(){
		Artisan::call('db:seed', ['--class' => 'EllusionistCrawlerSeeder']);
		Artisan::output();
	});

	Route::get('/jpplayingcards', function(){
		Artisan::call('crawler:list:jpplayingcards');
		Artisan::output();
	});
});
