<?php

namespace App\Http\Controllers;

use App\Models\Inventory;
use App\Models\Cart;
use App\Models\Payment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Session;
use Carbon\Carbon;

class ReportController extends Controller
{
    function reports(Request $request){

        
        $filter = $request->input('filter');
      
        $dateRange = $this->getDateRange($filter);

        $selectText = $dateRange['selectText'];
        
       
        $items = DB::table('inventories')
            ->join('carts', 'inventories.id', '=', 'carts.inventory_id')
            ->select('inventories.quantity as inventory_quantity','carts.quantity as cart_quantity',
            'inventories.name as name','inventories.category as category', 'inventories.cost as cost', 'inventories.price as price')
            ->whereBetween('carts.created_at', [$dateRange['start'], $dateRange['end']])
            ->paginate(8);

        $total = DB::table('inventories')
            ->join('carts', 'inventories.id', '=', 'carts.inventory_id')
            ->select('inventories.quantity as inventory_quantity','carts.quantity as cart_quantity',
            'inventories.name as name','inventories.category as category', 'inventories.cost as cost', 'inventories.price as price')
            ->whereBetween('carts.created_at', [$dateRange['start'], $dateRange['end']])
            ->get();

        $totalProfit = 0;
        foreach ($total as $total) {
            $profitSum = ($total->price - $total->cost) * $total->cart_quantity;
            $totalProfit += $profitSum;
        }
     
        return view("report.report", ['items' => $items, 'totalProfit' => $totalProfit, 'selectText'=>$selectText ]);
    
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




    }

    private function getDateRange($filter)
    {
        
        $start = null;
        $end = null;
        $selectText= 'Today';

        if($filter == 'Daily'){

            $start = Carbon::now()->startOfDay();
            $end= Carbon::now()->endOfDay();
            $selectText ='Today';

        }elseif ($filter == 'weekly') {

            $start = Carbon::now()->startOfWeek();
            $end= Carbon::now()->endOfWeek();
            $selectText ='This Week';

        } elseif ($filter == 'monthly') {

            $start = Carbon::now()->startOfMonth();
            $end=Carbon::now()->endOfMonth();
            $selectText ='This Month';

        } elseif ($filter == 'yearly') {

            $start = Carbon::now()->startOfYear();
            $end=Carbon::now()->endOfYear();
            $selectText ='This Year';

        }

        return ['start' => $start, 'end' => $end, 'selectText'=>$selectText];
    }

   


 
     

    
}
