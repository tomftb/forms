<?php
/*
	RENAME TO config.php
*/
define('dbParm',array
            (
                'host'=>'127.0.0.1',
                'db'=>'db_name',
                'port'=>3306,
                'user'=>'db_username',
                'pass'=>'db_password',
                'logLvl'=>0,
                'cipher'=>'y => base64 or n'
            ));
define('ldapParm',array
            (
                'host'=>'host',
                'filter'=>'filter',
                'tree'=>'tree',
                'port'=>389,
                'user'=>'ldap_user',
                'password'=>'ldap_password'
            ));
define('email',[
    'SMTPAuth'=>true,/* true/false */
    'SMTPSecure' => 'tls',
    'isSMTP'=>true, /* true/false */
    'Host'=>"",
    'Port'=>587,
    'Username'=>"",
    'Password'=>"",
    'From'=>["powiadomienia", ''],
    'exception'=>true,
    'CharSet'=>'UTF-8',
    'sendAttempts'=>5,
    'sendAttemptsTimeout'=>5
    ,'SMTPKeepAlive'=>true
    ,'Timeout' => 10
    ,'isHTML'=>false
     ,'sendAttempts'=>5
    ,'sendAttemptsTimeout'=>2
]);
//5DPbvuNiRbyoUBTN
