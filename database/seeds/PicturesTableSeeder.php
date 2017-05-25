<?php

use Illuminate\Database\Seeder;

use App\Models\Picture;

class PicturesTableSeeder extends Seeder
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
				'variation_id' => 1,
				'type' => 'back',
				'main' => true,
				'path' => '/storage/cards/1-1-back-main.png',
			],
			[
				'variation_id' => 1,
				'type' => 'case',
				'main' => true,
				'path' => '/storage/cards/1-2-case-main.png',
			],
			[
				'variation_id' => 2,
				'type' => 'back',
				'main' => true,
				'path' => '/storage/cards/2-3-back-main.png',
			],
			[
				'variation_id' => 2,
				'type' => 'case',
				'main' => true,
				'path' => '/storage/cards/2-4-case-main.png',
			],
		];

		foreach ($data as $d)
			Picture::create($d);
    }
}
