<?php

namespace Database\Seeders;

use App\Models\Inventory;
use App\Models\Roster;
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
        \App\Models\User::factory()->create(
        [
            'username' => "CB20182",
            'name' => "AHMAD KHAIRUL IMAN BIN AHMAD SAYUTI",
            'address' => "No19, jln teratai, tmn idaman, 48200 serendah selangor.",
            'phone_num' => "0182617468",
            'email' => "admin@admin.com",
            'password' => bcrypt("admin1234"), // password
            'role' => "Admin",
        ]);
        
        Inventory::factory(10)->create();
        Roster::factory(1)->create();
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
