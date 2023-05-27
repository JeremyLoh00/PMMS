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
        } elseif ($userRole === 'Cashier'||'Secretary'||'Treasurer'||'Coordinator') {
            $roster=Roster::all();

            return view('roster.add_schedule_page',['user' => $user, 'roster' => $roster]);
        } else {
            return view('auth.login');
        }
    }

    public function showlistadmin()
    {
        $userId = Auth::id(); // Retrieve the ID of the currently authenticated user
        $userRole = Auth::user()->role; // Retrieve the role of the currently authenticated user
        
        $roster = Roster::where('user_id', $userId)
                        ->whereHas('user', function ($query) use ($userRole) {
                            $query->where('role', $userRole);
                        })
                        ->paginate(7);
        return view('roster.admin_schedule_page', ['rosters' => $roster]);
    }

    public function indexadmin($id)
    {
        $data = roster::find($id);
        return view('roster.edit_schedule_time_page', ['roster' => $data]); //selected data pass inside the 'rosters' key used in edit_roster
    }

    public function showlistcommittee()
    {
        //$roster = roster::paginate(5);
        $user = Auth::user();
        $rosters = DB::table('rosters')
        ->where('user_id', $user->id)
        ->get();
        //var_dump($roster);
        return view('roster.schedule_page', compact('user', 'rosters'));
    }

    public function indexcommittee()
    {
        //$data = roster::find($id);
        return view('roster.edit_schedule_page');
    }


    public function store(Request $request)
    {
        $userRole = session('role');
        $user = User::find(Auth::id());
    
        if ($userRole === 'Admin') {
            $userId = Auth::id();
            $timeInInputs = $request->time_in;
            $timeOutInputs = $request->time_out;
            //dd($timeInInputs);
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
    
                        // Convert time to the desired format
                        $timeIn = $timeIn . ':00';
                        $timeOut = $timeOut . ':00';
    
                        try {
                            if (Roster::where('date', $date)->exists()) {
                                $report .= "Data for date " . $date . " already exists. ";
                            } else {
                                $roster = new Roster();
                                $roster->user_id = $userId;
                                $roster->day = $day;
                                $roster->date = $date;
                                $roster->month = $month; // Assuming $month is available
                                $roster->week = $week - 1; // Subtract 1 from $week to get the correct week number
                                $roster->time_in = $timeIn;
                                $roster->time_out = $timeOut;
    
                                // Calculate total hours (assuming time in and time out are on the same day)
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
        } else {
          
                $time = $request->input('time');
                list($startTime, $endTime) = explode('-', $time);
                $dateString = $request->input('date');
                $date = Carbon::parse($dateString);
                $day = $date->format('l');
                $roster = Roster::find(Auth::id());
                // Extract the month
                $month = $date->format('F');
                $week = $date->weekOfMonth;
               // dd($week);
               $check = Roster::where('time_in', $startTime)
               ->where('time_out', $endTime)
               ->where('date', $date)
               ->whereHas('user', function ($query) {
                   $query->where('role', '!=', 'admin');
               })
               ->first();
           
           if ($check) {
               return redirect('/rosterCommittee')->with('message', 'Date ' . $date . ' for ' . $startTime . '-' . $endTime . ' already booked!')->with('roster', $roster);
           } else {
               $schedule = new Roster();
               $schedule->user_id = Auth::id();
               $schedule->day = $day;
               $schedule->date = $date;
               $schedule->month = $month; // Assuming $month is available
               $schedule->week = $week ; // Subtract 1 from $week to get the correct week number
               $schedule->time_in = $startTime;
               $schedule->time_out = $endTime;
           
               // Calculate total hours (assuming time in and time out are on the same day)
               $totalHours = Carbon::createFromFormat('H:i', $endTime)->diffInHours(Carbon::createFromFormat('H:i', $startTime));
               $schedule->total_hour = $totalHours;
               $schedule->rate = 5;
               $schedule->save();
           
               $user = Auth::user();
               $roster = Roster::where('user_id', $user->id)->first();
           
               return redirect('/rosterCommittee')->with('message', 'Add successful!')->with('roster', $roster);
           }
           
                //dd($startTime);
                // Roster record(s) exist for the given date
                //return view('roster.add_schedule_page', compact('roster'));
              

            }

           
        
    }

//    public function store(Request $request)
// {
//     $userRole = session('role');
//     $user = User::find(Auth::id());

//     if ($userRole === 'Admin') {
//         $userId = Auth::id();
//         $timeInInputs = $request->time_in;
//         $timeOutInputs = $request->time_out;
//         $days = $request->input('days');
//         $month = $request->input('month');
//         $report = '';
//         $roster = '';

//         // Loop through the weeks and process the inputs
//         $weekCounter = 1;
//         foreach ($timeInInputs as $week => $timeIns) {
//             foreach ($timeIns as $index => $timeIn) {
//                 $timeOut = $timeOutInputs[$week][$index];
//                 $day = $days[$index]; // Access the specific day based on the index

//                 // Check if both time in and time out are not null
//                 if ($timeIn !== null && $timeOut !== null) {
//                     $date = $request->input("selected_dates.{$week}.{$index}"); // Access the specific date based on the week and index
//                     //dd($request->input("selected_dates.{$week}.{$index}"));
//                     $dateFormatted = Carbon::createFromFormat('d/m/Y', $date)->format('Y-m-d');
//                     //dump($dateFormatted);
//                     // Convert time to the desired format
//                     $timeIn = $timeIn . ':00';
//                     $timeOut = $timeOut . ':00';
//                     //dd($timeIn,$timeOut);
//                     try {
//                         if (Roster::where('date', $dateFormatted)->exists()) {
//                             $report .= "Data for date " . $dateFormatted . " already exists. ";
//                         } else {
//                             $roster = new Roster();
//                             $roster->user_id = $userId;
//                             $roster->day = $day;
//                             $roster->date = $dateFormatted;
//                             $roster->month = $month; // Assuming $month is available
//                             $roster->week = $week -1 ; // Subtract 1 from $weekCounter to get the correct week number
//                             $roster->time_in = $timeIn;
//                             $roster->time_out = $timeOut;

//                             // Calculate total hours (assuming time in and time out are on the same day)
//                             //$totalHours = Carbon::parse($timeOut)->diffInHours(Carbon::parse($timeIn));

//                             //dd($totalHours);
//                             $roster->total_hour = 11;
//                             $roster->rate = 5;
//                             $roster->save();
//                         }
//                     } catch (Exception $e) {
//                         return redirect('/rosterAdmin')->with('error', $e->getMessage());
//                     }
//                 }
//             }
//         }

//         try {
//             if ($report) {
//                 return redirect('/rosterAdmin')->with('message', $report);
//             } elseif ($roster && $report) {
//                 return redirect('/rosterAdmin')->with('message', 'Add successful! and ' . $report);
//             } elseif ($roster) {
//                 return redirect('/rosterAdmin')->with('message', 'Add successful!');
//             } else {
//                 throw new Exception('Something went wrong!');
//             }
//         } catch (Exception $e) {
//             return redirect('/rosterAdmin')->with('error', $e->getMessage());
//         }
//     } else {
//         $date = $request->input('date2');
//         $roster = Roster::whereDate('date', $date)->get();
//         dd($roster);
//         return view('roster.add_schedule_page', compact('roster'));
//     }
// }


    
    
    
     
    
    

    

    
public function filter(Request $request)
{
    if(isset($_GET['month'])){
        $month = $request->query('month');
        $rosters = DB::table('rosters')
            ->join('users', 'users.id', '=', 'rosters.user_id')
            ->where('rosters.month', 'LIKE', '%' . $month . '%')
            ->where('users.role', 'Admin')
            ->paginate(7)
            ->appends($request->query());
       return view('roster.admin_schedule_page', ["rosters" => $rosters]);
    }
    elseif(isset($_GET['date2'])){
        $user = User::find($_GET['id']);
        $date = $request->input('date2');
        //dd($date);
        session(['date2' => $date]);
        $date2 = session('date2');

        $schedule = DB::table('rosters')->where('date', 'LIKE', '%' . $date . '%')->paginate(10);
        $schedule2 = DB::table('rosters')
                    ->select('rosters.time_in', 'rosters.time_out')
                    ->join('users', 'rosters.user_id', '=', 'users.id')
                    ->where('rosters.date', 'LIKE', '%' . $date . '%')
                    ->where('users.role', 'Admin')
                    ->get();


        $schedule->appends($request->all());

        $timeRange = [];

        $timeRangesFormatted = [];

        foreach ($schedule2 as $row) {
            $timeIn = $row->time_in;
            $timeOut = $row->time_out;
            
            $timeInTimestamp = strtotime($timeIn);
            $timeOutTimestamp = strtotime($timeOut);
            
            $step = 60 * 60; // 1 hour in seconds
            $range = range($timeInTimestamp, $timeOutTimestamp - $step, $step);
            
            $rangeFormatted = array_map(function ($timestamp) {
                return date('H:i', $timestamp) . '-' . date('H:i', strtotime('+1 hour', $timestamp));
            }, $range);
            
            $timeRangesFormatted = array_merge($timeRangesFormatted, $rangeFormatted);
        }

        //dd($timeRangesFormatted);

        

        //dd($timeRange);
         return view('roster.add_schedule_page', compact('schedule', 'user', 'date2', 'timeRangesFormatted'));        
    }
    
   
}

public function update(Request $request, $id)
{
    $validatedData = $request->validate([
        'time_in' => 'required',
        'time_out' => 'required',
    ]);

    

    $time_in = $request->input('time_in');
    $time_out = $request->input('time_out');

    $start = Carbon::parse($time_in);
    $end = Carbon::parse($time_out);

    $total_hour = intval($end->diffInHours($start));
    //dd($total_hour);
    $roster = Roster::find($id);
    $roster->time_in = $request->input('time_in');
    $roster->time_out = $request->input('time_out');
    $roster->total_hour = $total_hour;

    if ($roster->save()) {
        return redirect('/rosterAdmin')->with('message', 'Update successful!');
    } else {
        return redirect('/rosterAdmin')->with('error', 'Update failed!');
    }
}


    function delete($id)
    {
        roster::find($id)->delete();
        
        return redirect('/rosterAdmin')->with('message', 'Delete successful!'); //redirect back to inventory page, call the route   
        //return redirect('rosterAdmin')->with('message', 'Delete successful!');
    }
    
    

    
    
    
    
    
    
    
}
