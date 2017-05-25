<?php

use Illuminate\Database\Seeder;

use App\Models\Card;

class CardsTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $data = [
			[
				'brand_id' => 1,
				'name' => 'Standard Index',
				'slug' => 'standard-index',
				'description' => "The Deck that Started It All\n\nDo you remember learning your first card game? How about winning at an old-fashioned game of solitaire? Or that holiday tradition of Gin Rummy after dinner? Since 1885, Bicycle playing cards have been a part of household gaming. Known for its quality and rich heritage, Bicycle® playing cards have been bringing people together for generations.\n\nEvery Bicycle® playing card deck is specially crafted so that you can trust Bicycle® cards performance, hand after hand. Great for all card games. Great for all players."
			],
		];

		foreach ($data as $d)
			Card::create($d);
    }
}
