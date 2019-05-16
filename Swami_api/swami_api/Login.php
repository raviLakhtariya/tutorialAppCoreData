<?php
 
require_once 'DbOperation.php';

header ( "Access-Control-Allow-Origin: *" );
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

$json = file_get_contents('php://input');
$req = json_decode( $json, true);
 
$response = array();

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
 
    if (isset($req['email']) && isset($req['password'])) {
 
        $db = new DbOperation();
 
        if ($db->userLogin($req['email'], $req['password'])) {
            $response['error'] = false;
            $response['message'] = 'Sucessfully login';

        $response['user'] = $db->getUserByUsername($req['email']);
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
