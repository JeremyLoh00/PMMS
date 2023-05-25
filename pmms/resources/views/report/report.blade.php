@include('navbar.report')


<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--Add successfully alert-->
    @if (session('message'))
        <div id="success" class="alert alert-success">{{ session('message') }}
            <button type="button" class="close", data-dismiss="alert">
                <x-govicon-times style="color: black" />
            </button>
        </div>
        <script>
            $(document).ready(function () {
                setTimeout(function () {
                    $('#success').alert('close');
                }, 5000); // Close the alert after 5 seconds (5000 milliseconds)
            });
        </script>
    @endif
    @if (Session::has('alert'))
        <div class="alert alert-{{ Session::get('alert-type') }}">
            {{ Session::get('alert') }}
        </div>
    @endif
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
        integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.14.3/dist/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous">
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.1.3/dist/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous">
    </script>

</head>

<body style="background-color: #98dde2;">
    <div
        style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
        <h3>
            Report List
        </h3>
            
            <div  style="margin: 5px; padding: 5px; display: flex; justify-content: space-between;" >
            
                
                <form action="/searchReport" method="GET">
                    <input type="text" name="query" placeholder="Search" value="{{ request('query') }}">
                    <button type="submit" style="width: 30px; height: 30px; border: none; background-color: white; bottom: 5%;">
                        <x-ri-search-line style="color: #98dde2" />
                    </button>
                </form>

               

                
                <form id='selectDate' action="{{ route('reports.reports') }}" method="POST">
                        @csrf
                    <select name="filter" id="filterSelect" onchange="select()">
                     
                             <option id="selectText" value="selectText" hidden selected>{{ $selectText }}</option> 
                            <option  value="Daily"  {{ old('filter')=='Daily' ? 'selected' : '' }}>Today</option>
                            <option  value="weekly" {{ old('filter')=='weekly' ? 'selected' : '' }}>This Week</option>
                            <option  value="monthly" {{ old('filter')=='monthly' ? 'selected' : '' }}>This Month</option>
                            <option  value="yearly"  {{ old('filter')=='yearly' ? 'selected' : '' }}>This Year</option>
                     
                         
                    </select>
                   
                </form>

                
                
                
            </div>
            
        

            <script>
              

                function select(){
                    document.getElementById('selectDate').submit();


                }
    

            </script>
          
      
        
        

        <table class="table">
			<thead style="background-color: #98dde2">
				<tr>
					<th scope="col">No.</th>
					<th scope="col">Item Name</th>
					<th scope="col">Category</th>
					<th scope="col">Profit Price</th>
					<th scope="col">Quantity Sold</th>

					<th scope="col">Quantity Sold Before</th>
					<th scope="col">Quantity Sold After</th>

					<th scope="col">Profit Earned</th>
					<th scope="col"> </th>
				</tr>
			</thead>
			<tbody>
				@php
				$sum=0;
				@endphp
				@foreach ($items as $item)
				@php
				$itemSum = ($item->cost - $item->price) * $item->cart_quantity;
				$sum += $itemSum;
				@endphp
				<tr>
					<th>{{ $loop->iteration }}</th>
					<td> {{ $item->name }}</td>
					<td>{{ $item->category }}</td>
					<td>{{ $item->cost - $item->price }}</td>
					<td>{{ $item->cart_quantity }}</td>
					<td>{{ $item->inventory_quantity  }}</td>
					<td>{{ $item->inventory_quantity - $item->cart_quantity }}</td>
					<td>{{ $itemSum }}</td>
				</tr>
				@endforeach
				<tr>
					<td colspan="7"></td>
					<th>Sum: RM {{ $sum }}</th>
                    
				</tr>
			</tbody>
           
		</table>
        {{ $items->links() }}
        
            
            <h3 style="text-align: center">
                Total Profit Earned: RM {{ $totalProfit }}
            </h3>

      
    </div>

 
   

   
</body>



</html>
