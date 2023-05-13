@include('navbar.inventory')
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
            Edit user
        </h3>
        <form action="/update-user/{{ $user->id }}" method="POST">
            @csrf
            <div class="form-group">
                <label for="formGroupExampleInput">Username</label>
                <input type="text" class="form-control" name="username" placeholder="Item name" value="{{ $user->username }}" readonly>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Name</label>
                <input type="text" class="form-control" name="name" placeholder="Name" value="{{ $user->name }}">
                <span style="color: red">@error('name') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Address</label>
                <input type="text" class="form-control" name="address" placeholder="Address" value="{{ $user->address }}">
                <span style="color: red">@error('address') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Phone Number</label>
                <input type="text" class="form-control" name="phone_num" placeholder="Phone Number" value="{{ $user->phone_num }}">
                <span style="color: red">@error('phone_num') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Email</label>
                <input type="text" class="form-control" name="email" placeholder="Email" value="{{ $user->email }}">
                <span style="color: red">@error('email') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Role</label>
                <select name="role" class="form-control">
                    <option value="0" @if($user->role == '0') selected @endif>Please select</option>
                    <option value="Admin" @if($user->role == 'Admin') selected @endif>{{$user->role == 'Admin' ? ' Admin' : 'Admin'}}</option>
                    <option value="Cashier" @if($user->role == 'Cashier') selected @endif>{{$user->role == 'Cashier' ? 'Cashier' : 'Cashier'}}</option>
                    <option value="Secretary" @if($user->role == 'Secretary') selected @endif>{{$user->role == 'Secretary' ? ' Secretary' : 'Secretary'}}</option>
                    <option value="Treasurer" @if($user->role == 'Treasurer') selected @endif>{{$user->role == 'Treasurer' ? 'Treasurer' : 'Treasurer'}}</option>
                    <option value="Coordinator" @if($user->role == 'Coordinator') selected @endif>{{$user->role == 'Coordinator' ? ' Coordinator' : 'Coordinator'}}</option>
                </select>
                
                
                
                <span style="color: red">@error('role') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Password</label>
                <input type="password" class="form-control" name="password" placeholder="Password">
                <span style="color: red">@error('password') {{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Confirm Password</label>
                <input type="password" class="form-control" name="password_confirmation" placeholder="Confirm Password">
                <span style="color: red">@error('password_confirmation') {{ $message }} @enderror</span>
            </div>
            
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
                <span style="margin-right: 10px"><a href="/users"><button type="button"
                            class="btn btn-outline-primary"
                            style="width: 130px; border-radius: 5px">Cancel</button></a></span>
                <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Update</button></span>
            </div>
        </form>

    </div>
    <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
        <form method="POST" action="{{ route('User.delete', $user->id) }}">
            @csrf
            <input name="_method" type="hidden" value="DELETE">
            <button
            type="submit" class="btn btn-xs btn-danger btn-flat show_confirm" data-toggle="tooltip" style="width: 60px; height: 60px; padding: 15px; border-radius: 50%; background-color: white; border: none; left: 50%; box-shadow: 3px 3px rgba(0, 0, 0, 0.02);">
                <x-tabler-trash style="color: red" />
            </button>
        </form>
    </div>

    {{-- Delete --}}
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.0/sweetalert.min.js"></script>
<script type="text/javascript">
 
     $('.show_confirm').click(function(event) {
          var form =  $(this).closest("form");
          var name = $(this).data("name");
          event.preventDefault();
          swal({
              title: `Are you sure you want to delete this item?`,
              text: "If you delete this, it will be gone forever.",
              icon: "warning",
              buttons: true,
              dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
              form.submit();
            }
          });
      });
  
</script>
  

</html>
