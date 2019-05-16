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
        
            array( 'user_id', 'post_name', 'post_description' ), $req )) {
                                                                               
            $user_id = $req['user_id'];                        
            $post_name = $req['post_name'];
            $post_description = $req['post_description'];            
            
            $db = new DbOperation();
     
            $result = $db->createPost($user_id, $post_name, $post_description);
     
            if ($result == POST_CREATED) {
                $response['error'] = false;
                $response['message'] = 'Post created successfully';
            } elseif ($result == POST_ALREADY_EXIST) {
                $response['error'] = true;
                $response['message'] = 'Post already exist';
            } elseif ($result == POST_NOT_CREATED) {
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
