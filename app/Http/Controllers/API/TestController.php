<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use App\Models\Test;
use App\Models\User;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TestController extends Controller
{
    public function listing(Request $request)
    {
//        $user = User::find($request->id);
        $data = Test::where("user_id", "=", Auth::user()->id)->
            where('title', 'LIKE', '%'.$request->search.'%')->paginate(10);
        return response()->json([
            'error' => false,
            'message' => 'Lists found.',
            'data' => $data,
            'pages' => $data->lastPage()
        ], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'description' => 'required',
        ]);
        try {
            $test = new Test();
            $test->title = $request->title;
            $test->user_id = Auth::user()->id;
            $test->description = $request->description;
            $test->save();
            $data['list'] = $test;
            $response = [
                'response_code' => 200,
                'response_message' => "New item has been added successfully",
                'data' => $data,
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

    public function update(Request $request)
    {
        $list = Test::find($request->id);
        if (!$list) {
            return response()->json([
                'error' => true,
                'message' => 'List not found.',
            ], 404);
        }

        $request->validate([
            'title' => 'required',
            'description' => 'required',
        ]);
        try {
            $list->title = $request->title;
            $list->description = $request->description;
            $list->save();
            $data['list'] = $list;
            $response = [
                'response_code' => 200,
                'response_message' => "Item has been updated successfully",
                'data' => $data,
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

    public function delete($id)
    {
        $list = Test::find($id);
        if (!$list) {
            return response()->json([
                'error' => true,
                'message' => 'List not found.',
            ], 404);
        }
        $list ->delete();
        return response()->json([
            'error' => false,
            'message' => 'Item has been deleted successfully',
        ], 200);
    }
}
