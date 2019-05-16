<?php

require_once 'DbOperation.php';
 
    $response = array();

    header ( "Access-Control-Allow-Origin: *" );
    header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

    $json = file_get_contents('php://input');
    $req = json_decode( $json, true);

    if ($_SERVER['REQUEST_METHOD']=='POST') {
        
        if (!verifyRequiredParams(
            array('user_name','password','email','mobile_no','gender'),$req)) {
            
            $user_name  = $req['user_name'];
            $password = $req['password'];
            $email = $req['email'];
            $gender = $req['gender'];
            $mobile_no = $req['mobile_no'];
            
            $db = new DbOperation();
     
            $result = $db->createUser($user_name, $password, $email, $mobile_no, $gender);
     
            if ($result == USER_CREATED) {
                $response['error'] = false;
                $response['message'] = 'User created successfully';
            } elseif ($result == USER_ALREADY_EXIST) {
                $response['error'] = true;
                $response['message'] = 'User already exist';
            } elseif ($result == USER_NOT_CREATED) {
                $response['error'] = true;
                $response['message'] = 'Some error occurred';
            }
        } else {
            $response['error'] = true;
            $response['message'] = 'Required parameters are missing';
        }
    } else {
        $response['error'] = true;
        $response['message'] = 'Invalid request';
    }

    function verifyRequiredParams($required_fields,$req)
    {             
        $request_params = $req;   
           
        foreach ($required_fields as $field) {
            
            if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
                               
                return true;
            }
        }
        return false;
    }
 
echo json_encode($response);
