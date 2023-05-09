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
            Add Stock
        </h3>
        <form action="/increment/{{ $inventory->id }}" method="POST">
            {!! csrf_field() !!}
            <div class="form-group">
                <label for="formGroupExampleInput2">Quantity</label>
                {{-- <div class="input-group"><button type="button" wire:loading.attr="disabled" wire:click="decrementQuantity({{ $inventory['quantity'] }})" class= "btn btn1">-</button> --}}
                <input type="text" class="form-control" name="quantity" placeholder="Quantity"
                    >
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
</html>
