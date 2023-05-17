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
        
            <form action="/search" method="POST">
                <div style="display:flex; justify-content:space-between ">
                <div>
                    <input type="text" placeholder="Item Code" style="height:auto">
                </div>
                <div>
                    <input type="submit" style="width: 100px;height:auto; border: none; background-color: lightgreen; bottom: 5%;cursor: pointer;" value =" Add ">
                
                </div>
            </div>
            </form>
            <br>
            <table style="width:100%">
            <thead style="background-color: #98dde2; height:1cm">
                <tr>
                <th>Item Name</th>
                <th>Category</th>
                <th>Unit Price</th>
                <th>Quantity</th>
                <th>Total Price</th>
                <th>Action</th>
                </tr>
                </thead>
                <tbody>
                
                </tbody>
                </table>
                <br>

    <div  style="font-size:20px; display:flex; justify-content:space-between">
        <div>Total Amount</div>
        <div>RM20.00</div>
    </div>
    
</div>
</body>
    <h4>
        <div style="display:flex;justify-content:center">
            <div>
                <input type="submit" style="margin-right:2cm;width: 120px;height:auto; background-color: white; bottom: 5%; color:#03c2fc; border-color:#03c2fc;cursor: pointer;" value =" Cancel ">
            </div>
            <div>
                <input type="submit" style="width: 120px;height:auto; border-color:#03c2fc; background-color:#03c2fc;color:white; bottom: 5%;cursor: pointer; " value =" Proceed ">
            </div>
        </div>
       
    </h4>
</html>
