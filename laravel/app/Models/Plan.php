<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Plan extends Model
{
    protected $fillable = [
        'code',
        'title',
        'month',
        'year',
        'user_id',
        'department_id',
        'status',
        'score',
        'feedback',
        'attached_file_path',
        'attached_file_name',
        'attachments',
    ];

    protected $casts = [
        'attachments' => 'array',
    ];

    public function teacher(): BelongsTo
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function department(): BelongsTo
    {
        return $this->belongsTo(Department::class);
    }

    public function items(): HasMany
    {
        return $this->hasMany(PlanItem::class);
    }

    public function weeks(): HasMany
    {
        return $this->hasMany(PlanWeek::class);
    }

    public function auditLogs(): HasMany
    {
        return $this->hasMany(AuditLog::class);
    }
}
