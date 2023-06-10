@include('navbar.payment')
<!DOCTYPE html>
<html lang="en">

</html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>

<body style="background-color: #98dde2;">
    <div style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <h3 style="text-align:center">
            Cart
        </h3>
        @if (session('error'))
                <div class="alert alert-danger" style="text-align: center">
                    {{ session('error') }}
                </div>
        @endif
            <form action="{{ route('cart.add_item') }}" method="post">
                @csrf
                <div style="display:flex; justify-content:space-between ">
                <div>
                    <input type="text" placeholder="Item Code" name="item" id="item" style="height:auto">
                </div>
                <div>
                    <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Add</button></span>
                </div>
            </div>
            </form>
            <br>
            <table style="width:100%">
            <thead style="background-color: #98dde2; height:1cm">
                <tr>
                <th>Item Name</th>
                <th>Category</th>
                <th>Unit Price (RM)</th>
                <th>Quantity</th>
                <th>Total Price (RM)</th>
                <th>Action</th>
                <th></th>
                </tr>
                </thead>
                <tbody>
                    @foreach ($carts as $cart)
                    <tr>
                        <td>{{$cart->name}}</td>
                        <td>{{$cart->category}}</td>
                        <td>{{$cart->price}}</td>
                        <td>{{ $cart->quantity }}</td>
                        <td>{{number_format($cart->total,2)}}</td>
                        <td> 
                            <a href= "{{ route('cart.increment', $cart->id) }}">
                                <x-ri-add-fill style="width: 30px; height: 30px; color: #00A3D8; margin-right:5px" />
                            </a>
                            <a href="{{ route('cart.decrement',$cart->id) }}">
                                <x-feathericon-minus style="width: 30px; height: 30px; color: #00A3D8" />
                            </a>
                        </td>
                        <td>
                            <form action="{{ route('cart.delete',$cart->id) }}" method="post">
                                @csrf
                                @method('delete')
                                <button type="submit" style="background-color:white; border:none;cursor: pointer;">    
                                <x-feathericon-trash-2 style="width: 30px; height: 30px; color: red;text-align:right" />
                                </button>
                            </form>
                        </td>
                    @endforeach
                </tbody>
                </table>
                <br>

    <div  style="font-size:20px; display:flex; justify-content:space-between">
        <div>Total Amount</div>
        <div>RM {{ number_format($amount,2) }}</div>
    </div>
    
</div>
</body>
    <h4>
        
        <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <div>
                <form action="{{ route('cart.deleteAll') }}" method="post">
                @csrf
                
                @method('delete')
                {{-- Confirmation to delete all items in the cart --}}
                <span style="margin-right: 10px"><button type="submit" class="btn btn-outline-primary"
                    style="margin-right:2cm;width: 120px;height:auto; background-color: white; bottom: 5%; color:#03c2fc; border-color:#03c2fc;cursor: pointer;" onclick="return confirm('Are you sure you want to cancel the payment?')">Cancel</button></span>
                </form>
            </div>
            <div>
                <form action="{{ route('payment') }}" method="post">
                @csrf
                {{-- Proceed to payment --}}
                    <span><button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px">Proceed</button></span>
                        <input type="hidden" name="amount" value="{{ $amount }}">
                </form>
            </div>
        </div>
    </h4>
    
</html>
