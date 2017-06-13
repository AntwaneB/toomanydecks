<?php

namespace App\Models;

use App\Models\Crawling\Crawler;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Store extends Model
{
	use SoftDeletes;

	public function variations()
	{
		return $this->belongsToMany(Variation::class);
	}

	public function crawler()
	{
		return $this->hasOne(Crawler::class);
	}
}
