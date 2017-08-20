<?php

namespace App\Models;

use App\Models\Crawling\CardData;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\DB;

class Variation extends Model
{
	use SoftDeletes;

    public function card()
	{
		return $this->belongsTo(Card::class);
	}

	public function pictures()
	{
		return $this->hasMany(Picture::class);
	}

	public function stores()
	{
		return $this->belongsToMany(Store::class)
					->orderBy(DB::Raw('price'), 'ASC')
					->withPivot(['in_stock', 'price', 'url', 'shipping']);
	}

	public function cardData()
	{
		return $this->hasMany(CardData::class);
	}
}
