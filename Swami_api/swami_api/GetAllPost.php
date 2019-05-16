<?php
 
require_once 'DbOperation.php';

header ( "Access-Control-Allow-Origin: *" );
header('Access-Control-Allow-Methods: GET, POST, PATCH, PUT, DELETE, OPTIONS');
header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token');

$json = file_get_contents('php://input');
$req = json_decode( $json, true);
 
$response = array();
$db = new DbOperation();
$response = $db->getAllPost();
 
echo json_encode($response);
?>
