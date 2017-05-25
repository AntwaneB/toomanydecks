<?php

use Illuminate\Database\Seeder;
use Goutte\Client;

use App\Models\Brand;
use App\Models\Card;
use App\Models\Variation;
use App\Models\Store;
use App\Models\Picture;

class ArtOfPlayCrawlerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $this->bicycles();
    }

	private function bicycles()
	{
		$listClient = new Client();
		$cardClient = new Client();

		$listCrawler = $listClient->request('GET', 'https://www.artofplay.com/collections/playing-cards/bicycle');

		$cards = [];

		// Access each item of the grid
		$listCrawler->filter('ul.collection__grid > .collection__grid-item')->each(function ($gridItem) use ($cardClient, &$cards) {
			// Get the URL of the individual page
			$cardUrl = $gridItem->filter('a.collection__product-link')->attr('href');

			// Crawl the card page
			$cardCrawler = $cardClient->request('GET', 'https://www.artofplay.com' . $cardUrl);

			$cardName = trim(preg_replace('#Bicycle® #', '', $cardCrawler->filter('.product__info .product__title div')->text()));
			$cardDescription = trim($cardCrawler->filter('.product__info .product__description')->text());
			$cardPrice = trim(preg_replace('#\$#', '', $cardCrawler->filter('.product__info .product__price')->text()));

			// Get the URL of the first image
			$firstImgURL = $cardCrawler->filter('li.product__slideshow-slide')->first()->attr('data-image-large-url');

			// Retrieve the image
			$imgData = file_get_contents('https:' . $firstImgURL);
			//file_put_contents('E:\\Cards Comparator\\backs\\' . str_slug($cardName) . '.png', $imgData);

			$cards[] = (object) [
				'name' => $cardName,
				'slug' => str_slug($cardName),
				'description' => $cardDescription,
				'price' => floatval($cardPrice),
				'image' => $imgData,
				'url' => 'https://www.artofplay.com' . $cardUrl,
			];
		});

		$brand = Brand::where('slug', 'bicycle')->firstOrFail();
		$store = Store::where('slug', 'art-of-play')->firstOrFail();

		foreach ($cards as $card)
		{
			$cardObj = Card::create([
				'brand_id' => $brand->id,
				'name' => $card->name,
				'slug' => $card->slug,
				'description' => $card->description,
			]);

			$variation = Variation::create([
				'card_id' => $cardObj->id,
				'name' => $card->name,
				'description' => '',
			]);

			$variation->stores()->attach($store->id, [
				'in_stock' => true,
				'price' => $card->price,
				'url' => $card->url,
			]);

			$imageName = $variation->id . '-' . DB::table('pictures')->max('id') + 1 . '-back-main.png';
			file_put_contents(public_path() . '/storage/cards/' . $imageName, $card->image);

			$picture = Picture::create([
				'variation_id' => $variation->id,
				'type' => 'back',
				'main' => true,
				'path' => '/storage/cards/' . $imageName,
			]);
		}
	}
}
