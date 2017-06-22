<?php

namespace App\Http\Controllers\Admin;

use App\Models\Crawling\Crawler;
use App\Models\Store;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Artisan;
use Symfony\Component\Console\Output\BufferedOutput;

class CrawlerController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $crawlers = Crawler::with('store')->get();

        return view('admin.crawlers.index', [
        	'crawlers' => $crawlers,
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
    	$stores = Store::whereDoesntHave('crawler')->orderBy('name')->get();

        return view('admin.crawlers.create', [
			'stores' => $stores,
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
        	'store' => 'required|exists:stores,id',
        	'list_url' => 'required',
        	'list_frequency' => 'required',
        	'cards_frequency' => 'required',
	        'individual_selector' => 'required',
	        'url_selector' => 'required',
	        'brand_selector' => '',
	        'name_selector' => '',
	        'description_selector' => '',
	        'in_stock_selector' => '',
	        'price_selector' => '',
        ]);

        $crawler = new Crawler();
        $crawler->store_id = $request->get('store');
        $crawler->list_url = $request->get('list_url');
        $crawler->list_frequency = $request->get('list_frequency');
        $crawler->cards_frequency = $request->get('cards_frequency');
        $crawler->individual_selector = $request->get('individual_selector');
        $crawler->url_selector = $request->get('url_selector');
        $crawler->brand_selector = $request->get('brand_selector');
        $crawler->name_selector = $request->get('name_selector');
        $crawler->description_selector = $request->get('description_selector');
        $crawler->in_stock_selector = $request->get('in_stock_selector');
        $crawler->price_selector = $request->get('price_selector');
        $crawler->save();

        return redirect()->route('admin.crawlers.show', $crawler);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function show(Crawler $crawler)
    {
    	$crawler->load('store');
    	$crawler->load('cardPages');

    	return view('admin.crawlers.show', [
    		'crawler' => $crawler,
	    ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function edit(Crawler $crawler)
    {
        $crawler->load('store');

        return view('admin.crawlers.edit', [
        	'crawler' => $crawler,
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Crawler $crawler)
    {
	    $this->validate($request, [
		    'list_url' => 'required',
		    'list_frequency' => 'required',
		    'cards_frequency' => 'required',
		    'individual_selector' => 'required',
		    'url_selector' => 'required',
		    'brand_selector' => '',
		    'name_selector' => '',
		    'description_selector' => '',
		    'in_stock_selector' => '',
		    'price_selector' => '',
	    ]);

	    $crawler->list_url = $request->get('list_url');
	    $crawler->list_frequency = $request->get('list_frequency');
	    $crawler->cards_frequency = $request->get('cards_frequency');
	    $crawler->individual_selector = $request->get('individual_selector');
	    $crawler->url_selector = $request->get('url_selector');
	    $crawler->brand_selector = $request->get('brand_selector');
	    $crawler->name_selector = $request->get('name_selector');
	    $crawler->description_selector = $request->get('description_selector');
	    $crawler->in_stock_selector = $request->get('in_stock_selector');
	    $crawler->price_selector = $request->get('price_selector');
	    $crawler->save();

	    return redirect()->route('admin.crawlers.show', $crawler);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function destroy(Crawler $crawler)
    {
        //
    }

    public function listToggle(Crawler $crawler)
    {
    	if ($crawler->list_state == 'ON')
    	    $crawler->list_state = 'OFF';
    	else if ($crawler->list_state == 'OFF')
    		$crawler->list_state = 'ON';
    	$crawler->save();

    	return redirect()->back();
    }

    public function cardsToggle(Crawler $crawler)
    {
    	if ($crawler->cards_state == 'ON')
    	    $crawler->cards_state = 'OFF';
    	else if ($crawler->cards_state == 'OFF')
    		$crawler->cards_state = 'ON';
    	$crawler->save();

    	return redirect()->back();
    }

    public function runList(Crawler $crawler)
    {
    	$crawler->load('store');

	    Artisan::call('crawler:list:' . $crawler->store->slug);
	    $output = Artisan::output();

	    if (empty($output))
	    {
	    	$output = trans('crawlers.no_output');
	    }

	    return redirect()->route('admin.crawlers.show', $crawler)->with(['output' => $output]);
    }

    public function runCards(Crawler $crawler)
    {
    	$crawler->load('store');

	    Artisan::call('crawler:cards:' . $crawler->store->slug);
	    $output = Artisan::output();

	    if (empty($output))
	    {
	    	$output = trans('crawlers.no_output');
	    }

	    return redirect()->route('admin.crawlers.show', $crawler)->with(['output' => $output]);
    }
}
