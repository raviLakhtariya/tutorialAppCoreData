<?php
/**
 * Created by PhpStorm.
 * User: Belal
 * Date: 04/02/17
 * Time: 7:51 PM
 */
 
//importing required script
require_once 'DbOperation.php';
 
$response = array();
 
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (!verifyRequiredParams(array('companyname', 'companyaddress', 'companycity', 'companystate', 'companycountry', 'companymobile', 'emailid', 'password', 'companylink', 'companypost', 'companyapply', 'applyerqualify', 'companyabout', 'showpost','companyid'))) {
      $companyname = $_POST['companyname'];
        $companyaddress = $_POST['companyaddress'];
        $companycity = $_POST['companycity'];
        $companystate = $_POST['companystate'];
        $companycountry = $_POST['companycountry'];
 $companymobile = $_POST['companymobile'];
 $emailid = $_POST['emailid'];
 $password = $_POST['password'];
 $companylink = $_POST['companylink'];

 $companypost = $_POST['companypost'];

 $companyapply = $_POST['companyapply'];
 $applyerqualify = $_POST['applyerqualify'];
 $companyabout = $_POST['companyabout'];
$showpost= $_POST['showpost'];
$companyid = $_POST['companyid'];
        //creating db operation object
        $db = new DbOperation();
 
        //adding user to database
        $result = $db->updateuser($companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile, $emailid, $password, $companylink, $companypost, $companyapply, $applyerqualify, $companyabout, $showpost,$companyid);
 
        //making the response accordingly
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
 
//function to validate the required parameter in request
function verifyRequiredParams($required_fields)
{
 
    //Getting the request parameters
    $request_params = $_REQUEST;
 
    //Looping through all the parameters
    foreach ($required_fields as $field) {
        //if any requred parameter is missing
        if (!isset($request_params[$field]) || strlen(trim($request_params[$field])) <= 0) {
 
            //returning true;
            return true;
        }
    }
    return false;
}
 
echo json_encode($response);
?>
