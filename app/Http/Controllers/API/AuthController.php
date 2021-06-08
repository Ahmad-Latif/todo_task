<?php

namespace App\Http\Controllers\API;


use App\Http\Controllers\Controller;
use App\Http\Resources\UserResource;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Mail;
use DB;


class AuthController extends Controller
{


    public function login(Request $request)
    {

        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);
        $credentials = request(['email', 'password']);
        if (!Auth::attempt($credentials)) {
            return response()->json([
                'error' => true,
                'message' => 'Oops! Invalid email or password.',
            ], 401);
        }
        $user = $request->user();
        $tokenResult = $user->createToken('Personal Access Token');
        $token = $tokenResult->token;
        if ($request->remember_me) {
            $token->expires_at = Carbon::now()->addWeeks(1);
        }
        $token->save();

        return response()->json([
            'error' => false,
            'message' => 'You are logged in successfully.',
            'access_token' => $tokenResult->accessToken,
            'token_type' => 'Bearer',
            'expires_at' => Carbon::parse(
                $tokenResult->token->expires_at
            )->toDateTimeString(),
            'user' => new UserResource($request->user()),
        ]);
    }

    public function logout(Request $request)
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

    public function user(Request $request)
    {
        return response()->json([
            'error' => false,
            'message' => 'Authenticated user.',
            'data' => new UserResource($request->user()),
        ]);
    }

    public function store(Request $request)
    {
        $request->validate([
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'name' => ['required', 'string'],
            'password' => ['required', 'string', 'min:8'],
        ]);

        try {
            $user = new User();
            $user->email = $request->email;
            $user->password = Hash::make($request->password);
            $user->name = $request->name;
            $user->save();
            // $user->save()->sendEmailVerificationNotification();

            // $request->session()->put('user_email', $user->email);

            $email = $request->email;

            $expFormat = mktime(date("H") + 1, date("i") , date("s") , date("m") , date("d") , date("Y"));
            $expDate   = date("Y-m-d H:i:s", $expFormat);
            $key       = md5(2418 * 2);
            $key       = $key . encrypt($email);
            $addKey    = substr(md5(uniqid(rand() , 1)) , 3, 10);
            $key       = $key . $addKey;
            $link      = url('/verify/') . '?key=' . $key;

            DB::table('confirmation_temp')->insert(array(
                'email'    => $email,
                'resetKey' => $key,
                'expDate'  => $expDate
            ));

            $dataArr = array(
                'link' => $link,
            );

            Mail::send('emails.confirmation', $dataArr, function ($message) use ($email)
            {
                $message->to($email)->subject('Confirm Your Email Account');
            });

            $accessToken = $user->createToken('authToken')->accessToken;

            $data['user'] = $user;
            $data['accessToken'] = $accessToken;

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

    public function resendLink(Request $request){

        $request->validate([
            'email' => 'required|string|email',
        ]);

        try {
            $email = $request->email;
            $userDetails = User::where('email', $email)->first();
            
            if(empty($userDetails)){
                 $response = [
                    'response_code' => 200,
                    'response_message' => "User Does not exist.",
                    'data'    => [],
                ];
                return response()->json($response, 200);
            }
            
            if ($userDetails->isActive == 1)
            {
                $response = [
                    'response_code' => 200,
                    'response_message' => "Already Verified.",
                    'data'    => [],
                ];
                return response()->json($response, 200);
            }
                      
            $expFormat = mktime(date("H") + 1, date("i") , date("s") , date("m") , date("d") , date("Y"));
            $expDate = date("Y-m-d H:i:s", $expFormat);
            $key = md5(2418 * 2);
            $key = $key . encrypt($email);
            $addKey = substr(md5(uniqid(rand() , 1)) , 3, 10);
            $key  = $key . $addKey;
            $link = url('/verify/') . '?key=' . $key;

            DB::table('confirmation_temp')->where('email', $email)->delete();
            DB::table('confirmation_temp')->insert(array(
                'email' => $email,
                'resetKey' => $key,
                'expDate' => $expDate
            ));

            $dataArr = array(
                'link' => $link,
            );
            Mail::send('emails.confirmation', $dataArr, function ($message) use ($email)
            {
                $message->to($email)->subject('Confirm Your Email Account');
            });

            $response = [
                'response_code' => 200,
                'response_message' => "Confirmation Email Sent",
                'data'    => [],
            ];
            return response()->json($response, 200);
        }catch (\Exception $e) {
            $response = [
                'response_code' => 500,
                'error_message' => $e->getMessage(),
            ];
            return response()->json($response, 500);
        }
    }

    //Verifies The User Account
    public function verifyAccount(Request $request){

        $request->validate([
            'key' => 'required|string',
        ]);

        try {
            $key = $request->key;
            $data = DB::table('confirmation_temp')->select('*')->where('resetKey', $key)->first();

            if(!empty($data)){
                $curDate = date("Y-m-d H:i:s");

                $expDate = $data->expDate;
                if ($expDate >= $curDate)
                {
                    $email = $data->email;
                    $userDetails = User::where('email', $email)->first();
                    if ($userDetails->isActive == 1)
                    {
                        $response = [
                            'response_code' => 200,
                            'response_message' => "Already Verified.",
                            'data'    => [],
                        ];
                        return response()->json($response, 200);
                    }
                    else
                    {
                        User::where('email', $email)->update(['isActive' => 1]);
                        $response = [
                            'response_code' => 200,
                            'response_message' => "Account Verified.",
                            'data'    => [],
                        ];
                        return response()->json($response, 200);
                    }
                }
            }
            else{
                $response = [
                    'response_code' => 500,
                    'error_message' => 'Invalid Link',
                ];
                return response()->json($response, 500);
            }            
        }catch (\Exception $e) {
            $response = [
                'response_code' => 500,
                'error_message' => $e->getMessage(),
            ];
            return response()->json($response, 500);
        }
    }

    public function verify($user_id, Request $request) {
        if (!$request->hasValidSignature()) {
            return response()->json(["msg" => "Invalid/Expired url provided."], 401);
        }

        $user = User::findOrFail($user_id);

        if (!$user->hasVerifiedEmail()) {
            $user->markEmailAsVerified();
        }

        return redirect()->to('/');
    }

    public function resend() {
        return Auth::user();
        if (Auth::check()) {
            if (Auth::user()->hasVerifiedEmail()) {
                return response()->json(["msg" => "Email already verified."], 400);
            }
        }

        Auth::user()->sendEmailVerificationNotification();

        return response()->json(["msg" => "Email verification link sent on your email id"]);
    }
}
