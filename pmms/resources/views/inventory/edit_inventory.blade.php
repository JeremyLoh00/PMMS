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
            Edit Inventory
        </h3>
        <form action="/update/{{ $inventory->id }}" method="POST">
            {!! csrf_field() !!}
            <div class="form-group">
                <label for="formGroupExampleInput">Item name</label>
                <input type="text" class="form-control" name="name" placeholder="Item name"
                    value="{{ $inventory['name'] }}">
                <span style="color: red">
                    @error('name')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Category</label>
                <input type="text" class="form-control" name="category" placeholder="Category"
                    value="{{ $inventory['category'] }}">
                <span style="color: red">
                    @error('category')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Cost</label>
                <input type="text" class="form-control" name="cost" placeholder="Cost"
                    value="{{ $inventory['cost'] }}">
                <span style="color: red">
                    @error('cost')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Price</label>
                <input type="text" class="form-control" name="price" placeholder="Price"
                    value="{{ $inventory['price'] }}">
                <span style="color: red">
                    @error('price')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">In Stock</label>
                {{-- <div class="input-group"><button type="button" wire:loading.attr="disabled" wire:click="decrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">-</button> --}}
                <input type="text" class="form-control" name="quantity" placeholder="In stock quantity"
                    value="{{ $inventory['quantity'] }}">
                    {{-- <button type="button" wire:loading.attr="disabled" wire:click="incrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">+</button></div> --}}
                <span style="color: red">
                    @error('quantity')
                        {{ $message }}
                    @enderror
                </span>
            </div>
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
                <span style="margin-right: 10px"><a href="/inventory"><button type="button"
                            class="btn btn-outline-primary"
                            style="width: 130px; border-radius: 5px">Cancel</button></a></span>
                <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Update</button></span>
            </div>
        </form>

    </div>
    <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
        <form method="POST" action="{{ route('inventory.delete', $inventory->id) }}">
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
