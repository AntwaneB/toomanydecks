<?php

namespace App\Models\Crawling;

use Illuminate\Database\Eloquent\Model;

class CardPage extends Model
{
    protected $connection = 'crawling';

	protected $fillable = ['url', 'crawler_id'];

	public function crawler()
	{
		return $this->belongsTo(Crawler::class);
	}
}
