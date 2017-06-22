<?php

namespace App\Models\Crawling;

use Illuminate\Database\Eloquent\Model;

class CardPage extends Model
{
	protected $table = 'crawling_card_pages';

	protected $fillable = ['url', 'crawler_id'];

	public function crawler()
	{
		return $this->belongsTo(Crawler::class);
	}
}
