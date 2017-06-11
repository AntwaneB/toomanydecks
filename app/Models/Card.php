<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Card extends Model
{
	use SoftDeletes;

    public function brand()
	{
		return $this->belongsTo(Brand::class);
	}

	public function variations()
	{
		return $this->hasMany(Variation::class);
	}

	public function pictures()
	{
		return $this->hasManyThrough(Picture::class, Variation::class);
	}

    public function variationsCount()
    {
        return $this->hasOne(Variation::class)
            ->selectRaw('card_id, count(*) as aggregate')
            ->groupBy('card_id');
    }

	/*
	 * Accessors
	 */
	public function getMainBackPictureAttribute()
	{
		if (!array_key_exists('pictures', $this->relations))
			$this->load('pictures');

		$mainPicture = $this->pictures->filter(function($picture){
			return $picture->type == 'back' && $picture->main == true;
		})->first();

		return $mainPicture;
	}

	public function getMainFrontPictureAttribute()
	{
		if (!array_key_exists('pictures', $this->relations))
			$this->load('pictures');

		$mainPicture = $this->pictures->filter(function($picture){
			return $picture->type == 'front' && $picture->main == true;
		})->first();

		return $mainPicture;
	}

	public function getMainCasePictureAttribute()
	{
		if (!array_key_exists('pictures', $this->relations))
			$this->load('pictures');

		$mainPicture = $this->pictures->filter(function($picture){
			return $picture->type == 'case' && $picture->main == true;
		})->first();

		return $mainPicture;
	}

	public function getSplashPictureAttribute()
	{
		if (!array_key_exists('pictures', $this->relations))
			$this->load('pictures');

		$mainPicture = $this->pictures->filter(function($picture){
			return $picture->type == 'splash';
		})->first();

		return $mainPicture;
	}

    public function getVariationsCountAttribute()
    {
        if (!array_key_exists('variationsCount', $this->relations))
            $this->load('variationsCount');

        $related = $this->getRelation('variationsCount');

        return $related ? (int) $related->aggregate : 0;
    }
}
