<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous">
    </script>

</head>

<body>
    <div style="margin-bottom: 50px" >
    <!--Navigation bar-->
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="background-color: white; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <div class="collapse navbar-collapse" id="navbarText">
          <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                {{-- <x-polaris-major-inventory style="color: black"/> --}}
                <span><a class="nav-link" href="/inventory">Inventory</a></span>
            </li>
            <li class="nav-item">
                <a class="flex-sm-fill text-sm-center nav-link" href="/schedule">Schedule</a>            </li>
            <li class="nav-item">
                <a class="flex-sm-fill text-sm-center nav-link" href="#">Sales Report</a>
            </li>
            <li class="nav-item">
                <a class="flex-sm-fill text-sm-center nav-link active" href="/payment">Payment</a>
            </li>
            <li class="nav-item">
                <a class="flex-sm-fill text-sm-center nav-link" href="/users">User Registration</a>
            </li>
          </ul>
          <span class="navbar-text">
            Logout
          </span>
        </div>
      </nav>
    {{-- <nav class="navbar navbar-light flex-column flex-sm-row" style="background-color: #e3f2fd;">
        <a class="nav-link active" href="/inventory"><span><x-polaris-major-inventory class="h-1 w-1" style="color: green"/></span><span class="d-none d-md-inline">Inventory</span></a>
        <a class="flex-sm-fill text-sm-center nav-link" href="/schedule">Schedule</a>
        <a class="flex-sm-fill text-sm-center nav-link" href="#">Sales Report</a>
        <a class="flex-sm-fill text-sm-center nav-link" href="/cart">Payment</a>
        <a class="flex-sm-fill text-sm-center nav-link" href="#">User Registration</a>
      </nav>
    <nav class="nav nav-pills  ">
        
    </nav> --}}
    <!--Navigation bar-->
    </div>
</body>

</html>
