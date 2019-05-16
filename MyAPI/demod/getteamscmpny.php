 <?php

//including the file dboperation
 
require 'DbOperation.php';
//include 'Config.php';
//creating a response array to store data
$response = array();

//creating a key in the response array to insert values
//this key will store an array iteself
$response['userdetail'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$userdetail = $db->getAllTeams();
     //looping through all the teams.
while($UserReg= $userdetail->fetch_assoc()){
         //creating a temporary array
$temp = array();
//inserting the team in the temporary array
        
         
        
           $temp['userid'] = $UserReg['userid'];
             $temp['firstname'] = $UserReg['firstname'];
         $temp['lastname'] = $UserReg['lastname'];
        $temp['emailid'] = $UserReg['emailid'];
         $temp['password'] = $UserReg['password'];
           $temp['mobileno'] = $UserReg['mobileno'];

//inserting the temporary array inside response
array_push($response['userdetail'],$temp);
}

//displaying the array in json format
     echo json_encode($response);
?>
