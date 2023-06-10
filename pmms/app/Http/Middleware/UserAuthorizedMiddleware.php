<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class UserAuthorizedMiddleware
{
    public function handle($request, Closure $next, ...$roles)
    {
        if (Auth::check()) {
            $role = Auth::user()->role;

            // Check if the user is authorized based on the role
            if ($role === 'Admin') {
                if ($request->is('cart')) {
                    // Cashier-specific logic for the '/cart' route
                    return $this->showUnauthorizedPopup();
                }
                return $next($request);
            } elseif ($role === 'Cashier') {
                if ($request->is('users','add_inventory','edit_inventory/*','add_stock/*','deduct_stock/*')) {
                    // Cashier-specific logic for the '/users' route
                    return $this->showUnauthorizedPopup();
                }
                return $next($request);
            } elseif (in_array($role, $roles)) {
                if ($request->is('users','add_inventory','edit_inventory/*','add_stock/*','deduct_stock/*')) {
                    // Cashier-specific logic for the '/users' route
                    return $this->showUnauthorizedPopup();
                }
                return $next($request);
            }
        }

        // User is not authorized, handle unauthorized access
        return $this->showUnauthorizedPopup();
    }

    private function showUnauthorizedPopup()
    {
        $popupScript = "
            <script>
                alert('Unauthorized access. You are not allowed to access this page.');
                history.back(); // This will navigate the user back to the previous page.
            </script>
        ";

        return response($popupScript, 403)->header('Content-Type', 'text/html');
    }
}
