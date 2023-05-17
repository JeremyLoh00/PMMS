@include('navbar.roster')
<!DOCTYPE html>
<html lang="en">

<head>
    <link href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>

<body style="background-color: #98dde2;">

    <div
        style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">

        <h3>
            Edit Schedule
        </h3>
        <form action="/update-schedule-page" method="POST">
            @csrf
            <div class="form-group">
                <label for="formGroupExampleInput">Name</label>
                <input type="text" class="form-control" name="date" placeholder="" value="" readonly>
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput">Date</label>
                <input type="text" class="form-control" name="date" placeholder="" value="">
            </div>

            <div class="form-group">
                <label for="formGroupExampleInput2">Time In</label>
                <input type="text" class="form-control" name="time_in" placeholder="" value="">
                <span style="color: red">@error('time_in'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Time Out</label>
                <input type="text" class="form-control" name="time_out" placeholder="" value="">
                <span style="color: red">@error('time_out'){{ $message }} @enderror</span>
            </div>

            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
                <span style="margin-right: 10px"><a href="/rosterCommittee"><button type="button"
                            class="btn btn-outline-primary"
                            style="width: 130px; border-radius: 5px">Cancel</button></a></span>
                <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Update</button></span>
            </div>
        </form>

    </div>
  

<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.0/sweetalert.min.js"></script>

  

</html>
