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
        
            array( 'company_id', 'post_name', 'post_description' ), $req )) {
                                                                               
            $company_id = $req['company_id'];                        
            $company_post = $req['post_name'];
            $post_description = $req['post_description'];            
            
            $db = new DbOperation();
     
            $result = $db->createCompanyPost($company_id, $company_post, $post_description);
     
            if ($result == COMPANY_CREATED) {
                $response['error'] = false;
                $response['message'] = 'Company Post created successfully';
            } elseif ($result == COMPANY_ALREADY_EXIST) {
                $response['error'] = true;
                $response['message'] = 'Company Post already exist';
            } elseif ($result == COMPANY_NOT_CREATED) {
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
