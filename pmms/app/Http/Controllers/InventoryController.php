<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class InventoryController extends Controller
{
    //Access inventory page and read data to list out on table
    function index(){
        $data=Inventory::paginate(5);
        return view('inventory.inventory', ['inventory' => $data]);
    }

    //Access add inventory page
    function create(){
        return view('inventory.add_inventory');
    }

    //Store data to database where data from add_inventory form
    function store(Request $request){

    $request->validate([
        'name' =>'required',
        'category' =>'required',
        'cost' =>"required|regex:/^\d+(\.\d{1,2})?$/",
        'price' =>"required|regex:/^\d+(\.\d{1,2})?$/",
        'quantity' =>'required|integer',
    ]);
    
       $inventory = new Inventory;
       $inventory->id=$request->id;
       $inventory->name=$request->name;
       $inventory->category=$request->category;
       $inventory->cost=$request->cost;
       $inventory->price=$request->price;
       $inventory->quantity=$request->quantity;
       $inventory->save();
       return redirect('/inventory')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
    }

     //Access edit inventory page pass data into it
     function edit($id){
        $data = Inventory::find($id);
        return view('inventory.edit_inventory', ['inventory' => $data]); //selected data pass inside the 'inventory' key used in edit_inventory
    }

    function update(Request $request, $id){
        $inventory=Inventory::find($id);
        // $data->name=$request->name;
        // $data->category=$request->category;
        // $data->cost=$request->cost;
        // $data->price=$request->price;
        // $data->quantity=$request->quantity;
        $input = $request->all();
        $inventory->update($input);
        return redirect('/inventory')->with('message', 'Update successful!');
    }
    //Delete item
    function delete($id)
    {
        Inventory::find($id)->delete();
  
        return redirect('/inventory')->with('message', 'Delete successful!');
    }

    function decrementQuantity(int $itemId){
        $data = Inventory::where('id', $itemId)->where('id',auth()->user()->id)->first();
        if($data){

            $data->decrement('quantity');
        }
    }
    function increment(Request $request, $id){
        $input = $request->quantity;
        Inventory::where('id', $id)->increment('quantity', $input);
        return redirect('/inventory')->with('message', 'Update successful!');
    }
}