@include('navbar.inventory')

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
            Item List
        </h3>
        <div style="margin: 5px; padding: 5px;">
            <form action="" method="GET">
                <input type="text" name="query" placeholder="Search..." value="{{ request('query') }}">
                <button type="submit" style="width: 35px; height: 35px; border: none; background-color: none">
                    <x-ri-search-line style="color: #00A3D8" />
                </button>
            </form>
            
        </div>

        <table class="table">
            <thead class="thead-dark">
                <tr>
                    <th scope="col">Item Name</th>
                    <th scope="col">Category</th>
                    <th scope="col">Cost</th>
                    <th scope="col">Sell Price</th>
                    <th scope="col">In Stock</th>
                    <th scope="col">Add Stock</th>
                    <th scope="col">Deduct Stock</th>
                    <th scope="col"> </th>
                </tr>
            </thead>
            <tbody>
                @foreach ($inventory as $inv)
                    <tr>
                        <th scope="row">{{ $inv['name'] }}</th>
                        <td>{{ $inv['category'] }}</td>
                        <td>{{ $inv['cost'] }}</td>
                        <td>{{ $inv['price'] }}</td>
                        <td style="color: {{ $inv['quantity'] <= 5 ? 'red' : 'black' }}">{{ $inv['quantity'] }}</td>
                        <td>
                            <a href={{ 'add_stock/' . $inv['id'] }}>
                                <x-ri-add-fill style="width: 30px; height: 30px; color: #00A3D8;" />
                            </a>
                        </td>
                        <td>
                            <a href={{ 'deduct_stock/' . $inv['id'] }}>
                                <x-feathericon-minus style="width: 30px; height: 30px; color: #00A3D8;" />
                            </a>
                        </td>
                        <td>
                            <a href={{ 'edit_inventory/' . $inv['id'] }}>
                                <x-uni-pen-o style="width: 30px; height: 30px; color: #00A3D8;" />
                            </a>
                        </td>
                        {{-- <td>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#incrementModal">+</button>
                        </td> --}}
                    </tr>
                @endforeach

            </tbody>
        </table>
        {{ $inventory->links() }}
    </div>
    <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
        <a href="/add_inventory"><button
                style="width: 60px; height: 60px; padding: 15px; border-radius: 50%; background-color: #00A3D8; border: none; left: 50%; box-shadow: 3px 3px rgba(0, 0, 0, 0.02); active: none">
                <x-monoicon-add style="color: white;" />
            </button></a>
    </div>
</body>
{{-- Increment --}}
{{-- <div class="modal fade" id="incrementModal" tabindex="-1" role="dialog" aria-labelledby="incrementModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content"><form>
        <div class="modal-header">
          <h5 class="modal-title" id="incrementModalLabel">Add stock</h5>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          
            <div class="form-group">
              <label for="recipient-name" class="col-form-label">Quantity</label>
              <input type="text" class="form-control" id="recipient-name">
            </div>
            <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
          <a><button type="button" class="btn btn-primary">Add</button></a>
         
        </div>
        
        </div> </form>
      </div>
    </div>
  </div> --}}

</html>
