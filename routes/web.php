<?php

if (App::environment('coming-soon')) {
	Route::get('/', 'AppController@comingSoon')->name('app.coming-soon');

	return;
}

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

    Route::group(['prefix' => '/crawlers', 'as' => 'crawlers.'], function()
    {
    	Route::group(['prefix' => '/{crawler}'], function() {
		    Route::get('/run/list', 'CrawlerController@runList')->name('run.list');
		    Route::get('/run/cards', 'CrawlerController@runCards')->name('run.cards');
		    Route::get('/list-toggle', 'CrawlerController@listToggle')->name('list-toggle');
		    Route::get('/cards-toggle', 'CrawlerController@cardsToggle')->name('cards-toggle');

		    Route::group(['prefix' => '/cards-data', 'as' => 'cards-data.'], function() {
				Route::post('/{cards_datum}/new-card', 'CardDataController@newCard')->name('new-card');
				Route::post('/{cards_datum}/new-variation', 'CardDataController@newVariation')->name('new-variation');
		    });
		    Route::resource('cards-data', 'CardDataController');
	    });
    });
    Route::resource('crawlers', 'CrawlerController');
});
