<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Equipment extends Model
{
    protected $fillable = ['name', 'code', 'year_of_use', 'location_id'];

    public function location(): BelongsTo
    {
        return $this->belongsTo(Location::class);
    }
}
