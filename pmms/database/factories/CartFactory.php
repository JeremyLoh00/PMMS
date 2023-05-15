<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Cart;
use App\Models\Payment;
use App\Models\Inventory;

class CartFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */

    protected $model = Cart::class;
    /**
     * Define the model's default state.
     *
     * @return array
     */

    public function definition()
    {
        return [
            'payment_id' => Payment::inRandomOrder()->pluck('id')->first(),
            'inventory_id' => Inventory::inRandomOrder()->pluck('id')->first(),
            'quantity' => $this->faker->randomDigit(2),
        ];
    }
}
