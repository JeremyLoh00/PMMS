<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\user_list;
use Illuminate\Http\Request;

class user_controller extends Controller
{
    //
    public function create(){
        return view('User.add_user');
    }

    public function show(){
        $users = User::paginate(5);
        return view('User.view_user', ['user' => $users]);
    }
    

    function store(Request $request){

        $formfields = $request->validate([
            'username' =>'required',
            'name' =>'required',
            'address' =>'required',
            'phone_num' =>'required',
            'email' =>'required',
            'password' => "required|min:6",
            'role' =>'required',
            
            
        ]);
        
          User::create($formfields);
           return redirect('/users')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
        }
}
