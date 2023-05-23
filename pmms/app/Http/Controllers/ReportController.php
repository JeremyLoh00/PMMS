<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use App\Models\Cart;
use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;

class ReportController extends Controller
{
    function show(){

        
       

        
         //$Data = $this->belongsTo('');

  
       

        // $name = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('name')->get();
        // $category = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('category')->get();
        // $invQuantity = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('inventories.quantity')->get();
        // $cartQuantity = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('carts.quantity')->get();
        
        // $price = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('inventories.price')->get();
        // $cost = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('inventories.cost')->get();
        
        
        
        //dd($InvQuantity);
        // dd($profitPrice); 
        //dd($data);
      

        $items = DB::table('inventories')->join('carts', 'inventories.id', '=', 'carts.inventory_id')->paginate(8);

        $total = DB::table('inventories')->join('carts', 'inventories.id', '=', 'carts.inventory_id')->get();

        $totalProfit = 0;
		foreach ($total as $total) {
			$profitSum = ($total->cost - $total->price) * $total->cart_quantity;
			$totalProfit += $profitSum;
		}


       
        //$InventoryQuantity = DB::table('inventories')->join('carts','inventories.id','=','carts.inventory_id')->select('inventories.quantity')->get();
		return view("report.report", ['items' => $items,'totalProfit' => $totalProfit]);

        //['inventory' => $InventoryData],['cart' => $CartDate]
       // ['name' => $name],['category' => $category],['invQuantity' => $invQuantity],['cartQuantity' => $cartQuantity],['cartQuantity' => $cartQuantity],['price' => $price], ['cost' => $cost]  
    }

   
        function searchReport(Request $request)
    {

        $query = $request->input('query');


        $data = DB::table('inventories')->join('carts', 'inventories.id', '=', 'carts.inventory_id')->when($query, function ($queryBuilder) use ($query) {
            $queryBuilder->where('name', 'like', '%' . $query . '%')
                ->orWhere('category', 'like', '%' . $query . '%');
        })
            ->paginate(10);

            
        return view('report.report', ['items' => $data]);

        // $data = Inventory::when($query, function ($queryBuilder) use ($query) {
        //     $queryBuilder->where('name', 'like', '%' . $query . '%')
        //         ->orWhere('category', 'like', '%' . $query . '%');
        // })
        //     ->paginate(10);

    }

 
     

    
}
