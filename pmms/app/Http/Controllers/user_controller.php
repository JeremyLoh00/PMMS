<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class user_controller extends Controller
{
    //
    public function create(){
        return view('User.add_user');
    }

    public function show(){
        $data=User::paginate(5);
        return view('User.view_user', ['user' => $data]);
    }
}
