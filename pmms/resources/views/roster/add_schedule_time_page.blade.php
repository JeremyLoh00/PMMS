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


      
        <form action="{{ route('roster/store') }}" method="POST">
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
            <input type="hidden" name="selected_dates[{{ $weekCounter }}][{{ $index }}]" value="{{ $date }}">

            <div style="display: flex; align-items: center;">
                <div>
                    <span style="margin-right: 10px;">{{ $days[$index] }}:</span>
                    <input type="hidden" name="days[]" value="{{ $days[$index] }}">
                    <br>
                    <span style="margin-right: 10px;">{{ $date }}</span>
                    <input type="hidden" name="dates[{{ $weekCounter }}][]" value="{{$date}}">
                </div>
                <div style="display: flex; align-items: center; margin-left: 20px;">
                    <span style="margin-right: 10px;">From</span>
                    <select name="time_in[{{ $weekCounter }}][]" style="margin-right: 10px;" class="form-control">
                                    <option value="8">0800</option>
                                    <option value="9">0900</option>
                                    <option value="10">1000</option>
                                    <option value="11">1100</option>
                                    <option value="12">1200</option>
                                    <option value="13">1300</option>
                                </select>
                                <span style="color: red">@error("time_in.{$weekCounter}.{$index}"){{ $message }} @enderror</span>
                                <span style="margin-right: 10px;">Until</span>
                                <select name="time_out[{{ $weekCounter }}][]" style="margin-right: 10px;" class="form-control">
                                    <option value="13">1300</option>
                                    <option value="14">1400</option>
                                    <option value="15">1500</option>
                                    <option value="16">1600</option>
                                    <option value="17">1700</option>
                                    <option value="18" selected>1800</option>
                                </select>
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
