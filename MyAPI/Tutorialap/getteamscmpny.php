 <?php

//including the file dboperation
 
require 'DbOperation.php';
//include 'Config.php';
//creating a response array to store data
$response = array();

//creating a key in the response array to insert values
//this key will store an array iteself
$response['Companydetail'] = array();

//creating object of class DbOperation
$db = new DbOperation();

//getting the teams using the function we created
$Companydetail = $db->getAllTeams();
     //looping through all the teams.
while($CompanyReg1= $Companydetail->fetch_assoc())
     {
         //creating a temporary array
$temp = array();
//inserting the team in the temporary array
        
         $temp['companyid'] = $CompanyReg1['companyid']; 
         $temp['companyname'] = $CompanyReg1['companyname'];
         $temp['companyaddress'] = $CompanyReg1['companyaddress'];
         $temp['companycity'] = $CompanyReg1['companycity'];
         $temp['companystate'] = $CompanyReg1['companystate'];
         $temp['companycountry'] = $CompanyReg1['companycountry'];
         $temp['companymobile'] = $CompanyReg1['companymobile'];
         $temp['emailid'] = $CompanyReg1['emailid'];
         $temp['password'] = $CompanyReg1['password'];
         $temp['companylink'] = $CompanyReg1['companylink'];
       
         $temp['companypost'] = $CompanyReg1['companypost'];
         $temp['companyapply'] = $CompanyReg1['companyapply'];
         $temp['applyerqualify'] = $CompanyReg1['applyerqualify'];
         $temp['companyabout'] = $CompanyReg1['companyabout'];
         $temp['showpost'] = $CompanyReg1['showpost'];


//inserting the temporary array inside response
array_push($response['Companydetail'],$temp);
}

//displaying the array in json format
     echo json_encode($response);
?>
