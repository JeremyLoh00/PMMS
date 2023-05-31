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
                return $next($request);
            } elseif ($role === 'Cashier') {
                return $next($request);
            } elseif (in_array($role, $roles)) {
                return $next($request);
            }
        }
    
        // User is not authorized, handle unauthorized access
        abort(403, 'Unauthorized');
    }
    
}
