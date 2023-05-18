@include('navbar.roster')

<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--Add successfully alert-->
    @if(session('message'))
    <div class="alert alert-success">{{session('message')}}
    <button type="button" class="close", data-dismiss="alert"><x-govicon-times style="color: black"/></button></div>
    @endif
    

    <!-- Fonts --->
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
    <div style="margin: 50px; background-color: white; padding: 30px; border-radius: 10px; box-shadow: 3px 9px rgba(0, 0, 0, 0.02);">
      <h3>
      Schedule ({{ session('role') }})
      </h3>
        <table class="table">
            <div style="margin: 5px; padding: 5px;">
                <form action="" method="">
                    <div class="row align-items-center">
                        <div class="col-1">
                            <h5 label for="" input type="text" class="" name="name" placeholder="" value="" readonly>Name</h5>
                            <h5 label for="" input type="text" class="" name="role" placeholder="" value="" readonly>Role</h5>
                            
                        </div>
                    </div>  
                </form>
            </div>

                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Date</th>
                        <th scope="col">Day</th>
                        <th scope="col">Time In</th>
                        <th scope="col">Time Out</th>
                        <th scope="col">Total Hour</th>
                        <th scope="col">Rate</th>
                        <th scope="col">Action </th>
                    </tr>
                </thead>
                <tbody>
                    
                <th scope="row"> </th>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                        
                            <td>
                                <a href='/edit_schedule_page'>
                                    <x-uni-pen-o style="width: 30px; height: 30px; color: #00A3D8;" />
                                </a>

                                <a href=''>
                                    <x-uni-trash-o style="width: 30px; height: 30px; color: red;" />
                                </a>

                            </td>
                            {{-- <td>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#incrementModal">+</button>
                            </td> --}}
                        </tr>
                </tbody>
        </table>
        
    </div>
    <div style="margin: 50px; align-items: center; justify-content: center; display: flex;">
    <a href="/add_schedule"><button style="width: 60px; height: 60px; padding: 15px; border-radius: 50%; background-color: #00A3D8; border: none; left: 50%; box-shadow: 3px 3px rgba(0, 0, 0, 0.02); active: none"><x-monoicon-add style="color: white;"/></button></a>
    </div>
</body>
{{-- Increment --}}
<div class="modal fade" id="incrementModal" tabindex="-1" role="dialog" aria-labelledby="incrementModalLabel" aria-hidden="true">
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
  </div>

</html>