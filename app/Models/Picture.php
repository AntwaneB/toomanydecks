<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Picture extends Model
{
	use SoftDeletes;

    public function variation()
	{
		return $this->belongsTo(Variation::class);
	}
}
