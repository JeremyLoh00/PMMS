@include('navbar.inventory')
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
            Add Inventory
        </h3>
        <form action="/store_inventory" method="POST">
            @csrf
            <div class="form-group">
                <label for="formGroupExampleInput">Item name</label>
                <input type="text" class="form-control" name="name" placeholder="Item name">
                <span style="color: red">@error('name'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Category</label>
                <input type="text" class="form-control" name="category" placeholder="Category">
                <span style="color: red">@error('category'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Cost</label>
                <input type="text" class="form-control" name="cost" placeholder="Cost">
                <span style="color: red">@error('cost'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">Price</label>
                <input type="text" class="form-control" name="price" placeholder="Price">
                <span style="color: red">@error('price'){{ $message }} @enderror</span>
            </div>
            <div class="form-group">
                <label for="formGroupExampleInput2">In Stock</label>
                <input type="text" class="form-control" name="quantity" placeholder="In stock quantity">
                <span style="color: red">@error('quantity'){{ $message }} @enderror</span>
            </div>
            <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <span style="margin-right: 10px"><a href="/inventory"><button type="button" class="btn btn-outline-primary"
                        style="width: 130px; border-radius: 5px">Cancel</button></a></span>
            <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
        </div>
        </form>
        
    </div>
</body>

</html>
