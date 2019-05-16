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
       $stmt = $this->conn->prepare("SELECT userid FROM UserReg WHERE emailid = ? AND password = ?");
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
       $stmt = $this->conn->prepare("SELECT userid, firstname,lastname,password, emailid, mobileno FROM UserReg WHERE emailid = ?");
       $stmt->bind_param("s", $emailid);
       $stmt->execute();
       $stmt->bind_result($userid, $firstname,$lastname,$password, $emailid, $mobileno);
       $stmt->fetch();
       $user = array();
       $user['userid'] = $userid;
       $user['firstname'] = $firstname;
       $user['lastname'] = $lastname;
       $user['password'] = $password;
       $user['emailid'] = $emailid;
       $user['mobileno'] = $mobileno;
       return $user;
   }
 
    //Function to create a new user
    public function createUser($firstname, $lastname, $password, $emailid, $mobileno)
    {
        if (!$this->isUserExist($firstname, $emailid,$mobileno)) {
          //  $password = md5($pass);
            $stmt = $this->conn->prepare("INSERT INTO UserReg (firstname,lastname,password,emailid,mobileno) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss",$firstname,$lastname,$password,$emailid,$mobileno);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }
    


 public function userselect($emailid)
   {
       
     //  $password = md5($pass);
       $stmt = $this->conn->prepare("SELECT userid FROM UserReg WHERE emailid = ? ");
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
       $stmt = $this->conn->prepare("SELECT userid, firstname,lastname,password, emailid, mobileno FROM UserReg WHERE emailid = ?");
       $stmt->bind_param("s", $emailid);
       $stmt->execute();
       $stmt->bind_result($userid, $firstname,$lastname,$password, $emailid, $mobileno);
       $stmt->fetch();
       $user = array();
       $user['userid'] = $userid;
       $user['firstname'] = $firstname;
       $user['lastname'] = $lastname;
       $user['password'] = $password;
       $user['emailid'] = $emailid;
       $user['mobileno'] = $mobileno;
       return $user;
   }
   public function updateuser($firstname, $lastname, $password, $emailid, $mobileno,$userid)
    {
       // if (!$this->isUserExist($firstname, $emailid,$mobileno)) {
          //  $password = md5($pass);
            $stmt = $this->conn->prepare("UPDATE UserReg SET firstname = ?,lastname=?,password=?,emailid=?,mobileno=? WHERE userid = ?");
            $stmt->bind_param("ssssss",$firstname,$lastname,$password,$emailid,$mobileno,$userid);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        // } else {
        //     return USER_ALREADY_EXIST;
        // }
    }


   
 
 
    private function isUserExist($firstname, $emailid,$mobileno)
    {
        $stmt = $this->conn->prepare("SELECT * FROM UserReg WHERE firstname = ? OR emailid = ? OR mobileno = ?");
        $stmt->bind_param("sss", $firstname, $emailid,$mobileno);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
 public function getAllTeam($userid){
        $stmt = $this->conn->prepare("SELECT * FROM UserReg WHERE userid =".$userid );
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
    }

     public function getAllTeams(){
        $stmt = $this->conn->prepare("SELECT * FROM UserReg /*WHERE emailid = ? AND password = ?*/");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
    }
}
?>
