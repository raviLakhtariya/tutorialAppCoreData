<?php
 
require_once 'DbOperation.php';

header ( "Access-Control-Allow-Origin: *" );
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

$json = file_get_contents('php://input');
$req = json_decode( $json, true);
 
$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
 
    if (isset($req['company_email']) && isset($req['company_password'])) {
 
        $db = new DbOperation();
 
        if ($db->companyLogin($req['company_email'], $req['company_password'])) {
            $response['error'] = false;
            $response['message'] = 'Sucessfully login';

        $response['user'] = $db->getCompanyByCompanyid($req['company_email']);
        }
        else {
            $response['error'] = true;
            $response['message'] = 'Invalid email or password';
        } 
    } 
    else {
        $response['error'] = true;
        $response['message'] = 'Parameters are missing';
    }
} 
else {
    $response['error'] = true;
    $response['message'] = "Request not allowed";
}
 
echo json_encode($response);
?>
