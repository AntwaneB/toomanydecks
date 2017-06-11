<?php

use Illuminate\Database\Seeder;
use GuzzleHttp\Client;

class EllusionistCrawlerSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $apiURL = 'http://live.4-tell.net/Boost2.0/rest/GetMultiToutRec?format=json&clientAlias=ellusion&pageType=other';
        $requestBody = '[{"Columns":"id,pl,rt,pr,sp,il,nm,at1,at2,at3","FillMode":"none","NumResults":12,"ProductIDs":"","ResultType":5,"StartPosition":1,"Att1IDs":"4","BlockIDs":"","CartIDs":"","ClickStreamIDs":"BLACKERDNASE,BICYCLEDECK"}]';

        $listClient = new Client();

        $cardsList = json_decode($listClient->request('POST', $apiURL, ['body' => $requestBody])->getBody()->getContents());

        var_dump($cardsList);
    }
}
