<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Inventory;
use App\Models\Cart;
use App\Models\Payment;


class PaymentController extends Controller
{
    //Display the cart page
    public function index()
    {
        //Check the user is being authenticated or not
        if (!auth()->user()) {
            return redirect()->route('login');
        }

        //Get the cart data from database
        $carts = Cart::join('inventories', 'carts.inventory_id', '=', 'inventories.id')
            ->select('carts.*', 'inventories.name','inventories.category', 'inventories.price')
            ->where('carts.payment_id', '=',null)
            ->get();
        //Get the total price of the cart
        $carts->each(function ($cart) {
            $cart->total = $cart->price * $cart->quantity;
        });
        //Calculate the total amount of the carts
        $amount = $carts->sum('total');

        return view ('payment.cart', compact('carts','amount'));
    }


    public function addItem(REQUEST $request)
    {
        //Check the item is exist in the cart or not
        $checkItem = Cart::where('inventory_id', '=', $request->item)
            ->where('payment_id', '=', null)
            ->first();
        if ($checkItem) {
            //If the item is exist, update the quantity
            $checkItem->quantity++;
            $checkItem->save();
        } else 
        //Check the item is exist in inventory or not
        $checkInventory = Inventory::where('id', '=', $request->item)->first();
        if ($checkInventory) {
            //If the item is exist in the inventory and not exist in the cart, add the item into cart
            $cart = new Cart();
            $cart->inventory_id = $request->item;
            $cart->quantity = 1;
            $cart->save();
        } 
        
        return redirect()->route('cart');
    }

    //addQuantity
    public function addQuantity($id)
    {
        //Get the cart data from database
        $cart = Cart::find($id);
        //Update the quantity
        $cart->quantity++;
        $cart->save();
        return redirect()->back();
    }

    //minusQuantity
    public function minusQuantity($id)
    {
        //Get the cart data from database
        $cart = Cart::find($id);
        //If Item quantity is 1, delete the item
        if ($cart->quantity == 1) {
            $cart->delete();
            return redirect()->route('cart');
        }
        //Update the quantity
        $cart->quantity--;
        $cart->save();
        return redirect()->back();
    }

    //Destroy the cart
    public function destroy($id)
    {
        //Get the cart data from database
        $cart = Cart::find($id);
        //Delete the cart
        $cart->delete();
        return redirect()->route('cart');
    }

    //Destroy all the cart
    public function destroyAll()
    {
            //Get the cart data from database
            $carts = Cart::where('payment_id', '=', null)->get();
            //Delete the cart
            $carts->each(function ($cart) {
                $cart->delete();
            });
        
        return redirect()->route('cart');
    }

    //Proceed to payment page
    public function proceedPayment(REQUEST $request)
    {
        $amount = $request->amount;
        return view('payment.payment', compact('amount'));
    }

    //Store the payment data into database
    public function storePayment(Request $request)
    {
        $amountPaid = floatval($request->answer);
        //Check the amount paid is more than the total amount of the cart
        if ($request->answer < $request->amount) {
            session()->flash('error', 'The amount paid is not enough!');
        }
        //Get the cart data from database
        $carts = Cart::join('inventories', 'carts.inventory_id', '=', 'inventories.id')
            ->select('carts.*', 'inventories.name','inventories.category', 'inventories.price')
            ->where('carts.payment_id', '=',null)
            ->get();
        //Create the payment
        $payment = new Payment();
        $payment->user_id = auth()->user()->id;
        $payment->totalPrice = $request->amount;
        $payment->method = $request->method;
        $payment->save();
        //Get the refund amount
        $refund = $amountPaid - $payment->totalPrice;
        //Update the cart
        $carts->each(function ($cart) use ($payment) {
            $cart->payment_id = $payment->id;
            $cart->save();
        });  
        $carts->each(function ($cart) {
            $cart->total = $cart->price * $cart->quantity;
        });

        return view('payment.refund',compact('carts','payment','refund'));
    }



}
