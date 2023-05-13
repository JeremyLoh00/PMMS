<?php

namespace App\Http\Controllers;

use App\Models\user_list;
use Illuminate\Http\Request;

class user_controller extends Controller
{
    //
    public function create(){
        return view('User.add_user');
    }

    public function show(){
        $data=user_list::paginate(5);
        return view('User.view_user', ['user' => $data]);
    }

    function store(Request $request){

        $request->validate([
            'username' =>'required',
            'name' =>'required',
            'address' =>'required',
            'phone_num' =>'required',
            'email' =>'required',
            'role' =>'required',
            
        ]);
        
           $inventory = new user_list;
           $inventory->id=$request->id;
           $inventory->name=$request->name;
           $inventory->category=$request->category;
           $inventory->cost=$request->cost;
           $inventory->price=$request->price;
           $inventory->quantity=$request->quantity;
           $inventory->save();
           return redirect('/inventory')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
        }
}
