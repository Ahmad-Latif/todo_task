<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\TestController;
use Illuminate\Support\Facades\Auth;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//Auth::routes(['verify' => true]);
Route::get('/', function () {
    return 'welcome';
});

Route::post('register', [AuthController::class, 'store']);
Route::post('login', [AuthController::class, 'login']);
Route::post('verify', [AuthController::class, 'verifyAccount']);
Route::post('resendLink', [AuthController::class, 'resendLink']);
Route::put('activate-account', [AuthController::class, 'activate']);
Route::get('email/verify/{id}', [AuthController::class, 'verify'])->name('verification.verify'); // Make sure to keep this as your route name

Route::get('email/resend', [AuthController::class, 'resend'])->name('verification.resend');
//Route::middleware('auth:api')->get('/user', function (Request $request) {
//    return $request->user();
//});
Route::middleware('auth:api')->group( function () {
    Route::get('logout', [AuthController::class, 'logout']);

    Route::post('lists',  [TestController::class, 'listing']);
    Route::post('create',  [TestController::class, 'store']);
    Route::post('update/{id}',[TestController::class, 'update']);
    Route::delete('delete/{id}',[TestController::class, 'delete']);
});
