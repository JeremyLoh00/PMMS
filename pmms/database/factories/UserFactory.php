<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Str;

class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array
     */
    public function definition()
    {
      
    
       
        return [
            'username' => "CB20182",
            'name' => "AHMAD KHAIRUL IMAN BIN AHMAD SAYUTI",
            'address' => "No19, jln teratai, tmn idaman, 48200 serendah selangor.",
            'phone_num' => "0182617468",
            'email' => "akmafarah84@gmail.com",
            'password' => 'iman2617', // password
            'role' => "Admin",
         
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     *
     * @return \Illuminate\Database\Eloquent\Factories\Factory
     */
    public function unverified()
    {
        return $this->state(function (array $attributes) {
            return [
                'email_verified_at' => null,
            ];
        });
    }
}
