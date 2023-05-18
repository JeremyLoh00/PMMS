<?php

namespace App\Http\Controllers;

use App\Models\Roster;
use Illuminate\Http\Request;
use Carbon\Carbon;

class roster_controller extends Controller
{
    //
    public function create(Request $request){
        $userRole = session('role');
        $month = $request->query('month');
      
        $monthNumber = null;

        switch ($month) {
            case "January":
                $monthNumber = 1;
                break;
            case "February":
                $monthNumber = 2;
                break;
            case "March":
                $monthNumber = 3;
                break;
            case "April":
                $monthNumber = 4;
                break;
            case "May":
                $monthNumber = 5;
                break;
            case "June":
                $monthNumber = 6;
                break;
            case "July":
                $monthNumber = 7;
                break;
            case "August":
                $monthNumber = 8;
                break;
            case "September":
                $monthNumber = 9;
                break;
            case "October":
                $monthNumber = 10;
                break;
            case "November":
                $monthNumber = 11;
                break;
            case "December":
                $monthNumber = 12;
                break;
            default:
                $monthNumber = null;
                break;
        }

    $currentYear = Carbon::now()->year;// Set the desired year

    $startDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->startOfMonth();
    $endDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->endOfMonth();
    
    $dates = [];
    $days = [];
    $currentDate = $startDate;
    
    while ($currentDate <= $endDate) {
        $dates[] = $currentDate->format('d/m/Y');
        $days[] = $currentDate->format('l');
        $currentDate->addDay();
    }

   
    



        

    if ($userRole === 'Admin') {
    
         return view('roster.add_schedule_time_page',['month' => $month, 'dates' => $dates, 'days' => $days,]);
    } elseif (($userRole === 'Cashier')){
        return view('roster.add_schedule_page');
    }
    else{
        return view('auth.login');
    }
        
    }

    public function showlistadmin(){
        //$roster = roster::paginate(5);
        return view('roster.admin_schedule_page', ['']);
    }

    function indexadmin(){
        //$data = roster::find($id);
        return view('roster.edit_schedule_time_page'); //selected data pass inside the 'user' key used in edit_schedule_time
    }

    public function showlistcommittee(){
        //$roster = roster::paginate(5);
        return view('roster.schedule_page', ['']);
    }   

    function indexcommittee(){
        //$data = roster::find($id);
        return view('roster.edit_schedule_page'); //selected data pass inside the 'user' key used in edit_schedule_time
    }

}
