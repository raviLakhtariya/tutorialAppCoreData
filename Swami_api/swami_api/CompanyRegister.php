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
            array('company_name','company_password','company_email' ),$req)) {
            
            $company_name  = $req['company_name'];
            $company_password = $req['company_password'];
            $company_email = $req['company_email'];
            
            $db = new DbOperation();
     
            $result = $db->createCompany($company_name, $company_password, $company_email );
     
            if ($result == USER_CREATED) {
                $response['error'] = false;
                $response['message'] = 'Company Register successfully';
            } elseif ($result == USER_ALREADY_EXIST) {
                $response['error'] = true;
                $response['message'] = 'Company already exist';
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
