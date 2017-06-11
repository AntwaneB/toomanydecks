<?php

namespace App\Http\Controllers;

use App\Models\Brand;
use App\Models\Card;
use App\Models\Store;
use Illuminate\Http\Request;

class AppController extends Controller
{
    public function index()
	{
		$recentDecks = Card::with('pictures')
						   ->orderBy('created_at', 'DESC')
			               ->take(4)
						   ->get();

		$stats = (object) [
			'decksCount' => Card::count(),
			'brandsCount' => Brand::count(),
			'storesCount' => Store::count(),
		];

		return view('app.index', [
			'recentDecks' => $recentDecks,
			'stats' => $stats,
		]);
	}
}
