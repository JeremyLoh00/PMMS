@include('navbar.payment')
<!DOCTYPE html>
<html lang="en">

</html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
</head>
<style>
.next{
    width: 60px;
    height: 60px;
    border-radius: 50%;
    border: none;
    background-color: #03c2fc;
    color: white;
    font-size: 30px;
    text-align: center;
    cursor: pointer;
    vertical-align: middle
}
</style>
<body style="background-color: #98dde2;">
    <div style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <h3 style="text-align:center">
            Change
        </h3>
            <br>
            <div  style="font-size:20px; display:flex; justify-content:space-between">
                <div>Change</div>
                <div>RM {{ number_format($refund,2)}}</div>
            </div>
            <br>
            <div  style="font-size:20px; display:flex; justify-content:space-between">
                <div>Payment Method: </div>
                <div>{{ $payment->method }}</div>
            </div>
            <table style="width:100%">
                <thead style="background-color: #98dde2; height:1cm">
                    <tr>
                    <th>Item Name</th>
                    <th>Category</th>
                    <th>Unit Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    </tr>
                    </thead>
                    <tbody>
                    @foreach ($carts as $cart)
                    <tr>
                    <td>{{$cart->name}}</td>
                    <td>{{$cart->category}}</td>
                    <td>{{$cart->price}}</td>
                    <td>{{$cart->quantity}}</td>
                    <td>{{number_format($cart->total,2)}}</td>
                    </td>
                    @endforeach
                    </tbody>
                    </table>
                <br>
                <div  style="font-size:20px; display:flex; justify-content:space-between">
                    <div>Total Amount</div>
                    <div>RM {{ number_format($payment->totalPrice,2) }}</div>
                </div>
                <br>
                
    
</div>
</body>
    <h4>
        <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <a href="/cart"><button
                    style="width: 60px; height: 60px; padding: 15px; border-radius: 50%; background-color: #00A3D8; border: none; left: 50%; box-shadow: 3px 3px rgba(0, 0, 0, 0.02); cursor: pointer;font-weight:1000; color:white" value="Next">
                </button></a>
        </div>
    </h4>
</html>
