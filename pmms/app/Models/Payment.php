<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Payment extends Model
{
    use HasFactory;
    protected $fillable = [
        'user_id',
        'totalPrice',
        'method',
    ];

    public function cart()
    {
        return $this->hasMany(Cart::class, 'cart_id');
    }
}
