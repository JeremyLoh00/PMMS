<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Roster;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class roster_controller extends Controller
{
    private $days = [];
    private $dates = [];

    public function create(Request $request)
    {
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

        $currentYear = Carbon::now()->year;
        $startDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->startOfMonth();
        $endDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->endOfMonth();

        $currentDate = $startDate;

        while ($currentDate <= $endDate) {
            $this->dates[] = $currentDate->format('d/m/Y');
            $this->days[] = $currentDate->format('l');
            $currentDate->addDay();
        }

        if ($userRole === 'Admin') {
            return view('roster.add_schedule_time_page', ['month' => $month, 'dates' => $this->dates, 'days' => $this->days]);
        } elseif ($userRole === 'Cashier') {
            return view('roster.add_schedule_page');
        } else {
            return view('auth.login');
        }
    }

    public function showlistadmin()
    {
        $roster = roster::paginate(5);
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
        return view('roster.schedule_page', []);
    }

    public function indexcommittee()
    {
        //$data = roster::find($id);
        return view('roster.edit_schedule_page');
    }




    public function store(Request $request)
    {
        $weekCounter = 1;
        $userId = Auth::id();
        $timeInInputs = $request->input('time_in');
        $timeOutInputs = $request->input('time_out');
        $days = $request->input('days');
        $dates = $request->input('dates');
        $month = $request->input('month');
    
        // Loop through the weeks and process the inputs
        foreach ($timeInInputs as $week => $timeIns) {
            foreach ($timeIns as $index => $timeIn) {
                $timeOut = $timeOutInputs[$week][$index];
                $day = $days[$index]; // Access the specific day based on the index
    
                // Check if both time in and time out are not null
                if ($timeIn !== null && $timeOut !== null) {
                    $date = Carbon::createFromFormat('m/d/Y', $dates[$index])->format('Y-m-d');// Access the specific date based on the index
    
                    // Convert time to desired format
                    $timeIn = $timeIn . ':00';
                    $timeOut = $timeOut . ':00';
    
                    // Create a new Roster instance
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
                  
    
                    dump("Week: " . ($week - 1), "Dates: $date", "Day: $day", "Time In: $timeIn", "Time Out: $timeOut");
                }
            }
        }
        //return redirect('/rosterAdmin')->with('message', 'Add successful!');
    }

    public function filter(Request $request)
    {
        $month = $request->input('month');
    
        // Perform the query to filter the roster data by month
        $rosters = Roster::where('month', $month)->paginate(10);
    
        // Pass the filtered rosters to your view for display
        return view('roster.admin_schedule_page', compact('rosters'));
    }

    function delete($id)
    {
        roster::find($id)->delete();
        
        return redirect('/rosterAdmin')->with('message', 'Delete successful!'); //redirect back to inventory page, call the route   
        //return redirect('rosterAdmin')->with('message', 'Delete successful!');
    }
    
    

    
    
    
    
    
    
    
}
