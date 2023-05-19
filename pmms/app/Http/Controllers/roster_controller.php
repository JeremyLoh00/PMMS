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
        //$roster = roster::paginate(5);
        return view('roster.admin_schedule_page', []);
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
        //dd($request);
        $userId = Auth::id();
        $validatedData = $request->validate([
            'week' => 'required|array',
            'week.*' => 'required|integer',
            'time_in' => 'required|array',
            'time_in.*' => 'required|date_format:H:i',
            'time_out' => 'required|array',
            'time_out.*' => 'required|date_format:H:i',
        ]);
    
        $weeks = $request->input('week');
        $timeIn = $request->input('time_in');
        $timeOut = $request->input('time_out');
    
        $numOfWeeks = count($weeks);
    
        // Only process and save data for "week1"
        if ($numOfWeeks >= 1) {
            $week = $weeks[0];
            $timeInWeek = $timeIn[0];
            $timeOutWeek = $timeOut[0];
    
            if ($week < 1 || $week > 5) {
                return redirect('/rosterAdmin')->with('message', 'Invalid week!');
            }
    
            $currentYear = Carbon::now()->year;
            $monthNumber = Carbon::parse($request->query('month'))->month;
    
            $startDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->startOfMonth();
            $endDate = Carbon::createFromDate($currentYear, $monthNumber, 1)->endOfMonth();
    
            $currentDate = $startDate;
            $days = [];
            $dates = [];
    
            while ($currentDate <= $endDate) {
                $days[] = $currentDate->format('l');
                $dates[] = $currentDate->format('Y-m-d');
                $currentDate->addDay();
            }
    
            $startDay = ($week - 1) * 7;
            $totalHours = 0;
    
            for ($j = 0; $j < 7; $j++) {
                $day = $days[$startDay + $j];
                $date = $dates[$startDay + $j];
    
                // Calculate the difference in hours between time_in and time_out
                $timeInCarbon = Carbon::createFromFormat('H:i', $timeInWeek[$j]);
                $timeOutCarbon = Carbon::createFromFormat('H:i', $timeOutWeek[$j]);
                $hoursDiff = $timeInCarbon->diffInHours($timeOutCarbon);
    
                // Add the hours difference to the total hours
                $totalHours += $hoursDiff;
    
                $roster = new Roster();
                $roster->user_id = $userId;
                $roster->day = $day;
                $roster->date = $date;
                $roster->week = $week;
                $roster->month = $monthNumber;
                $roster->total_hour = $totalHours;
                $roster->time_in = $timeInWeek[$j];
                $roster->time_out = $timeOutWeek[$j];
    
                if ($roster->save()) {
                    // Data saved successfully
                    return redirect('/rosterAdmin')->with('message', 'Add successful!');
                } else {
                    // Failed to save data
                    return redirect('/rosterAdmin')->with('message', 'Failed to save data!');
                }
            }
        }
    
        return redirect('/schedule')->with('message', 'No data to process!');
    }


    
}
