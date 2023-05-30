<?php
<<<<<<< Updated upstream
<<<<<<< Updated upstream

use App\Models\Inventory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\LogoutController;
=======
use App\Models\Cart;
use App\Models\Inventory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

=======
use App\Models\Cart;
use App\Models\Inventory;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
>>>>>>> Stashed changes
use App\Http\Controllers\CartController;
use Illuminate\Support\Facades\Redirect;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\LogoutController;
use App\Http\Controllers\ReportController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\roster_controller;
use App\Http\Controllers\InventoryController;
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

<<<<<<< Updated upstream
Route::get('/', function () {
    return view('welcome');
});
=======
// Route::get('/', function () {
//     return redirect()->route('login');
// });

>>>>>>> Stashed changes

// Route::get('/inventory', function () {
//     return view('inventory');
// });

Route::get('/schedule', function () {
    return view('schedule');
});

Route::get('/payment', function () {
    return view('payment');
});
// Route::get('/users', function () {
//     return view('User.view_user');
// });


//INVENTORY
//Access inventory in view and call index func in controller 
Route::get('/inventory', [InventoryController::class, 'Index']);

//Access add inventory page by calling the func in controller
Route::get('/add_inventory', [InventoryController::class, 'Create']);

//call store func in the controller to store data into database
Route::POST('store', [InventoryController::class, 'Store']);

//Access edit inventory page by calling the func in controller
Route::get('/edit_inventory/{id}', [InventoryController::class, 'Edit']);

//Access edit inventory page by calling the func in controller
Route::post('/update/{id}', [InventoryController::class, 'Update']);

//Access edit inventory page by calling the func in controller
Route::post('/increment/{id}', [InventoryController::class, 'Increment']);

//Access the function of delete inside con
Route::delete('/delete/{id}', [InventoryController::class, 'delete'])->name('inventory.delete');


Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');


//LOGIN

 //Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');

 Route::get('/login', [App\Http\Controllers\Auth\LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'login']);

//Route::match(['get', 'post'], '/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');

Route::post('/logout', [App\Http\Controllers\Auth\LogoutController::class, 'logout'])->name('logout');


// Routes middleware 
Route::group(['middleware' => 'role:Admin'], function () {
        // Your admin-only routes
        //USERS
        //redirect to view_user page
        Route::get('/users', [user_controller::class, 'show']);

        //Access add add_user page by calling the func in controller
        Route::get('/add_user', [user_controller::class, 'create']);

        //call store func in the controller to store data into database
        Route::POST('/store', [user_controller::class, 'store']);

        //Access edit inventory page by calling the func in controller
        Route::get('/edit_user/{id}', [user_controller::class, 'index']);

        //Access edit user page by calling the func in controller
        Route::post('/update-user/{id}', [user_controller::class, 'update']);

        //Access the function of delete inside con
        Route::delete('/delete-user/{id}', [user_controller::class, 'delete'])->name('User.delete');
});

Route::group(['middleware' => 'role:Cashier'], function () {

});

Route::group(['middleware' => 'role:Secretary'], function () {

});

Route::group(['middleware' => 'role:Treasurer'], function () {

});

Route::group(['middleware' => 'role:Coordinator'], function () {

});

