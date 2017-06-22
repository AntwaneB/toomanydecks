<?php

namespace App\Models\Crawling;

use App\Models\Brand;
use App\Models\Card;
use App\Models\Variation;
use Illuminate\Database\Eloquent\Model;

class CardData extends Model
{
	protected $table = 'crawling_card_data';

	protected $fillable = ['card_page_id'];

	protected $casts = [
		'in_stock' => 'boolean',
	];

	public function cardPage()
	{
		return $this->belongsTo(CardPage::class);
	}

	public function card()
	{
		return $this->belongsTo(Card::class);
	}

	public function brand()
	{
		return $this->belongsTo(Brand::class);
	}

	public function variation()
	{
		return $this->belongsTo(Variation::class);
	}
}
