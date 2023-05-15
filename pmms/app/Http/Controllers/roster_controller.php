<?php

namespace App\Http\Controllers;

use App\Models\Roster;
use Illuminate\Http\Request;

class roster_controller extends Controller
{
    //
    public function create(){
        return view('roster.add_schedule_time_page');
    }

    public function show(){
        //$roster = roster::paginate(5);
        return view('roster.admin_schedule_page', ['']);
    }

    function index(){
        //$data = roster::find($id);
        return view('roster.edit_schedule_time_page'); //selected data pass inside the 'user' key used in edit_schedule_time
    }

}
