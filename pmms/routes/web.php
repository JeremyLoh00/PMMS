<?php

use App\Models\Inventory;
use App\Models\Cart;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\user_controller;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\roster_controller;
use App\Http\Controllers\LogoutController;
use App\Http\Controllers\PaymentController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\ReportController;
use Illuminate\Support\Facades\Redirect;
use App\Http\Middleware\UserAuthorizedMiddleware;

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
    return Redirect::to('login');
});
//LOGIN

Route::get('/login', [App\Http\Controllers\Auth\LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [App\Http\Controllers\Auth\LoginController::class, 'login']);
Route::post('/logout', [App\Http\Controllers\Auth\LogoutController::class, 'logout'])->name('logout');

 Route::group(['middleware' => ['user.authorized:Admin']], function () {
    // Define routes here
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

    //INVENTORY
    //Access inventory in view and call index func in controller 
    Route::get('/inventory', [InventoryController::class, 'Index']);
    //Access inventory in view and call index func in controller 
    Route::get('/search_inventory', [InventoryController::class, 'search']);
    //Access add inventory page by calling the func in controller
    Route::get('/add_inventory', [InventoryController::class, 'Create']);
    //call store func in the controller to store data into database
    Route::POST('/store_inventory', [InventoryController::class, 'Store']);
    //Access edit inventory page by calling the func in controller
    Route::get('/edit_inventory/{id}', [InventoryController::class, 'Edit']);
    //Access edit inventory page by calling the func in controller
    Route::post('/update_inventory/{id}', [InventoryController::class, 'Update']);
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
    

    //Schedule
    //Access schedule page for admin by calling the func in controller
    Route::get('/rosterAdmin', [roster_controller::class, 'showlistadmin'])->name('rosterAdmin');
    //Access add schedule for both admin and committee by calling the func in controller
    Route::get('/add_schedule', [roster_controller::class, 'create']);
    //Access update schedule time page by calling the func in controller
    Route::post('/update-schedule-time/{id}', [roster_controller::class, 'update']);
    //Access edit schedule time page by calling the func in controller
    Route::get('/edit_schedule_time/{id}', [roster_controller::class, 'indexadmin']);
    //Access add schedule for both admin and committee by calling the func in controller
    Route::get('/add_schedule', [roster_controller::class, 'create']);
    //Access store for both admin and committee by calling the func in controller
    Route::post('/roster/store', [roster_controller::class, 'store'])->name('roster/store');
    //Access filter for both admin and committee by calling the func in controller
    Route::get('/roster/filter', [roster_controller::class, 'filter'])->name('roster.filter');
    //Access delete for both admin and committee by calling the func in controller
    Route::delete('/roster-delete/{id}', [roster_controller::class, 'delete'])->name('delete');

    //Report
    //Access report in view and call index func in controller 
    Route::get('/reports', [ReportController::class, 'reports']);
    //Access report in view and call func in controller 
    Route::get('/searchReport', [ReportController::class, 'searchReport']);
    //get report select time period request
    Route::post('/reports', [ReportController::class, 'reports'])->name('reports.reports'); 
});


// Routes accessible to Admin







// Routes accessible to Cashier
Route::group(['middleware' => ['auth', 'user.authorized:Cashier']], function () {
    // Define routes here
     //INVENTORY
    //Access inventory in view and call index func in controller 
    Route::get('/inventory', [InventoryController::class, 'Index']);
    //Access inventory in view and call index func in controller 
    Route::get('/search_inventory', [InventoryController::class, 'search']);
    // //Access add inventory page by calling the func in controller
    // Route::get('/add_inventory', [InventoryController::class, 'Create']);
    // //call store func in the controller to store data into database
    // Route::POST('/store_inventory', [InventoryController::class, 'Store']);
    // //Access edit inventory page by calling the func in controller
    // Route::get('/edit_inventory/{id}', [InventoryController::class, 'Edit']);
    // //Access edit inventory page by calling the func in controller
    // Route::post('/update_inventory/{id}', [InventoryController::class, 'Update']);
    // //Access add stock page by calling the func in controller
    // Route::get('/add_stock/{id}', [InventoryController::class, 'Add']);
    // //Access add stock update func by calling the func in controller
    // Route::post('/increment/{id}', [InventoryController::class, 'Increment']);
    // //Access deduct stock page by calling the func in controller
    // Route::get('/deduct_stock/{id}', [InventoryController::class, 'Deduct']);
    // //Access deduct stock func by calling the func in controller
    // Route::post('/decrement/{id}', [InventoryController::class, 'Decrement']);
    // //Access the function of delete inside con
    // Route::delete('/delete/{id}', [InventoryController::class, 'delete'])->name('inventory.delete');

    //PAYMENT & CART
    Route::get('/cart', [PaymentController::class, 'index'])->name('cart');
    //Add Item into Cart
    Route::post('/cart', [PaymentController::class, 'addItem'])->name('cart.add_item');
    //Add Quantity in cart
    Route::get('/cart/{id}/add', [PaymentController::class, 'addQuantity'])->name('cart.increment');
    //Minus Quantity in cart
    Route::get('/cart/{id}/minus', [PaymentController::class, 'minusQuantity'])->name('cart.decrement');
    //Delete Item in cart
    Route::delete('/cart/{id}', [PaymentController::class, 'destroy'])->name('cart.delete');
    //Delete All Item in cart
    Route::delete('/cart', [PaymentController::class, 'destroyAll'])->name('cart.deleteAll');
    //Proceed to Payment
    Route::post('/payment', [PaymentController::class, 'proceedPayment'])->name('payment');
    //Proceed to Payment
    Route::get('/payment', [PaymentController::class, 'proceedPayment'])->name('payment.back');
    //Proceed to Refund
    Route::post('/refund', [PaymentController::class, 'storePayment'])->name('payment.refund');

    //Schedule
    //redirect to roster committee page
    Route::get('/rosterCommittee', [roster_controller::class, 'showlistcommittee']);
    // //Access update schedule page by calling the func in controller for committee
    Route::post('/update-schedule-page/{id}', [roster_controller::class, 'update']);
    //Access edit schedule  page by calling the func in controller for committee
    Route::get('/edit_schedule_page', [roster_controller::class, 'indexcommittee']);
    //Access add schedule for both admin and committee by calling the func in controller
    Route::get('/add_schedule', [roster_controller::class, 'create']);
    //Access store for both admin and committee by calling the func in controller
    Route::post('/roster/store', [roster_controller::class, 'store'])->name('roster/store');
    //Access filter for both admin and committee by calling the func in controller
    Route::get('/roster/filter', [roster_controller::class, 'filter'])->name('roster.filter');
    //Access delete for both admin and committee by calling the func in controller
    Route::delete('/roster-delete/{id}', [roster_controller::class, 'delete'])->name('delete');
});

 Route::group(['middleware' => ['user.authorized:Secretary,Coordinator,Treasurer']], function () {
//secretary,coordinator,
    // Define routes here
    Route::get('/inventory', [InventoryController::class, 'Index']);
    //Access inventory in view and call index func in controller 
    Route::get('/search_inventory', [InventoryController::class, 'search']);
    
    
    //Schedule
    //redirect to roster committee page
    Route::get('/rosterCommittee', [roster_controller::class, 'showlistcommittee']);
    // //Access update schedule page by calling the func in controller for committee
    Route::post('/update-schedule-page/{id}', [roster_controller::class, 'update']);
    //Access edit schedule  page by calling the func in controller for committee
    Route::get('/edit_schedule_page', [roster_controller::class, 'indexcommittee']);
    //Access add schedule for both admin and committee by calling the func in controller
    Route::get('/add_schedule', [roster_controller::class, 'create']);
    Route::post('/roster/store', [roster_controller::class, 'store'])->name('roster/store');
    Route::get('/roster/filter', [roster_controller::class, 'filter'])->name('roster.filter');
    Route::delete('/roster-delete/{id}', [roster_controller::class, 'delete'])->name('delete');

    //Report
    //Access report in view and call index func in controller 
    Route::get('/reports', [ReportController::class, 'reports']);
    //Access report in view and call func in controller 
    Route::get('/searchReport', [ReportController::class, 'searchReport']);
    //get report select time period request
    Route::post('/reports', [ReportController::class, 'reports'])->name('reports.reports');
});



