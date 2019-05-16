<?php
/** * Created by PhpStorm.
 * User: Belal
 * Date: 29/05/17
 * Time: 8:39 PM
 */
 
require_once 'DbOperation.php';
 
$response = array();
 
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
 
    if (isset($_POST['emailid']) && isset($_POST['password'])) {
 
        $db = new DbOperation();
 
        if ($db->userLogin($_POST['emailid'], $_POST['password'])) {
            $response['error'] = false;
            $response['message'] = 'Sucessfully login';

        $response['user'] = $db->getUserByUsername($_POST['emailid']);
       }
        else {
            $response['error'] = true;
            $response['message'] = 'Invalid emailid or password';
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
