<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

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
					->orderBy('price', 'ASC')
					->withPivot(['in_stock', 'price', 'url']);
	}
}
