<?php

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
    
 
    public function userLogin($email, $password)
    {       
       $en_password = md5($password);
       $stmt = $this->conn->prepare("SELECT id FROM tbl_user WHERE email = ? AND password = ?");
       $stmt->bind_param("ss", $email, $en_password);
       $stmt->execute();
       $stmt->store_result();
       return $stmt->num_rows > 0;
    }

    public function getUserByUsername($email)
    {
       $stmt = $this->conn->prepare("SELECT id, user_name, email, mobile_no, gender FROM tbl_user WHERE email = ?");
       $stmt->bind_param("s", $email);
       $stmt->execute();
       $stmt->bind_result($id, $user_name, $email, $mobile_no, $gender);
       $stmt->fetch();
       $user = array();
       echo $_SESSION['user_id'] = $id;
       $user['id'] = $id;
       $user['user_name'] = $user_name;
       $user['email'] = $email;
       $user['mobile_no'] = $mobile_no;
       $user['gender'] = $gender;
       return $user;
    }
 
    //Function to create a new user
    
    public function createUser($user_name, $password, $email, $mobile_no, $gender)
    {
        if (!$this->isUserExist($user_name, $email, $mobile_no)) {
            $enc_password = md5($password);
            $stmt = $this->conn->prepare("INSERT INTO tbl_user ( user_name, email, password, mobile_no, gender) VALUES      (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss", $user_name, $email, $enc_password, $mobile_no, $gender);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
        } else {
            return USER_ALREADY_EXIST;
        }
    }
 
 
    private function isUserExist($user_name, $email, $mobile_no)
    {
        $stmt = $this->conn->prepare("SELECT * FROM tbl_user WHERE user_name = ? OR email = ? OR mobile_no = ?");
        $stmt->bind_param("sss", $user_name, $email, $mobile_no);
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
    
    // --------------------------- Post ------------------------------------
        
    public function createPost($user_id, $post_name, $post_description )
    {
        if (!$this->isPostExist($user_id, $post_name )) {

            $stmt = $this->conn->prepare("INSERT INTO tbl_user_post ( user_id, post_name, post_description ) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $user_id, $post_name, $post_description );
            if ($stmt->execute()) {
                return POST_CREATED;
            } else {
                return POST_NOT_CREATED;
            }
        } else {
            return POST_ALREADY_EXIST;
        }
    }
    
    private function isPostExist($user_id, $post_name )
    {
        $stmt = $this->conn->prepare("SELECT * FROM tbl_user_post WHERE user_id = ? AND post_name = ? ");
        $stmt->bind_param("is", $user_id, $post_name );
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
    
    // --------------------------- Company ------------------------------------
   
    public function companyLogin($company_email, $company_password)
    {       
       $en_password = md5($company_password);
       $stmt = $this->conn->prepare("SELECT id FROM tbl_company WHERE company_email = ? AND company_password = ?");
       $stmt->bind_param("ss", $company_email, $en_password);
       $stmt->execute();
       $stmt->store_result();
       return $stmt->num_rows > 0;
    }
    
    public function createCompany( $company_name, $company_password, $company_email )
    {
        if (!$this->isCompanyExist($company_name, $company_email )) {
            $enc_password = md5($company_password);
            $stmt = $this->conn->prepare("INSERT INTO tbl_company ( company_name, company_password, company_email ) VALUES (?, ?, ?)");
            $stmt->bind_param("sss", $company_name, $enc_password, $company_email );
            if ($stmt->execute()) {
                return COMPANY_CREATED;
            } else {
                return COMPANY_NOT_CREATED;
            }
        } else {
            return COMPANY_ALREADY_EXIST;
        }
    }
    
    private function isCompanyExist($company_name, $company_email )
    {
        $stmt = $this->conn->prepare("SELECT * FROM tbl_company WHERE company_name = ? AND company_email = ? ");
        $stmt->bind_param("ss", $company_name, $company_email );
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
    
    public function createCompanyPost($company_id, $company_post, $post_description )
    {
        if (!$this->isCompanyPostExist($company_id, $company_post )) {

            $stmt = $this->conn->prepare("INSERT INTO tbl_company_post ( company_id, post_name, post_description ) VALUES (?, ?, ?)");
            $stmt->bind_param("iss", $company_id, $company_post, $post_description );
            if ($stmt->execute()) {
                return COMPANY_CREATED;
            } else {
                return COMPANY_NOT_CREATED;
            }
        } else {
            return COMPANY_ALREADY_EXIST;
        }
    }
    
    private function isCompanyPostExist($company_id, $post_name )
    {
        $stmt = $this->conn->prepare("SELECT * FROM tbl_company_post WHERE company_id = ? AND post_name = ? ");
        $stmt->bind_param("is", $company_id, $post_name );
        $stmt->execute();
        $stmt->store_result();
        return $stmt->num_rows > 0;
    }
    
    public function getCompanyByCompanyid($company_email)
    {
       $stmt = $this->conn->prepare("SELECT id, company_name, company_email FROM tbl_company WHERE company_email = ?");
       $stmt->bind_param("s", $company_email);
       $stmt->execute();
       $stmt->bind_result($company_id, $company_name, $company_email );
       $stmt->fetch();
       $user = array();
       $user['company_id'] = $company_id;
       $user['company_name'] = $company_name;
       $user['company_email'] = $company_email;
       
       return $user;
    }
   
    // --------------------- Get All Post --------------------------------------
    
    public function getAllPost(){
        $stmt = $this->conn->prepare("SELECT u.post_name, u.post_description, c.post_name, c.post_description FROM 
            tbl_user_post u, tbl_company_post c ");
        $stmt->execute();
        $fields = $this->bindAll($stmt);
        $result = $this->fetchRowAssoc($stmt, $fields);
        return $result;
    }
        
    public function getAllTeams(){
        $stmt = $this->conn->prepare("SELECT * FROM UserReg /*WHERE emailid = ? AND password = ?*/");
        $stmt->execute();
        $result = $stmt->get_result();
        return $result;
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
  
            $stmt = $this->conn->prepare("UPDATE UserReg SET firstname = ?,lastname=?,password=?,emailid=?,mobileno=? WHERE userid = ?");
            $stmt->bind_param("ssssss",$firstname,$lastname,$password,$emailid,$mobileno,$userid);
            if ($stmt->execute()) {
                return USER_CREATED;
            } else {
                return USER_NOT_CREATED;
            }
      
    }
    
    function bindAll($stmt) {
        $meta = $stmt->result_metadata();
        $fields = array();
        $fieldRefs = array();
        while ($field = $meta->fetch_field())
        {
            $fields[$field->name] = "";
            $fieldRefs[] = &$fields[$field->name];
        }

        call_user_func_array(array($stmt, 'bind_result'), $fieldRefs);
        $stmt->store_result();
        //var_dump($fields);
        return $fields;
    }

    function fetchRowAssoc($stmt, &$fields) {
        if ($stmt->fetch()) {
            return $fields;
        }
        return false;
    }

}
?>
