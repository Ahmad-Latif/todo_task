<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;

class AuthController extends Controller
{

    // Login function
    public function login(Request $request)
    {
        if (Auth::attempt(['email' => $request->email, 'password' => $request->password])) {
            $user = Auth::user();
            if($user->plan_end_at <= Carbon::now())
            {
                $response = [
                    'response_code' => 200,
                    'response_message' => "User's plan end. Please subscribe again ",
                    'data'    => (object) [],
                ];
                return response()->json($response, 200);
            }
            $data['accessToken'] =  $user->createToken('authToken')->accessToken;
            $data['role'] = $user->user_type_id;
            $response = [
                'response_code' => 200,
                'response_message' => "User Access Token",
                'data'    => $data,
            ];
            return response()->json($response, 200);
        } else {
            $response = [
                'response_code' => 401,
                'error_message' => 'Unauthorised',
            ];
            return response()->json($response, 401);
        }
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        /*    $request->validate([
            'first_name' => ['required', 'string', 'max:255'],
            'last_name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
        ]);*/

        try {
            $user = new User();
            $user->name = $request->first_name . " " . $request->last_name;
            $user->email = $request->email;
            $user->password = Hash::make($request->password);
            $user->user_type_id = 2;
            $user->plan_id = 1;
            $user->plan_end_at =Carbon::now()->addMonth();
            $user->save();

            $userDetails = new UserDetail();
            $userDetails->first_name = $request->first_name;
            $userDetails->last_name = $request->last_name;
            $userDetails->address1 = $request->address1;
            $userDetails->address2 = $request->address2;
            $userDetails->city = $request->city;
            $userDetails->postal_code = $request->postal_code;
            $userDetails->country = $request->country;
            $userDetails->telephone = $request->telephone;
            $userDetails->mobile = $request->mobile;
            $userDetails->date_of_birth = $request->date_of_birth;
            $userDetails->user_id = $user->id;
            $userDetails->save();

            $accessToken = $user->createToken('authToken')->accessToken;

            $data['user'] = $user;
            $data['accessToken'] = $accessToken;
            $data['userDetails'] = $userDetails;
            $data['userPlan'] = Plan::findOrFail($user->plan_id);

            $response = [
                'response_code' => 200,
                'response_message' => "User Created",
                'data'    => $data,
            ];
            return response()->json($response, 200);
        } catch (\Exception $e) {
            $response = [
                'response_code' => 500,
                'error_message' => $e->getMessage(),
            ];
            return response()->json($response, 500);
        }

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function logout()
    {

        if (Auth::check()) {
            Auth::user()->token()->revoke();
            $response = [
                'response_code' => 200,
                'response_message' => 'User is logout',
                'data'    => null,
            ];
            return response()->json($response, 200);
        } else {
            $response = [
                'response_code' => 401,
                'response_message' => 'Unauthorised',
                'data'    => null,
            ];
            return response()->json($response, 401);
        }
    }

}
