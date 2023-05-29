<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class RosterFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
        return [
            //
            'user_id' => "1",
            'date' => "2023-05-13",
            'day' => "Monday",
            'week' => "2",
            'month' => "May",
            'time_in' => "0800",
            'time_out' => "1300",
            'total_hour' => "5",
            'rate' => "5.20",
            
        ];
    }
}
