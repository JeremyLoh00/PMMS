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
            'name' => $this->faker->word(),
            'category' => $this->faker->randomElement(['Food', 'Stationary', 'Drinks']),
            'cost' => $this->faker->randomFloat(2, 1, 10),
            'price' => $this->faker->randomFloat(2, 11, 20),
            'quantity' => $this->faker->numberBetween(3, 20),
        ];
    }
}
