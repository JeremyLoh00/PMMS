<?php

namespace Database\Seeders;

use App\Models\Inventory;
use App\Models\InventoryList;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        \App\Models\User::factory(1)->create();

        Inventory::factory(10)->create();
        // Inventory::create([
        //     'name' => 'Coca Cola',
        //     'category' => 'Drinks',
        //     'cost' => 1.5,
        //     'price' => 2.5,
        //     'quantity' => 20,
        // ]);
        // Inventory::create([
        //     'name' => 'Coca Cola',
        //     'category' => 'Drinks',
        //     'cost' => 1.5,
        //     'price' => 2.5,
        //     'quantity' => 20,
        // ]);
    }
}
