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
.grid-item{
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
<body style="background-color: #98dde2;">
    <div style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <h3 style="text-align:center">
            Payment
        </h3>
            <br>
            <table style="width:100%;font-size:20px">
            <thead style="background-color: #98dde2; height:1cm">
                <tr>
                    <th style="text-align: center">Total Amount</th>
                    <th style="text-align: right">RM20.00</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td style="text-align: center">Enter Amount</td>
                    <td style="text-align: right">RM50.00</td>
                </tr>
                </tbody>
                </table>
                <br>
                {{-- Numpad --}}
                <div class="grid-container" style="display:grid;grid-template-columns: auto auto auto;justify-content:center;align-items:center">
                    <div><input type="button" class="grid-item" value="7"></div>
                    <div><input type="button" class="grid-item" value="8"></div>
                    <div><input type="button" class="grid-item" value="9"></div>  
                    <div><input type="button" class="grid-item" value="4"></div>
                    <div><input type="button" class="grid-item" value="5"></div>
                    <div><input type="button" class="grid-item" value="6"></div>  
                    <div><input type="button" class="grid-item" value="1"></div>
                    <div><input type="button" class="grid-item" value="2"></div>
                    <div><input type="button" class="grid-item" value="3"></div> 
                    <div><input type="button" class="grid-item" value="."></div>
                    <div><input type="button" class="grid-item" value="0"></div>
                    <div><input type="button" class="grid-item" value="<"></div>     
                </div>
<br>
                <div style="display:flex;justify-content:center; font-size: 20px">
                    <div style="margin-right:15cm">
                        Payment Method
                    </div>
                    <div>
                        <input type="submit" style="margin-right:2cm;width: 120px;height:auto; border-color:#03c2fc; background-color:#03c2fc;color:white; bottom: 5%;cursor: pointer;" value =" E-Wallet ">
                    </div>
                    <div>
                        <input type="submit" style="margin-right:2cm;width: 120px;height:auto; border-color:#03c2fc; background-color:#03c2fc;color:white; bottom: 5%;cursor: pointer;" value =" Cash ">
                    </div>
                    <div>
                        <input type="submit" style="width: 120px;height:auto; border-color:#03c2fc; background-color:#03c2fc;color:white; bottom: 5%;cursor: pointer;" value =" Card ">
                    </div>
                </div>
    
</div>
</body>
    <h4>
        <div style="display:flex;justify-content:center">
            <div>
                <input type="submit" style="margin-right:2cm;width: 120px;height:auto; background-color: white; bottom: 5%; color:#03c2fc; border-color:#03c2fc;cursor: pointer;" value =" Cancel ">
            </div>
            <div>
                <input type="submit" style="width: 120px;height:auto; border-color:#03c2fc; background-color:#03c2fc;color:white; bottom: 5%;cursor: pointer;" value =" Proceed ">
            </div>
        </div>
    
    </h4>
</html>
