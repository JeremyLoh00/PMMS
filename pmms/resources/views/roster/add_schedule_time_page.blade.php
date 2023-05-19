@include('navbar.roster')
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>

<body style="background-color: #98dde2;">
    <div
        style=" margin: 0 auto; width:50%;background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        
        <h3 style="text-align: center;">
            Add Schedule Time
        </h3>
        <!-- separate-month-into-weeks.blade.php -->


      
        <form action="{{ route('store') }}" method="POST">
            @csrf
            <table style="width: 100%">
                <tbody>
                    <tr>
                        <td>Month: {{ $month }}</td>
                        <input type="hidden" name="month" value="{{ $month }}">
                        <td><label>Week</label></td>
                        <td>
                            <div class="form-group" style="display: grid; grid-template-columns: max-content 1fr;">
                                <select name="week" class="form-control" style="width: 100%" onchange="showSelectedWeek(this)">
                                    <option value="0">Please select</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                </select>
                                <span style="color: red">@error('week'){{ $message }} @enderror</span>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            @php
                                $weekCounter = 1; // Counter for tracking the week number
                            @endphp
            
            @foreach ($dates as $index => $date)
            @if ($index % 7 === 0)
                <div class="week-container" data-week="{{ $weekCounter }}" @if ($weekCounter !== 1) style="display: none" @endif>
                    Week {{ $weekCounter }}:<br>
                    @php
                        $weekCounter++;
                    @endphp
            @endif
            <input type="hidden" name="week_counter" value="{{ $weekCounter }}">
            <div style="display: flex; align-items: center;">
                <div>
                    <span style="margin-right: 10px;">{{ $days[$index] }}:</span>
                    <input type="hidden" name="days[]" value="{{ $days[$index] }}">
                    <br>
                    <span style="margin-right: 10px;">{{ $date }}</span>
                    <input type="hidden" name="dates[]" value="{{$date}}">
                </div>
                <div style="display: flex; align-items: center; margin-left: 20px;">
                    <span style="margin-right: 10px;">From</span>
                    <input type="text" class="form-control" name="time_in[{{ $weekCounter }}][]" placeholder="0800" style="margin-right: 10px;">
                    <span style="color: red">@error("time_in.{$weekCounter}.{$index}"){{ $message }} @enderror</span>
                    <span style="margin-right: 10px;">Until</span>
                    <input type="text" class="form-control" name="time_out[{{ $weekCounter }}][]" placeholder="0800">
                    <span style="color: red">@error("time_out.{$weekCounter}.{$index}"){{ $message }} @enderror</span>
                </div>
            </div>
            <br>
            @if (($index + 1) % 7 === 0)
                </div>
            @endif
        @endforeach
        
                        </td>
                    </tr>
                </tbody>
            </table>
            
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
                <span style="margin-right: 10px">
                    <a href="/rosterAdmin">
                        <button type="button" class="btn btn-outline-primary" style="width: 130px; border-radius: 5px">Cancel</button>
                    </a>
                </span>
                <span>
                    <button type="submit" class="btn btn-primary" style="width: 130px; border-radius: 5px">Add</button>
                </span>
            </div>
        </form>
        
        
        
        
        
        
        
        
        
        {{-- <form action="/store" method="POST">
            @csrf

            <div class="form-group">
                <label for="formGroupExampleInput">Date</label>
                <input type="date" class="form-control" name="date" placeholder="" value="" >
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput2">Day</label>
                <select name="day" class="form-control"  value="">
                <option value="0">Please select</option>
                <option value="Monday">Monday</option>
                <option value="Tuesday">Tuesday</option>
                <option value="Wednesday">Wednesday</option>
                <option value="Thursday">Thursday</option>
                <option value="Friday">Friday</option>
                <option value="Saturday">Saturday</option>
                <option value="Sunday">Sunday</option>
                </select> 
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput2">Month</label>
                <select name="month" class="form-control"  value="">
                <option value="0">Please select</option>
                <option value="January">January</option>
                <option value="February">February</option>
                <option value="March">March</option>
                <option value="April">April</option>
                <option value="May">May</option>
                <option value="June">June</option>
                <option value="July">July</option>
                <option value="August">August</option>
                <option value="September">September</option>
                <option value="October">October</option>
                <option value="November">November</option>
                <option value="December">December</option>
                </select> 
                <span style="color: red">@error('month'){{ $message }} @enderror</span>
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput2">Week</label>
                <select name="week" class="form-control"  value="">
                <option value="0">Please select</option>
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
                <option value="5">5</option>
                
                </select> 
                <span style="color: red">@error('week'){{ $message }} @enderror</span>
            </div>

         
            <div class="form-group">
                <label for="formGroupExampleInput2">From</label>
                <input type="text" class="form-control" name="time_in" placeholder="0800">
                <span style="color: red">@error('time_in'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Until</label>
                <input type="text" class="form-control" name="time_out" placeholder="1300">
                <span style="color: red">@error('time_out'){{ $message }} @enderror</span>
            </div>
            
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <span style="margin-right: 10px"><a href="/rosterAdmin"><button type="button" class="btn btn-outline-primary"
                        style="width: 130px; border-radius: 5px">Cancel</button></a></span>
            <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
        </div>
        </form> --}}
        
    </div>
</body>
<script>
    function showSelectedWeek(selectElement) {
        const selectedWeek = selectElement.value;
        const weekContainers = document.querySelectorAll('.week-container');

        weekContainers.forEach(container => {
            const weekNumber = container.getAttribute('data-week');
            if (weekNumber === selectedWeek) {
                container.style.display = 'block';
            } else {
                container.style.display = 'none';
            }
        });
    }
</script>

</html>
