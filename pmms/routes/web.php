<?php

use App\Http\Controllers\InventoryController;
use App\Models\Inventory;
use Illuminate\Support\Facades\Route;

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
    return view('welcome');
});

// Route::get('/inventory', function () {
//     return view('inventory');
// });

Route::get('/schedule', function () {
    return view('schedule');
});

Route::get('/payment', function () {
    return view('payment');
});

//INVENTORY
//Access inventory in view and call index func in controller 
Route::get('/inventory', [InventoryController::class, 'Index']);

//Access inventory in view and call index func in controller 
Route::get('/search', [InventoryController::class, 'search'])->name('search');

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