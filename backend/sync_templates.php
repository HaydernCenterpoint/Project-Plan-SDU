<?php
require 'vendor/autoload.php';
$app = require_once 'bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use App\Models\PlanItem;

$items = PlanItem::all();
$updatedCount = 0;

foreach ($items as $item) {
    if (!$item->expected_result) continue;
    
    // PHP tries to decode the JSON column if it contains strings
    $data = json_decode($item->expected_result, true);
    if (!is_array($data)) continue;

    $updated = false;

    // Migrate old templates to new ones
    if (isset($data['col1']) && !isset($data['chu_de'])) {
        $data['chu_de'] = $data['col1'];
        unset($data['col1']);
        $updated = true;
    }
    
    if (isset($data['col2']) && !isset($data['ket_qua'])) {
        $data['ket_qua'] = $data['col2'];
        unset($data['col2']);
        $updated = true;
    }
    
    if ($updated) {
        $item->expected_result = json_encode($data, JSON_UNESCAPED_UNICODE);
        $item->save();
        $updatedCount++;
    }
}

echo "Successfully synchronized/migrated {$updatedCount} old plan items to the new data schema.\n";
