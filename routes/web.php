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
});
