<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();
// We will grab the latest plan
$plan = App\Models\Plan::with('items')->latest()->first();
echo "Latest Plan ID: " . $plan->id . "\n";
echo "Status: " . $plan->status . "\n";
echo json_encode($plan->items, JSON_PRETTY_PRINT);
