<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();
$plan = App\Models\Plan::with('items')->find(23);
echo json_encode($plan->items, JSON_PRETTY_PRINT);
