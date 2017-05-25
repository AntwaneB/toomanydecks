<?php

use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->call(BrandsTableSeeder::class);
        $this->call(CardsTableSeeder::class);
        $this->call(VariationsTableSeeder::class);
        $this->call(PicturesTableSeeder::class);
        $this->call(StoresTableSeeder::class);
    }
}
