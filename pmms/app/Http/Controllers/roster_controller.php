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
        //$user = Auth::id();
        $user = User::find(Auth::id());
        return view('roster.schedule_page', ['user' => $user]);
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
            $date = $request->input('date2');
            $rosterDate = Roster::whereDate('date', $date)->get();

            if ($rosterDate->isEmpty()) {
               
                return view('roster.add_schedule_page')
                ->with('message', 'Date not added by admin')
                ->with(compact('user'));

            } else {
                $timeIn = $request->input('time_in');
                $timeOut = $request->input('time_out');
                $timeIn = $timeIn . ':00';
                $timeOut = $timeOut . ':00';
                dd($timeIn,$timeOut);
                // Roster record(s) exist for the given date
                //return view('roster.add_schedule_page', compact('roster'));
                $schedule = new Roster();
                $schedule->user_id = Auth::id();
                //$schedule->day = $day;
                $schedule->date = $date;
                //$schedule->month = $month; // Assuming $month is available
                //$schedule->week = $week - 1; // Subtract 1 from $week to get the correct week number
                $schedule->time_in = $timeIn;
                $schedule->time_out = $timeOut;

                // Calculate total hours (assuming time in and time out are on the same day)
                $totalHours = Carbon::createFromFormat('H:i', $timeOut)->diffInHours(Carbon::createFromFormat('H:i', $timeIn));
                $schedule->total_hour = $totalHours;
                $schedule->rate = 5;
                $schedule->save();
                return redirect('/rosterCommittee')->with('message', 'Add sucessful!');

            }

           
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
       $month = $_GET['month'];
       $rosters = DB::table('rosters')->where('month','LIKE','%'.$month.'%')->paginate(7);
       $rosters->appends($request->all());
       return view('roster.admin_schedule_page', ["rosters" => $rosters]);
    }
    elseif(isset($_GET['date2'])){
        
        $user = User::find($_GET['id']);
        $date = $request->input('date2');
        session(['date2' => $date]);
        $date2 = session('date2');
        
        $schedule = DB::table('rosters')->where('date', 'LIKE', '%' . $date . '%')->paginate(10);
        $schedule2 = DB::table('rosters')->select('time_in', 'time_out')->where('date', 'LIKE', '%' . $date . '%')->get();
        
        $schedule->appends($request->all());
        
        $timeInArray = [];
        $timeOutArray = [];
        
        foreach ($schedule2 as $row) {
            $timeInArray[] = $row->time_in;
            $timeOutArray[] = $row->time_out;
        }
        
        $timeRange = [];
        
        // Generate the time range array
        foreach ($timeInArray as $index => $timeIn) {
            $timeOut = $timeOutArray[$index];
            $timeRange = array_merge($timeRange, range($timeIn, $timeOut, '1 hour'));
        }
        
        dd($timeRange);
        
        return view('roster.add_schedule_page', compact('schedule', 'user', 'date2'));
        
        
    }
    
   
}









    

    function delete($id)
    {
        roster::find($id)->delete();
        
        return redirect('/rosterAdmin')->with('message', 'Delete successful!'); //redirect back to inventory page, call the route   
        //return redirect('rosterAdmin')->with('message', 'Delete successful!');
    }
    
    

    
    
    
    
    
    
    
}
