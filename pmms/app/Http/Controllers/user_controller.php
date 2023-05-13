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
        $data=User::paginate(5);
        return view('User.view_user', ['user' => $data]);
    }

    function store(Request $request){

        $formfields = $request->validate([
            'username' =>'required',
            'name' =>'required',
            'address' =>'required',
            'phone_num' =>'required',
            'email' =>'required',
            'role' =>'required',
            'password' => "required|min:6"
            
        ]);
        
          User::create($formfields);
           return redirect('/view_user')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
        }
}
