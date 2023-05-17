<?php

namespace App\Http\Controllers;

use App\Models\Roster;
use Illuminate\Http\Request;

class roster_controller extends Controller
{
    //
    public function create1(){
        return view('roster.add_schedule_time_page');
    }

    public function create2(){
        return view('roster.add_schedule_page');
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
