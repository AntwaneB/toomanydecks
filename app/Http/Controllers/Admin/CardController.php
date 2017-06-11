<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Brand;
use App\Models\Card;
use App\Models\Store;
use App\Models\Variation;
use Illuminate\Http\Request;

class CardController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $cards = Card::with('variationsCount')
                     ->with('brand')
                     ->orderBy('name')
					 ->paginate(24);

		return view('admin.cards.index', [
			'cards' => $cards,
		]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $brands = Brand::get();

        return view('admin.cards.create', [
            'brands' => $brands,
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
            'brand' => 'exists:brands,id',
            'name' => 'required',
            'description' => '',
            'variations.*.name' => 'required',
            'variations.*.description' => '',
        ]);

        $card = new Card();
        $card->brand_id = $request->get('brand');
        $card->name = $request->get('name');
        $card->slug = str_slug($request->get('name'));
        $card->description = $request->get('description');
        $card->save();

        if ($request->has('variations'))
        {
            foreach ($request->get('variations') as $variation)
            {
                $variation = new Variation();
                $variation->card_id = $card->id;
                $variation->name = $request->get('name');
                $variation->description = $request->get('description');
                $variation->save();
            }
        }
        else
        {
            $defaultVariation = new Variation();
            $defaultVariation->card_id = $card->id;
            $defaultVariation->name = $card->name;
            $defaultVariation->save();
        }

        return redirect()->route('admin.cards.show', $card->id);
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function show(Card $card)
    {
		$card->load('brand');
		$card->load('variations.stores');
		$card->load('variations.pictures');

		$stores = Store::orderBy('name')->get();

        return view('admin.cards.show', [
			'card' => $card,
            'stores' => $stores,
		]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function edit(Card $card)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Card $card)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function destroy(Card $card)
    {
        $card->delete();

        return redirect()->route('admin.cards.index');
    }
}
