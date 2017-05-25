<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Brand extends Model
{
	use SoftDeletes;

    public $timestamps = false;

	public function cards()
	{
		return $this->hasMany(Card::class);
	}

	public function variations()
	{
		return $this->hasManyThrough(Variation::class, Card::class);
	}

	public function cardsCount()
	{
		return $this->hasOne(Card::class)
					->selectRaw('brand_id, count(*) as aggregate')
					->groupBy('brand_id');
	}

	/*
	 * Accessors
	 */
	public function getCardsCountAttribute()
	{
		if (!array_key_exists('cardsCount', $this->relations))
			$this->load('cardsCount');

		$related = $this->getRelation('cardsCount');

		return $related ? (int) $related->aggregate : 0;
	}
}
