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
        style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        
        <h3>
            Add Schedule Time
        </h3>
        <form action="/store" method="POST">
            @csrf

            <div class="form-group">
                <label for="formGroupExampleInput">Date</label>
                <input type="text" class="form-control" name="date" placeholder="date" value="" >
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput">Day</label>
                <input type="text" class="form-control" name="day" placeholder="day" value="" >
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
                <select name="month" class="form-control"  value="">
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
                <label for="formGroupExampleInput">Day</label>
                <input type="text" class="form-control" name="day" placeholder="">
                <span style="color: red">@error('day'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">From</label>
                <input type="text" class="form-control" name="time_in" placeholder="">
                <span style="color: red">@error('time_in'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Until</label>
                <input type="text" class="form-control" name="time_out" placeholder="">
                <span style="color: red">@error('time_out'){{ $message }} @enderror</span>
            </div>
            
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <span style="margin-right: 10px"><a href="/roster"><button type="button" class="btn btn-outline-primary"
                        style="width: 130px; border-radius: 5px">Cancel</button></a></span>
            <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
        </div>
        </form>
        
    </div>
</body>

</html>
