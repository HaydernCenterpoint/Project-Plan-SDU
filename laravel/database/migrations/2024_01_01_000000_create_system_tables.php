<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('departments', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->unique();
            $table->timestamps();
        });

        Schema::create('personal_access_tokens', function (Blueprint $table) {
            $table->id();
            $table->morphs('tokenable');
            $table->string('name');
            $table->string('token', 64)->unique();
            $table->text('abilities')->nullable();
            $table->timestamp('last_used_at')->nullable();
            $table->timestamp('expires_at')->nullable();
            $table->timestamps();
        });

        Schema::create('users', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique(); // This column actually stores the USER CODE
            $table->timestamp('email_verified_at')->nullable();
            $table->string('password');
            $table->string('role')->default('TEACHER'); // ADMIN, BOARD, DEPT_HEAD, TEACHER, STUDENT
            $table->foreignId('department_id')->nullable()->constrained()->nullOnDelete();
            $table->rememberToken();
            $table->timestamps();
        });

        Schema::create('locations', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->nullable();
            $table->timestamps();
        });

        Schema::create('equipment', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->nullable();
            $table->integer('year_of_use')->nullable();
            $table->foreignId('location_id')->nullable()->constrained()->nullOnDelete();
            $table->timestamps();
        });

        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->string('title');
            $table->integer('month');
            $table->integer('year');
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // Plan owner
            $table->foreignId('department_id')->constrained()->cascadeOnDelete();
            $table->string('status')->default('DRAFT');
            $table->integer('score')->nullable();
            $table->text('feedback')->nullable();
            $table->timestamps();
        });

        Schema::create('plan_items', function (Blueprint $table) {
            $table->id();
            $table->foreignId('plan_id')->constrained()->cascadeOnDelete();
            $table->string('topic');
            $table->foreignId('location_id')->nullable()->constrained()->nullOnDelete();
            $table->foreignId('equipment_id')->nullable()->constrained()->nullOnDelete();
            $table->string('equipment_name_manual')->nullable(); // For equipment not in table
            $table->integer('equipment_year_manual')->nullable();
            $table->foreignId('executor_id')->nullable()->constrained('users')->nullOnDelete();
            $table->foreignId('mentor_id')->nullable()->constrained('users')->nullOnDelete();
            $table->string('time_range')->nullable();
            $table->text('expected_result')->nullable();
            $table->integer('planned_hours')->default(0);
            $table->string('type')->default('TEACHER'); // TEACHER or STUDENT
            $table->timestamps();
        });

        Schema::create('plan_weeks', function (Blueprint $table) {
            $table->id();
            $table->foreignId('plan_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // The one executing
            $table->string('week_label'); // 01-07, 08-14, 15-21, 22-28, 29-31
            $table->integer('planned_hours')->default(0);
            $table->integer('actual_hours')->nullable();
            $table->timestamps();
        });

        Schema::create('audit_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('plan_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->string('action');
            $table->text('comment')->nullable();
            $table->timestamp('timestamp');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('audit_logs');
        Schema::dropIfExists('plan_weeks');
        Schema::dropIfExists('plan_items');
        Schema::dropIfExists('plans');
        Schema::dropIfExists('equipment');
        Schema::dropIfExists('locations');
        Schema::dropIfExists('users');
        Schema::dropIfExists('departments');
    }
};
