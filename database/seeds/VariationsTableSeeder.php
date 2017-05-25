<?php

use Illuminate\Database\Seeder;

use App\Models\Variation;

class VariationsTableSeeder extends Seeder
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
				'card_id' => 1,
				'name' => 'Red',
			],
			[
				'card_id' => 1,
				'name' => 'Blue',
			],
		];

		foreach ($data as $d)
			Variation::create($d);
    }
}
