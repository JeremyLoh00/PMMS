@include('navbar.users')
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
            Add user
        </h3>
        <form action="/store" method="POST">
            @csrf
            <div class="form-group">
                <label for="formGroupExampleInput">Username</label>
                <input type="text" class="form-control" name="username" placeholder="">
                <span style="color: red">@error('username'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Name</label>
                <input type="text" class="form-control" name="name" placeholder="">
                <span style="color: red">@error('name'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Address</label>
                <input type="text" class="form-control" name="address" placeholder="">
                <span style="color: red">@error('address'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Phone Number</label>
                <input type="text" class="form-control" name="phone_num" placeholder="">
                <span style="color: red">@error('phone_num'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Email</label>
                <input type="text" class="form-control" name="email" placeholder="">
                <span style="color: red">@error('email'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Role</label>
                <input type="text" class="form-control" name="role" placeholder="">
                <span style="color: red">@error('role'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Password</label>
                <input type="text" class="form-control" name="password" placeholder="">
                <span style="color: red">@error('password'){{ $message }} @enderror</span>
            </div>
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <span style="margin-right: 10px"><a href="/users"><button type="button" class="btn btn-outline-primary"
                        style="width: 130px; border-radius: 5px">Cancel</button></a></span>
            <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
        </div>
        </form>
        
    </div>
</body>

</html>
