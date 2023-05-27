@include('navbar.roster')
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <!--Add successfully alert-->
    @if(session('message'))
    <div class="alert alert-success">{{session('message')}}
    <button type="button" class="close", data-dismiss="alert"><x-govicon-times style="color: black"/></button></div>
    @endif

</head>

<body style="background-color: #98dde2;">
    <div
        style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        
        <h3>
            Add New Schedule
        </h3>
       
        <form action="{{ route('roster.filter') }}" method="GET">
                @csrf
            <div class="form-group">
                <label for="formGroupExampleInput">Name</label>
                <input type="hidden" name="id" value="{{$user->id}}">
                <input type="text" class="form-control" name="name" placeholder="{{$user->name}}" value="{{$user->name}}" readonly>
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput">Date</label>
                           
                <div style="display: flex; align-items: center;">
                @if (session()->has('date2'))
                    <input type="date" class="form-control" name="date2" style="margin-right: 10px;" value="{{ session('date2') }}">
                @else
                     <input type="date" class="form-control" name="date2" style="margin-right: 10px;">
                @endif
                <!-- <input type="date" class="form-control" name="date2" style="margin-right: 10px;"> -->
                <button type="submit" class="btn btn-primary" style="width: 130px; border-radius: 5px;">Check Date</button>
                </div>
        </form>
               
            </div>

            @if(isset($schedule) && $schedule->isNotEmpty())
            <form action="/roster/store" method="POST">
            @csrf
            <div class="form-group">
                <label for="formGroupExampleInput2">Available Time</label>
                
                <input type="hidden" name="date" value="{{ session('date2') }}">     
                <select name="time" id="" class="form-control">
                    @foreach ($slot as $time)
                    <option value="{{$time}}">{{$time}}</option>
                    @endforeach
                </select>

    

                <span style="color: red">@error('time_in'){{ $message }} @enderror</span>
            </div>
        
            
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <span style="margin-right: 10px"><a href="/rosterCommittee"><button type="button" class="btn btn-outline-primary"
                        style="width: 130px; border-radius: 5px">Cancel</button></a></span>
            <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
        </div>
        </form>
        @endif
    </div>
</body>

</html>
