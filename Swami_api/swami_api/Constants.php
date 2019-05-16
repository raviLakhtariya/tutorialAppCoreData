<?php
session_start();

define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'admin');
define('DB_HOST', 'localhost');
define('DB_NAME', 'user_post_demo');
 
define('USER_CREATED', 0);
define('USER_ALREADY_EXIST', 1);
define('USER_NOT_CREATED', 2);

define('POST_CREATED', 0);
define('POST_ALREADY_EXIST', 1);
define('POST_NOT_CREATED', 2);

define('COMPANY_CREATED', 0);
define('COMPANY_ALREADY_EXIST', 1);
define('COMPANY_NOT_CREATED', 2);

?>
