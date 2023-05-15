<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class InventoryController extends Controller
{
    //Access inventory page and read data to list out on table
    function index()
    {
        // if (empty($request->all())) {
        $data = Inventory::paginate(5);
        $threshold = 5;

        // Retrieve items with low stock
        $lowStockItems = Inventory::where('quantity', '<=', $threshold)->get();
        if ($lowStockItems->count() > 0) {
            $message = 'Low stock alert for items: ';

            // Build the message with item names and stock quantities
            foreach ($lowStockItems as $item) {
                $message .= "\n'{$item->name}'";
                // "\nItem '{$item->name}' has only {$item->quantity} items left.";
            }

            // Store the alert message in the session
            Session::flash('alert', $message);
            Session::flash('alert-type', 'warning');
        }


        return view('inventory.inventory', ['inventory' => $data]);
    }

    //Access add inventory page
    function create()
    {
        return view('inventory.add_inventory');
    }

    //Store data to database where data from add_inventory form
    function store(Request $request)
    {

        $request->validate([
            'name' => 'required',
            'category' => 'required',
            'cost' => "required|regex:/^\d+(\.\d{1,2})?$/",
            'price' => "required|regex:/^\d+(\.\d{1,2})?$/",
            'quantity' => 'required|integer',
        ]);

        $inventory = new Inventory;
        $inventory->id = $request->id;
        $inventory->name = $request->name;
        $inventory->category = $request->category;
        $inventory->cost = $request->cost;
        $inventory->price = $request->price;
        $inventory->quantity = $request->quantity;
        $inventory->save();
        return redirect('/inventory')->with('message', 'Add successful!'); //redirect back to inventory page, call the route
    }

    //Access edit inventory page pass data into it
    function edit($id)
    {
        $data = Inventory::find($id);
        return view('inventory.edit_inventory', ['inventory' => $data]); //selected data pass inside the 'inventory' key used in edit_inventory
    }

    function update(Request $request, $id)
    {
        $inventory = Inventory::find($id);
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
    //Add stock page
    function add($id)
    {
        $data = Inventory::find($id);
        return view('inventory.add_stock', ['inventory' => $data]);
    }
    //Add stock update
    function increment(Request $request, $id)
    {
        $input = $request->quantity;
        Inventory::where('id', $id)->increment('quantity', $input);
        return redirect('/inventory')->with('message', 'Stock update successful!');
    }
    //Deduct stock page
    function deduct($id)
    {
        $data = Inventory::find($id);
        return view('inventory.deduct_stock', ['inventory' => $data]);
    }
    //Update deduct stock
    function decrement(Request $request, $id)
    {
        $input = $request->quantity;
        Inventory::where('id', $id)->decrement('quantity', $input);
        return redirect('/inventory')->with('message', 'Stock update successful!');
    }
    function checkLowStock()
    {
        $threshold = 5;

        // Retrieve products with low stock
        $lowStockProducts = Inventory::where('quantity', '<=', $threshold)->get();

        // Trigger an alert for each low stock product
        foreach ($lowStockProducts as $inventory) {
            // Set the alert message
            $message = "Low stock alert: Product '{$inventory->name}' has only {$inventory->quantity} items left.";

            // Store the alert message in the session
            Session::flash('alert', $message);
            Session::flash('alert-type', 'warning'); // You can customize the alert type (e.g., success, warning, error)
        }
    }

    // public function search(Request $request)
    // {
    //     $query = $request->input('query');

    //     $items = Inventory::where('name', 'like', '%' . $query . '%')
    //         ->paginate(10);

    //     return view('inventory.inventory', compact('items'));
    // }

    //Access inventory page and read data to list out on table
    function search(Request $request)
    {

        $query = $request->input('query');

        $data = Inventory::when($query, function ($queryBuilder) use ($query) {
            $queryBuilder->where('name', 'like', '%' . $query . '%')
                ->orWhere('category', 'like', '%' . $query . '%');
        })
            ->paginate(10);

        return view('inventory.inventory', ['inventory' => $data]);
    }
}
