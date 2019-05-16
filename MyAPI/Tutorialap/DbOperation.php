<?php
 
/**
 * Created by PhpStorm.
 * User: Belal
 * Date: 04/02/17
 * Time: 7:51 PM
 */
class DbOperation
{
    private $conn;
 
    //Constructor
    function __construct()
    {
        require_once   'Constants.php';
        require_once   'DbConnect.php';
        // opening db connection
        $db = new DbConnect();
        $this->conn = $db->connect();
    }

     public function userLogin($emailid, $password)
   {
       
     //  $password = md5($pass);
       $stmt = $this->conn->prepare("SELECT companyid FROM CompanyReg1 WHERE emailid = ? AND password = ?");
       $stmt->bind_param("ss", $emailid, $password);
       $stmt->execute();
       $stmt->store_result();
       return $stmt->num_rows > 0;
   }

   /*
    * After the successful login we will call this method
    * this method will return the user data in an array
    * */

   public function getUserByUsername($emailid)
   {
       $stmt = $this->conn->prepare("SELECT companyid, companyname, emailid, companymobile FROM CompanyReg1 WHERE emailid = ?");
       $stmt->bind_param("s", $emailid);
       $stmt->execute();
       $stmt->bind_result($companyid, $companyname, $emailid, $companymobile);
       $stmt->fetch();
       $user = array();
       $user['companyid'] = $companyid;
       $user['companyname'] = $companyname;
       $user['emailid'] = $emailid;
       $user['companymobile'] = $companymobile;
       return $user;
   }
 
    //Function to create a new user
    public function createUser($companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile, $emailid, $password, $companylink, $companypost, $companyapply, $applyerqualify, $companyabout, $showpost)
    {
        if (!$this->isUserExist($companyname, $emailid,$companymobile)) {
          //  $password = md5($pass);
            $stmt = $this->conn->prepare("INSERT INTO CompanyReg1 ( companyname, companyaddress, companycity, companystate, companycountry, companymobile, emailid, password, companylink, companypost, companyapply, applyerqualify, companyabout, showpost) VALUES (?, ?, ?, ?, ?,?,?,?,?,?,?,?,?,?,)");
            $stmt->bind_param("ssssssssssssss",$companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile, $emailid, $password, $companylink,  $companypost, $companyapply, $applyerqualify, $companyabout, $showpost);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }
 
 
    private function isUserExist($companyname, $emailid,$companymobile)
    {
        $stmt = $this->conn->prepare("SELECT * FROM CompanyReg1 WHERE companyname = ? OR emailid = ? OR companymobile = ?");
        $stmt->bind_param("sss", $companyname, $emailid,$companymobile);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
    public function getAllTeams(){
        $stmt = $this->conn->prepare("SELECT * FROM CompanyReg1");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
    }
    


       public function selectuser($emailid)
   {
       
     //  $password = md5($pass);
       $stmt = $this->conn->prepare("SELECT companyid FROM CompanyReg1 WHERE emailid = ?");
       $stmt->bind_param("s", $emailid);
       $stmt->execute();
       $stmt->store_result();
       return $stmt->num_rows > 0;
   }

   /*
    * After the successful login we will call this method
    * this method will return the user data in an array
    * */

   public function getUserByUserid($emailid)
   {
       $stmt = $this->conn->prepare("SELECT companyid,companyname, companyaddress, companycity, companystate, companycountry, companymobile, emailid, password, companylink, companypost, companyapply, applyerqualify, companyabout, showpost FROM CompanyReg1 WHERE emailid = ?");
       $stmt->bind_param("s", $emailid);
       $stmt->execute();
       $stmt->bind_result($companyid,$companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile,  $emailid, $password, $companylink, $companypost, $companyapply, $applyerqualify, $companyabout, $showpost);
       $stmt->fetch();
       $user = array();
       $user['companyid'] = $companyid;
       $user['companyname'] = $companyname;
       $user['companyaddress'] = $companyaddress;
       $user['companycity'] = $companycity;
       $user['companystate'] = $companystate;
        $user['companycountry'] = $companycountry;
         $user['companymobile'] = $companymobile;
         $user['emailid'] = $emailid;
         $user['password'] = $password;
         $user['companylink'] = $companylink;
         $user['companypost'] = $companypost;
         $user['companyapply'] = $companyapply;
         $user['applyerqualify'] = $applyerqualify;
         $user['companyabout'] = $companyabout;
         $user['showpost'] = $showpost;



       return $user;
   }
 
    //Function to create a new user
    public function updateUser($companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile, $emailid, $password, $companylink, $companypost, $companyapply, $applyerqualify, $companyabout, $showpost,$companyid)
    {
       
            $stmt = $this->conn->prepare("UPDATE CompanyReg1 SET companyname=?, companyaddress=?, companycity=?, companystate=?, companycountry=?, companymobile=?, emailid=?, password=?, companylink=?,  companypost=?, companyapply=?, applyerqualify=?, companyabout=?, showpost=? WHERE companyid = ?");



            $stmt->bind_param("sssssssssssssss",$companyname, $companyaddress, $companycity, $companystate, $companycountry, $companymobile, $emailid, $password, $companylink, $companypost, $companyapply, $applyerqualify, $companyabout, $showpost, $companyid);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
      
    }


}
?>
