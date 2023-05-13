<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\user_list;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Hash;

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
            'username' => ['required', Rule::unique('users','username')],
            'name' =>'required',
            'address' =>'required',
            'phone_num' =>'required',
            'email' => ['required', 'email', Rule::unique('users','email')],
            'password' => ["required", "min:6"],
            
            'role' =>'required',
        ]);
        
    
        $formfields['password'] = Hash::make($request->password);
    
        User::create($formfields);
        return redirect('/users')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
    }
    

        function index($id){
            $data = User::find($id);
            return view('User.edit_user', ['user' => $data]); //selected data pass inside the 'user' key used in edit_user
        }

        function update(Request $request, $id){
            $user = User::find($id);
            $validatedData = $request->validate([
                'name' =>'required',
                'address' =>'required',
                'phone_num' =>'required',
                'email' => 'required|email|unique:users,email,'.$id,
                'role' => 'required',
                'password' => 'nullable|min:6|confirmed',
            ]);
        
            // Check if a new password is provided
            if ($request->filled('password')) {
                $validatedData['password'] = bcrypt($request->password);
            } else {
                // If not, keep the old password
                $validatedData['password'] = $user->password;
            }
        
            if($user->update($validatedData)){
                return redirect('/users')->with('message', 'Update successful!');
            } else {
                return redirect('/users')->with('error', 'Update failed!');
            }
        }
        
        
        

        function delete($id)
        {
            User::find($id)->delete();
      
            return redirect('/users')->with('message', 'Delete successful!');
        }
        
}
