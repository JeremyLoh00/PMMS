<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Inventory extends Model
{
    use HasFactory;
    public $timestamps=false;
    protected $fillable = ['name', 'category', 'cost', 'price', 'quantity'];
    function scopeFilter($query, array $filters){
        if($filters['search'] ?? false){
            $query->where('name', 'like', '%'.request('search').'%')
            ->orWhere('category', 'like', '%'.request('search').'%');
        }
    }
}
