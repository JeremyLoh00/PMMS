<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class InventoryFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            'name' => \Arr::random([
                'Maggi',
                'Massimo',
                'Gardenia',
                'Sandwich',
                'Cake',
            ]),
            'category' => \Arr::random([
                'Foods',
            ]),
            'cost' => $this->faker->randomDigit(),
            'price' => $this->faker->randomDigit(),
            'quantity' => $this->faker->randomDigit(),
        ];
    }
}
