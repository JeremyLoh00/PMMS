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
            'date' => "13/5/2023",
            'day' => "Monday",
            'week' => "2",
            'month' => "May",
            'time_in' => "8",
            'time_out' => "10",
            'total_hour' => "5",
            'rate' => "5.20",
            
        ];
    }
}
