<?php

namespace App\Http\Controllers\Admin;

use App\Models\Card;
use App\Models\Crawling\CardData;
use App\Models\Crawling\Crawler;
use App\Models\Variation;
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
	        	$explodedName = array_diff($explodedName, [
	        		'playing',
			        'card',
			        'cards',
		        ]);

	        	$potentialMatches = Card::where('slug', 'LIKE', '%' . $explodedName[0] . '%');
	        	foreach ($explodedName as $segment)
	        		$potentialMatches = $potentialMatches->orWhere('slug', 'LIKE', '%' . $segment . '%');
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

	    if ($request->has('variation'))
	    {
		    $cardsDatum->load('cardPage');

			$variation = Variation::with('stores')->findOrFail($cardsDatum->variation_id);
			if ($variation->stores->contains($crawler->store_id))
			{
				$variation->stores()->updateExistingPivot($crawler->store_id, [
					'in_stock' => $cardsDatum->in_stock,
					'price' => $cardsDatum->price,
					'url' => $cardsDatum->cardPage->url,
				]);
			}
			else
			{
				$variation->stores()->attach($crawler->store_id, [
					'in_stock' => $cardsDatum->in_stock,
					'price' => $cardsDatum->price,
					'url' => $cardsDatum->cardPage->url,
				]);
			}
	    }

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

    public function newCard(Crawler $crawler, CardData $cardsDatum)
    {
		$card = new Card();
		$card->brand_id = $cardsDatum->brand_id;
		$card->name = ucwords(strtolower($cardsDatum->name));
		$card->slug = str_slug($cardsDatum->name);
		$card->description = $cardsDatum->description;
		$card->save();

		$cardsDatum->card_id = $card->id;
		$cardsDatum->save();

		$this->newVariation($crawler, $cardsDatum);

		return redirect()->back();
    }

	public function newVariation(Crawler $crawler, CardData $cardsDatum)
	{
		$variation = new Variation();
		$variation->card_id = $cardsDatum->card_id;
		$variation->name = ucwords(strtolower($cardsDatum->name));
		$variation->description = $cardsDatum->description;
		$variation->save();

		$cardsDatum->variation_id = $variation->id;
		$cardsDatum->save();

		$variation->stores()->attach($crawler->store_id, [
			'in_stock' => $cardsDatum->in_stock,
			'price' => $cardsDatum->price,
			'url' => $cardsDatum->cardPage->url,
		]);

		return redirect()->back();
	}
}
