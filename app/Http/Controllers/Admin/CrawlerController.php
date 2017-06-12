<?php

namespace App\Http\Controllers\Admin;

use App\Models\Crawling\Crawler;
use App\Models\Store;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

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
    	$stores = Store::orderBy('name')->get();

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
        ]);

        $crawler = new Crawler();
        $crawler->store_id = $request->get('store');
        $crawler->list_url = $request->get('list_url');
        $crawler->list_frequency = $request->get('list_frequency');
        $crawler->cards_frequency = $request->get('cards_frequency');
        $crawler->save();

        return redirect()->route('admin.crawlers.index');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function show(Crawler $crawler)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Crawling\Crawler  $crawler
     * @return \Illuminate\Http\Response
     */
    public function edit(Crawler $crawler)
    {
        //
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
        //
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
}
