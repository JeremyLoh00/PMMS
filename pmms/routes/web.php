<?php

use App\Models\Inventory;
use App\Models\Cart;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\LogoutController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ReportController;

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

Route::get('/', function () {
    return Redirect::to('reports');
});

// Route::get('/inventory', function () {
//     return view('inventory');
// });

  Route::get('/reports', function () {
     return view('reports');
  });

Route::get('/schedule', function () {
    return view('schedule');
});



// Route::get('/users', function () {
//     return view('User.view_user');
// });


//INVENTORY
//Access inventory in view and call index func in controller 
Route::get('/inventory', [InventoryController::class, 'Index']);

//Access inventory in view and call index func in controller 
Route::get('/search', [InventoryController::class, 'search']);

//Access add inventory page by calling the func in controller
Route::get('/add_inventory', [InventoryController::class, 'Create']);

//call store func in the controller to store data into database
Route::POST('store', [InventoryController::class, 'Store']);

//Access edit inventory page by calling the func in controller
Route::get('/edit_inventory/{id}', [InventoryController::class, 'Edit']);

//Access edit inventory page by calling the func in controller
Route::post('/update/{id}', [InventoryController::class, 'Update']);

//Access add stock page by calling the func in controller
Route::get('/add_stock/{id}', [InventoryController::class, 'Add']);

//Access add stock update func by calling the func in controller
Route::post('/increment/{id}', [InventoryController::class, 'Increment']);

//Access deduct stock page by calling the func in controller
Route::get('/deduct_stock/{id}', [InventoryController::class, 'Deduct']);

//Access deduct stock func by calling the func in controller
Route::post('/decrement/{id}', [InventoryController::class, 'Decrement']);

//Access the function of delete inside con
Route::delete('/delete/{id}', [InventoryController::class, 'delete'])->name('inventory.delete');



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
Auth::routes();

// Route::get('/home', [App\Http\Controllers\HomeController::class, 'index'])->name('home');


//LOGIN

Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'login'])->name('login');

Route::post('/logout', [App\Http\Controllers\Auth\LogoutController::class, 'logout'])->name('logout');

//PAYMENT & CART
Route::get('/cart',[PaymentController::class,'index'])->name('cart');
//Add Item into Cart
Route::post('/cart',[PaymentController::class,'addItem'])->name('cart.add_item');
//Add Quantity in cart
Route::get('/cart/{id}/add',[PaymentController::class,'addQuantity'])->name('cart.increment');
//Minus Quantity in cart
Route::get('/cart/{id}/minus',[PaymentController::class,'minusQuantity'])->name('cart.decrement');
//Delete Item in cart
Route::delete('/cart/{id}',[PaymentController::class,'destroy'])->name('cart.delete');
//Delete All Item in cart
Route::delete('/cart',[PaymentController::class,'destroyAll'])->name('cart.deleteAll');
//Proceed to Payment
Route::post('/payment',[PaymentController::class,'proceedPayment'])->name('payment');
//Proceed to Refund
Route::post('/refund',[PaymentController::class,'storePayment'])->name('payment.refund');


//Report
//Access report in view and call index func in controller 
Route::get('/reports', [ReportController::class, 'reports']);
//Access report in view and call func in controller 
Route::get('/searchReport', [ReportController::class, 'searchReport']);
//get report select time period request
Route::post('/reports', [ReportController::class, 'reports'])->name('reports.reports');








