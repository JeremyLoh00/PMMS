<?php

namespace App\Http\Controllers;

use Exception;
use Carbon\Carbon;
use App\Models\Roster;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Foundation\Auth\User;
use Illuminate\Support\Facades\Auth;

class roster_controller extends Controller
{
    private $days = [];
    private $dates = [];

    public function create(Request $request)
    {
        $userRole = session('role');
        $month = $request->query('month');
        $id = $request->query('id');

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

        $currentYear = Carbon::now()->year;
        $startDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->startOfMonth();
        $endDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->endOfMonth();

        $currentDate = $startDate;

        while ($currentDate <= $endDate) {
            $this->dates[] = $currentDate->format('d/m/Y');
            $this->days[] = $currentDate->format('l');
            $currentDate->addDay();
        }

        $user = User::find($id);
        if ($userRole === 'Admin') {
            return view('roster.add_schedule_time_page', ['month' => $month, 'dates' => $this->dates, 'days' => $this->days]);
        } elseif ($userRole === 'Cashier') {

            return view('roster.add_schedule_page',['user' => $user]);
        } else {
            return view('auth.login');
        }
    }

    public function showlistadmin()
    {
        $roster = roster::paginate(7);
        return view('roster.admin_schedule_page', ['rosters' => $roster]);
    }

    public function indexadmin()
    {
        //$data = roster::find($id);
        return view('roster.edit_schedule_time_page');
    }

    public function showlistcommittee()
    {
        //$roster = roster::paginate(5);
        $user = Auth::id();
        return view('roster.schedule_page', ['user' => $user]);
    }

    public function indexcommittee()
    {
        //$data = roster::find($id);
        return view('roster.edit_schedule_page');
    }






    public function store(Request $request)
{
    $userId = Auth::id();
    $timeInInputs = $request->input('time_in');
    $timeOutInputs = $request->input('time_out');
    $days = $request->input('days');
    $dates = $request->input('dates');
    $month = $request->input('month');
    $report = '';

    // Loop through the weeks and process the inputs
    $weekCounter = 1;
    foreach ($timeInInputs as $week => $timeIns) {
        foreach ($timeIns as $index => $timeIn) {
            $timeOut = $timeOutInputs[$week][$index];
            $day = $days[$index]; // Access the specific day based on the index

            // Check if both time in and time out are not null
            if ($timeIn !== null && $timeOut !== null) {
                $date = Carbon::createFromFormat('d/m/Y', $dates[$week][$index])->format('Y-m-d'); // Access the specific date based on the week and index

                // Convert time to desired format
                $timeIn = $timeIn . ':00';
                $timeOut = $timeOut . ':00';

                try {
                    if (Roster::where('date', $date)->exists()) {
                        //return redirect('/rosterAdmin')->with('error', 'Data already exists for date ' . $date);
                        $report .= "Data for date " . $date . " already exists. ";
                    } else {
                        $roster = new Roster();
                        $roster->user_id = $userId;
                        $roster->day = $day;
                        $roster->date = $date;
                        $roster->month = $month; // Assuming $month is available
                        $roster->week = $week - 1;
                        $roster->time_in = $timeIn;
                        $roster->time_out = $timeOut;

                        // Calculate total hours (assuming time in and time out are in the same day)
                        $totalHours = Carbon::createFromFormat('H:i', $timeOut)->diffInHours(Carbon::createFromFormat('H:i', $timeIn));
                        $roster->total_hour = $totalHours;
                        $roster->rate = 5;
                        $roster->save();
                    }
                } catch (Exception $e) {
                    return redirect('/rosterAdmin')->with('error', $e->getMessage());
                }
            }
        }
    }

    try {
        if ($report) {
            return redirect('/rosterAdmin')->with('message', $report);
        } elseif ($roster && $report) {
            return redirect('/rosterAdmin')->with('message', 'Add successful! and ' . $report);
        } elseif ($roster) {
            return redirect('/rosterAdmin')->with('message', 'Add successful!');
        } else {
            throw new Exception('Something went wrong!');
        }
    } catch (Exception $e) {
        return redirect('/rosterAdmin')->with('error', $e->getMessage());
    }
}

    

    
public function filter(Request $request)
{
    if(isset($_GET['month'])){
       $month = $_GET['month'];
       $rosters = DB::table('rosters')->where('month','LIKE','%'.$month.'%')->paginate(7);
       $rosters->appends($request->all());
       return view('roster.admin_schedule_page', ["rosters" => $rosters]);
    }
    else{

    }
    
   
}









    

    function delete($id)
    {
        roster::find($id)->delete();
        
        return redirect('/rosterAdmin')->with('message', 'Delete successful!'); //redirect back to inventory page, call the route   
        //return redirect('rosterAdmin')->with('message', 'Delete successful!');
    }
    
    

    
    
    
    
    
    
    
}
