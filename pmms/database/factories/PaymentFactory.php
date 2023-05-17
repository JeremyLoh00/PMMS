<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Payment;
use App\Models\User;

class PaymentFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */

    protected $model = Payment::class;
    /**
     * Define the model's default state.
     *
     * @return array
     */

    public function definition()
    {
        return [
            'user_id' => User::inRandomOrder()->pluck('id')->first(),
            'totalPrice' => $this->faker->randomFloat($nbMaxDecimals = 2, $min = 0, $max = 1000),
            'method' => \Arr::random([
                'Cash',
                'Card',
                'E-Wallet',
            ]),
        ];
    }
}
