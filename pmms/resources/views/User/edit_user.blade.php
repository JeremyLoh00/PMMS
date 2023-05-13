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
            {!! csrf_field() !!}
            <div class="form-group">
                <label for="formGroupExampleInput">Username</label>
                <input type="text" class="form-control" name="username" placeholder="Item name"
                    value="{{ $user->username}}" readonly>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Name</label>
                <input type="text" class="form-control" name="name" placeholder="Category"
                    value="{{ $user['name'] }}">
                <span style="color: red">
                    @error('category')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Address</label>
                <input type="text" class="form-control" name="address" placeholder="Cost"
                    value="{{ $user['address'] }}">
                <span style="color: red">
                    @error('cost')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Phone Number</label>
                <input type="text" class="form-control" name="phone_num" placeholder="Price"
                    value="{{ $user['phone_num'] }}">
                <span style="color: red">
                    @error('price')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Email</label>
                {{-- <div class="input-group"><button type="button" wire:loading.attr="disabled" wire:click="decrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">-</button> --}}
                <input type="text" class="form-control" name="email" placeholder="In stock quantity"
                    value="{{ $user['email'] }}">
                    {{-- <button type="button" wire:loading.attr="disabled" wire:click="incrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">+</button></div> --}}
                <span style="color: red">
                    @error('quantity')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Role</label>
                {{-- <div class="input-group"><button type="button" wire:loading.attr="disabled" wire:click="decrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">-</button> --}}
                <input type="text" class="form-control" name="role" placeholder="In stock quantity"
                    value="{{ $user['role'] }}">
                    {{-- <button type="button" wire:loading.attr="disabled" wire:click="incrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">+</button></div> --}}
                <span style="color: red">
                    @error('quantity')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Password</label>
                {{-- <div class="input-group"><button type="button" wire:loading.attr="disabled" wire:click="decrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">-</button> --}}
                <input type="text" class="form-control" name="password" 
                value="{{ old('confirm_password') }}">
                    {{-- <button type="button" wire:loading.attr="disabled" wire:click="incrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">+</button></div> --}}
                <span style="color: red">
                    @error('quantity')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Confirm Password</label>
                <input type="password" class="form-control" name="confirm_password" 
                    value="{{ old('confirm_password') }}">
                <span style="color: red">
                    @error('confirm_password')
                        {{ $message }}
                    @enderror
                </span>
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
        <form method="POST" action="{{ route('inventory.delete', $user->id) }}">
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
