<?php
class ValidLogin
{
    private $info="";
    private $getLogout="";
    private $bgColor="";
    private $userName="";
    private $userPassword="";
    private $userData=array();
    private $dbLink;
    private $logLink;
    private $Error;
    private string $throwError='throwMain';
    private ?object $Model;
    
    public function __construct(){
        $this->logLink=Logger::init(__METHOD__);
        $this->Error=New \ErrorHandler();
        $this->logLink->log(0,"[".__METHOD__."]");
        $this->userName=filter_input(INPUT_POST,"username");
        $this->userPassword=filter_input(INPUT_POST,"password");
        $this->Model=new \stdClass();
    }
    public function __call($m,$a){
        $this->logLink->log(0,__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
        self::{$this->throwError}();
    }
    public function checkLoginData(){
        $this->logLink->log(0,"[".__METHOD__."]");
        if(self::checkGet()){
            return 0;
        }
        else if(self::checkSession()){
            return 1;
        }
        //else if(isset($_SESSION["perm"]) && in_array('LOG_INTO_APP',$_SESSION['perm'])){
         //   $this->logLink->log(0,"[".__METHOD__."] SESSION ALREADY INITIALISED");
        //    return 1;
       // }
        else if((trim($this->userName)==='') && (trim($this->userPassword)==='')){
            return 0;
        }
        else{
            try {
                $this->Model->{'Uzytkownik'}=new \Uzytkownik_model();
                self::setUser();
                self::tryLogin();
                self::setUserPerm();
                self::login();
                self::setSessionData();
            } 
            catch (\Throwable $t){ // Executed only in PHP 7, will not match in PHP 5.x     
                self::setError($t->getMessage(),$t->getCode());
		return 0;
            } 
            catch (\Exception $e){ // Executed only in PHP 7, will not match in PHP 5.x     
                self::setError($e->getMessage(),$e->getCode());
		return 0;
            } 
            finally{
            
            }
           
        }
        return 1;
    }
    private function checkSession(){
         $this->logLink->log(0,"[".__METHOD__."]");
         if(isset($_SESSION["perm"]) && in_array('LOG_INTO_APP',$_SESSION['perm'])){
            return 1;
         }
        return 0;
    }
    private function checkGet(){
        $this->logLink->log(0,"[".__METHOD__."]");
        $this->getLogout = filter_input(INPUT_GET, 'logout');
        if($this->getLogout==='t'){
            $this->info='Wylogowano.';
            $this->bgColor='bg-success';
            if(!session_unset()){
                $this->logLink->log(0,"[".__METHOD__."] session_unset NOT WORK");
                return 0;
            }
            return 1;
        }
        return 0;
    }
    public function getInfoValue(){
        $this->logLink->log(0,"[".__METHOD__."]");
        return $this->info;
    }
    public function getBgColorValue(){
        $this->logLink->log(0,"[".__METHOD__."]");
        return $this->bgColor;
    }
    private function login_ldap(){
        $this->logLink->log(0,"[".__METHOD__."]");
        /* GET FROM CONST */
        $ldap=new \LdapAuth(ldapParm['host'],ldapParm['filter'],ldapParm['tree'],ldapParm['port'],ldapParm['user'],ldapParm['password']); 
        $ldap->loginAd($this->userName,$this->userPassword);
        $_SESSION["mail"]=$ldap->getUserAdData('mail',0);
        $_SESSION["nazwiskoImie"]=$ldap->getUserAdData('name',0);      
    }
    private function login_database(){
        if (!password_verify($this->userPassword, $this->userData['haslo'])) {
                Throw New Exception('Niepoprawne hasło.',0);
        }
        $_SESSION["mail"]=$this->userData['email'];
        $_SESSION["nazwiskoImie"]=$this->userData['nazwisko'].' '.$this->userData['imie']; 
    }
    private function tryLogin(){
        echo __METHOD__."<br/>";
        $this->logLink->log(0,"[".__METHOD__."] ACCOUNT TYPE => ".$this->userData['code']);
        $this->throwError='throwWrongAccountType';
        self::{'login_'.$this->userData['code']}();
    }
    private function setSessionData(){
        $this->logLink->log(0,"[".__METHOD__."]");
        $_SESSION["username"]=$this->userName;
        $_SESSION["userid"]=$this->userData['id'];
        $_SESSION["perm"]=$this->userData['perm'];  
        $_SESSION["uid"]= uniqid();
    }
    private function setUser(){
        $this->logLink->log(0,"[".__METHOD__."]");
        $err=function(){
            Throw New Exception('Nie istnieje użytkownik o podanym loginie.',0);
        };
        $ok=function(){};
            
        $oneUser=function(string &$set='oneUser',string &$check='ok',string $userName=''){
            $set='manyUsers';
            $check='ok';
        };
        $manyUsers=function(string &$set='manyUsers',string &$check='ok',string $userName=''){
            /*
             * Istnieje więcej niż jeden użytkownik z podanym loginem
             */
            $set='manyUsers';
            $check='err';
            $this->logLink->log(0,"[".__METHOD__."] THERE IS MORE THAN ONE USER WITH LOGIN => ".$userName);
            Throw New Exception('Brak uprawnienia do zalogowania się.',0);
        };

        (string) $set='oneUser';
        (string) $check='err';
        try{
            foreach($this->Model->{'Uzytkownik'}->getUserWithAccountType([':login'=>[$this->userName,'STR']]) as $userData){
                $this->userData=$userData;
                ${$set}($set,$check,$this->userName);
            }
            $this->logLink->logMulti(2,$this->userData,__METHOD__);
	}
	catch (PDOException $e){
            $this->logLink->log(0,"[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage());
            Throw New Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
	}
        ${$check}();
    }
    private function login(){
        if(!in_array('LOG_INTO_APP',$this->userData['perm'])){
            self::setError('[LOG_INTO_APP] Brak uprawnienia do zalogowania się','');
            return 0;
        }
        $this->logLink->log(0,"[".__METHOD__."] Uprawnienie `LOG_INTO_APP` istnieje, loguje...");
        return 1;
    }
    protected function setUserPerm(){
        $this->logLink->log(0,"[".__METHOD__."]");
        try{
            self::combinePerm($this->Model->{'Uzytkownik'}->getUserRolePerm([':id_rola'=>array(intval($this->userData['id_rola'],10),'INT')]),$this->Model->{'Uzytkownik'}->getUserPerm([':id'=>array(intval($this->userData['id'],10),'INT')]));
        }
	catch (PDOException $e){
            $this->logLink->log(0,"[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage());
            Throw New Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!',1);
	}
    }
    private function combinePerm(array $rolePerm=[],array $userPerm=[]){
        $this->logLink->log(0,"[".__METHOD__."]");
        $this->userData['perm']=array();
        $tmpUserPerm=$userPerm;
        foreach($rolePerm as $v){
            array_push($this->userData['perm'],$v['SKROT']);
            /*
             * UNSET FROM $userPerm
             */
            UNSET($tmpUserPerm[$v['SKROT']]);
        }
        /*
         * LOOP OVER TMP USER PERM
         */
        foreach($tmpUserPerm as $v){
            array_push($this->userData['perm'],$v['SKROT']);
        }
        //echo "perm:<pre>";
        //print_r($this->userData['perm']);
        //echo "</pre>";
        $this->logLink->logMulti(2,$this->userData['perm'],__METHOD__."::COMBINE PERM");
    }
    private function setError($error='',$lvl=0){
        $this->Error->setError($error,$lvl);
        $this->info=$this->Error->getError();
        $this->bgColor='bg-danger';
    }
    public function __destruct() {}
    private function throwWrongAccountType(){
        /* WRONG ACCOUNT TYPE => SET ERROR */
        $this->logLink->log(0,"[".__METHOD__."] Wrong account type => ".$this->userData['code']);
        Throw New \Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
    }
    private function throwMain(){
        Throw New \Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
    }
}