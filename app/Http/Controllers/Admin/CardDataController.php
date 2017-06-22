<?php

namespace App\Http\Controllers\Admin;

use App\Models\Card;
use App\Models\Crawling\CardData;
use App\Models\Crawling\Crawler;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use TomLingham\Searchy\Facades\Searchy;

class CardDataController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Crawler $crawler)
    {
        $cardsData = CardData::whereHas('cardPage.crawler', function ($q) use ($crawler) {
	                            $q->where('crawling_crawlers.id', $crawler->id);
					         })
	                         ->with('cardPage')
	                         ->with('card.variations')
	                         ->with('variation')
	                         ->with('brand')
	                         ->paginate(10);

        foreach ($cardsData as &$cardData)
        {
        	if (empty($cardData->card_id))
	        {
	        	$explodedName = explode('-', str_slug($cardData->name));

	        	$potentialMatches = Card::where('slug', 'LIKE', '%' . $explodedName[0] . '%');
	        	for ($i = 1; $i < count($explodedName); $i++)
	        		$potentialMatches = $potentialMatches->orWhere('slug', 'LIKE', '%' . $explodedName[$i] . '%');
	        	$potentialMatches = $potentialMatches->get();

	        	foreach ($potentialMatches as &$potentialMatch)
		        {
		        	$reference = preg_replace('#\-#', ' ', str_slug($cardData->name));
		        	$other = preg_replace('#\-#', ' ', $potentialMatch->slug);

		        	$similarWords = count(array_intersect(explode(' ', $reference), explode(' ', $other)));
			        $similarWords = $similarWords == 0 ? 1 : $similarWords;

		        	$potentialMatch->simple_distance = levenshtein($reference, $other, 1, 5, 1);
		        	$potentialMatch->metaphone_distance = levenshtein(metaphone($reference), metaphone($other), 1, 5, 1);

		        	$potentialMatch->total_distance = ($potentialMatch->simple_distance + $potentialMatch->metaphone_distance) / $similarWords;
		        }
		        $potentialMatches = $potentialMatches->sortBy('total_distance');

	            $cardData->potential_matches = $potentialMatches;
	        }
        }

        return view('admin.cards-data.index', [
        	'cardsData' => $cardsData,
	        'crawler' => $crawler,
        ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Crawling\CardData  $cardData
     * @return \Illuminate\Http\Response
     */
    public function show(Crawler $crawler, CardData $cardsDatum)
    {
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Crawling\CardData  $cardData
     * @return \Illuminate\Http\Response
     */
    public function edit(Crawler $crawler, CardData $cardsDatum)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Crawling\CardData  $cardData
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Crawler $crawler, CardData $cardsDatum)
    {
        $this->validate($request, [
        	'card' => 'exists:cards,id',
        	'variation' => 'exists:variations,id',
        ]);

        if ($request->has('card'))
	        $cardsDatum->card_id = $request->get('card');
        if ($request->has('variation'))
	        $cardsDatum->variation_id = $request->get('variation');
	    $cardsDatum->save();

        return redirect()->back();
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Crawling\CardData  $cardData
     * @return \Illuminate\Http\Response
     */
    public function destroy(Crawler $crawler, CardData $cardsDatum)
    {
        //
    }
}
