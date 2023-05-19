@include('navbar.payment')
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <style>
        .grid-item {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: none;
            background-color: #98dde2;
            color: #000;
            font-size: 18px;
            margin: 5px;
            text-align: center;
            padding: 15px;
            cursor: pointer;
        }
    </style>
</head>
<body style="background-color: #98dde2;">
    <div style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <h3 style="text-align: center">Payment</h3>
        <br>
            @if(session('error'))
            <div class="alert alert-danger">
                {{ session('error') }}
            </div>
        @endif
        <form action="{{ route('payment.refund') }}" method="post" id="proceedForm">
            @csrf
            <input type="hidden" name="amount" value="{{ $amount }}">
            <table style="width:100%;font-size:20px">
                <thead style="background-color: #98dde2; height:1cm">
                    <tr>
                        <th style="text-align: center">Total Amount</th>
                        <th style="text-align: right">RM {{ number_format($amount,2) }}</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="text-align: center">Enter Amount</td>
                        <td style="text-align: right">RM <input type="text" name="answer"  id="amountGiven" required></td>
                    </tr>
                </tbody>
            </table>
            <br>
            {{-- Numpad --}}
            <div class="grid-container" style="display:grid;grid-template-columns: auto auto auto;justify-content:center;align-items:center">
                <div><input type="button" class="grid-item" value="7" onclick="answer.value +='7'"></div>
                <div><input type="button" class="grid-item" value="8" onclick="answer.value +='8'"></div>
                <div><input type="button" class="grid-item" value="9" onclick="answer.value +='9'"></div>  
                <div><input type="button" class="grid-item" value="4" onclick="answer.value +='4'"></div>
                <div><input type="button" class="grid-item" value="5" onclick="answer.value +='5'"></div>
                <div><input type="button" class="grid-item" value="6" onclick="answer.value +='6'"></div>  
                <div><input type="button" class="grid-item" value="1" onclick="answer.value +='1'"></div>
                <div><input type="button" class="grid-item" value="2" onclick="answer.value +='2'"></div>
                <div><input type="button" class="grid-item" value="3" onclick="answer.value +='3'"></div> 
                <div><input type="button" class="grid-item" value="." onclick="answer.value +='.'"></div>
                <div><input type="button" class="grid-item" value="0" onclick="answer.value +='0'"></div>
                <div><input type="button" class="grid-item" value="<" onclick="answer.value =''" style="color:red; font-weight:1000"></div>     
                
            </div>
            <br>
            <div style="display:flex;justify-content:center; font-size: 20px">
                <div style="margin-right:15cm">Payment Method</div>
                <div>
                    <select name="method" id="method" required>
                        <option value="Cash">Cash</option>
                        <option value="Card">Card</option>
                        <option value="E-Wallet">E-Wallet</option>
                    </select>
                </div>
            </div>
        </form>
    </div>

    <h4>
        <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
            <div>
                <form action="{{ route('cart.deleteAll') }}" method="post">
                    @csrf
                    @method('delete')
                    {{-- Confirmation to delete all items in the cart --}}
                    <span style="margin-right: 10px">
                        <button type="button" class="btn btn-outline-primary"
                            style="margin-right:2cm;width: 120px;height:auto; background-color: white; bottom: 5%; color:#03c2fc; border-color:#03c2fc;cursor: pointer;"
                            onclick="return confirm('Are you sure to cancel this payment? ')">Cancel</button>
                    </span>
                </form>
            </div>
            <div>
                @csrf
                {{-- Proceed to payment --}}
                <span>
                    <button type="submit" class="btn btn-primary"
                        style="width: 130px; border-radius: 5px" form="proceedForm">Proceed</button>
                </span>
            </div>
        </div>
    </h4>
</body>
</html>

