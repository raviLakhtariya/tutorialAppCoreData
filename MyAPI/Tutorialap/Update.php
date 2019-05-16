<?php
/** * Created by PhpStorm.
 * User: Belal
 * Date: 29/05/17
 * Time: 8:39 PM
 */
 
require_once 'DbOperation.php';
 
$response = array();
//$responsed = array(); 
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
 
    if (isset($_POST['emailid'])) {
 
        $db = new DbOperation();
 
        if ($db->selectuser($_POST['emailid'])) {
            $response['error'] = false;
            $response['message'] = 'Sucessfully geted data';

        $response['user'] = $db->getUserByUserid($_POST['emailid']);
      //  $responsed['userd'] = $db->getUserByUserid($_POST['userid']);

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
//echo json_encode($responsed);
?>
