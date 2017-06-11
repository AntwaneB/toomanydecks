<?php

namespace App\Http\Controllers\Admin;

use App\Models\Variation;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Validation\Rule;

class VariationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Variation  $variation
     * @return \Illuminate\Http\Response
     */
    public function show(Variation $variation)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Variation  $variation
     * @return \Illuminate\Http\Response
     */
    public function edit(Variation $variation)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Variation  $variation
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Variation $variation)
    {
		$this->validate($request, [
			'name' => 'required',
			'description' => '',
			'variation_stores.*.store' => 'required|exists:stores,id',
			'variation_stores.*.in_stock' => ['required', Rule::in(['1', '0'])],
			'variation_stores.*.price' => 'required|numeric|min:0',
			'variation_stores.*.url' => 'required|url',
		]);

		$stores = [];
		foreach ($request->get('variation_stores') as $store)
		{
			$stores[$store['store']] = [
				'in_stock' => $store['in_stock'],
				'price' => $store['price'],
				'url' => $store['url'],
			];
		}

		$variation->name = $request->get('name');
		$variation->description = $request->get('description');
		$variation->stores()->sync($stores);

		return redirect()->route('admin.cards.show', $variation->card_id);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Variation  $variation
     * @return \Illuminate\Http\Response
     */
    public function destroy(Variation $variation)
    {
        //
    }
}
