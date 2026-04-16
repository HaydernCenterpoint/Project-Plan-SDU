<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'department_id',
        'status',
        'dob',
        'gender',
        'contact_email',
        'pending_profile',
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected $casts = [
        'email_verified_at' => 'datetime',
        'password' => 'hashed',
        'pending_profile' => 'array',
    ];

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }

    public function plans(): HasMany
    {
        return $this->hasMany(Plan::class); // Owned plans
    }

    public function executions(): HasMany
    {
        return $this->hasMany(PlanItem::class, 'executor_id');
    }

    public function mentoredItems(): HasMany
    {
        return $this->hasMany(PlanItem::class, 'mentor_id');
    }

    public function weeks(): HasMany
    {
        return $this->hasMany(PlanWeek::class);
    }
}
