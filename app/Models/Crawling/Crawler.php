<?php

namespace App\Models\Crawling;

use App\Models\Store;
use Illuminate\Database\Eloquent\Model;

class Crawler extends Model
{
	protected $table = 'crawling_crawlers';

	public function store()
	{
		return $this->belongsTo(Store::class);
	}
}
