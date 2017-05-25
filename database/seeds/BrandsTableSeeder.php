<?php

use Illuminate\Database\Seeder;

use App\Models\Brand;

class BrandsTableSeeder extends Seeder
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
				'name' => 'Bicycle',
				'slug' => 'bicycle',
				'description' => 'The United States Playing Card Company creates the world’s best playing cards. For over 125 years, they have been called ‘First in Fun’ for bringing people together in the name of good games and great company.',
				'website' => 'http://www.bicyclecards.com/',
			],
			[
				'name' => 'Ellusionist',
				'slug' => 'ellusionist',
				'description' => "Ellusionist was founded on January 1st, 2001 by Brad Christian.\n\nHis goal was simple — to create the best online training environment for people who want to learn high-impact, effective magic tricks. Ellusionist's growth has been unprecedented.",
				'website' => 'http://www.ellusionist.com/',
			],
			[
				'name' => 'Theory11',
				'slug' => 'theory11',
				'description' => 'Since 2007, theory11 has propelled forward to become the largest community of magic creators, with over 1,500 registered artists and hundreds of thousands of members around the world.',
				'website' => 'https://www.theory11.com/',
			],

		];

		foreach ($data as $d)
			Brand::create($d);
    }
}
