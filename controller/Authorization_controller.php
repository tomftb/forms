<?php
class Authorization_controller extends Base_controller{
    private $info="";
    private $getLogout="";
    private $bgColor="";
    private $userName="";
    private $userPassword="";
    private $userData=array();

    private string $throwError='throwMain';
    
    
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->userName=filter_input(INPUT_POST,"username");
        $this->userPassword=filter_input(INPUT_POST,"password");
        $this->Controller->{'Uprawnienia'}=new \Uprawnienia_controller();
    }
    public function __call($m,$a){
        $this->Log->log(0,__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
        self::{$this->throwError}();
    }
    public function checkLoginData(){
        $this->Log->log(0,"[".__METHOD__."]");
        if(self::checkGet()){
            return 0;
        }
        else if(self::checkSession()){
            return 1;
        }
        else if((trim($this->userName)==='') && (trim($this->userPassword)==='')){
            return 0;
        }
        else{
            try {
                $this->Model->{'Uzytkownik'}=new \Uzytkownik_model();
            }
            catch(\Throwable $t){
                $this->Log->log(0,"[".__METHOD__."]".$t->getMessage());
                self::setError('Wystąpił błąd aplikacji! Skontaktuj się z Administratorem!',1);
		return 0;
            }
            catch (\Exception $e){
                $this->Log->log(0,"[".__METHOD__."]".$e->getMessage());
                self::setError('Wystąpił błąd aplikacji! Skontaktuj się z Administratorem!',1);
		return 0;
            }
            try {
                self::setUser();
                self::tryLogin();
                self::setUserPermissions();
                self::authorization();
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
         $this->Log->log(0,"[".__METHOD__."]");
         if(isset($_SESSION["perm"]) && in_array('LOG_INTO_APP',$_SESSION['perm'])){
            return 1;
         }
        return 0;
    }
    private function checkGet(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->getLogout = filter_input(INPUT_GET, 'logout');
        if($this->getLogout==='t'){
            $this->info='Wylogowano.';
            $this->bgColor='bg-success';
            if(!session_unset()){
                $this->Log->log(0,"[".__METHOD__."] session_unset NOT WORK");
                return 0;
            }
            return 1;
        }
        return 0;
    }
    public function getInfoValue(){
        $this->Log->log(0,"[".__METHOD__."]");
        return $this->info;
    }
    public function getBgColorValue(){
        $this->Log->log(0,"[".__METHOD__."]");
        return $this->bgColor;
    }
    private function login_ldap(){
        $this->Log->log(0,"[".__METHOD__."]");
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
    private function login_ldapAutos(){
        $ldap=new \LdapAutosAuth(); 
        $response = $ldap->auth($this->userName,$this->userPassword);
        $response->{'login'}=$this->userName;
        //echo "response<pre>";
        //print_r($response);
        //echo "</pre>";
        /*
         * TURN OFF
         */
        $Ldap_autos_coontroller=new \Ldap_autos_controller();
        $Ldap_autos_coontroller->setUser($response);
        //die(__METHOD__);
        $_SESSION["mail"]=$response->mail;
        $_SESSION["nazwiskoImie"]=$response->surname.' '.$response->name; 
    }
    private function tryLogin(){
        $this->Log->log(0,"[".__METHOD__."] ACCOUNT TYPE => ".$this->userData['code']);
        $this->throwError='throwWrongAccountType';
        self::{'login_'.$this->userData['code']}();
    }
    private function setSessionData(){
        $this->Log->log(0,"[".__METHOD__."]");
        $_SESSION["username"]=$this->userName;
        $_SESSION["userid"]=$this->userData['id'];
        $_SESSION["perm"]=$this->userData['perm'];  
        $_SESSION["uid"]= uniqid();
    }
    private function setUser(){
        $this->Log->log(0,"[".__METHOD__."]");
        $err=function(){
            Throw New \Exception('Nie istnieje użytkownik o podanym loginie.',0);
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
            $this->Log->log(0,"[".__METHOD__."] THERE IS MORE THAN ONE USER WITH LOGIN => ".$userName);
            Throw New \Exception('Brak uprawnienia do zalogowania się.',0);
        };

        (string) $set='oneUser';
        (string) $check='err';
        try{
            foreach($this->Model->{'Uzytkownik'}->getUserWithAccountType([':login'=>[$this->userName,'STR']]) as $userData){
                $this->userData=$userData;
                ${$set}($set,$check,$this->userName);
            }
            $this->Log->logMulti(2,$this->userData,__METHOD__);
	}
	catch (PDOException $e){
            $this->Log->log(0,"[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage());
            Throw New \Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
	}
        ${$check}();
    }
    private function authorization(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Controller->{'Uprawnienia'}->check('LOG_INTO_APP',$this->userData['perm']);
    }
    protected function setUserPermissions(){
        $this->Log->log(0,"[".__METHOD__."]");

        $this->userData['perm'] = $this->Controller->{'Uprawnienia'}->getUserPermissions(intval($this->userData['id'],10),intval($this->userData['id_rola'],10));
    }
    private function setError($error='',$lvl=0){
        $this->Log->log(0,"[".__METHOD__."] ERROR - ".$error);
        $this->Error->setError($error,$lvl);
        $this->info=$this->Error->getError();
        $this->bgColor='bg-danger';
    }
    public function __destruct() {}
    private function throwWrongAccountType(){
        /* WRONG ACCOUNT TYPE => SET ERROR */
        $this->Log->log(0,"[".__METHOD__."] Wrong account type => ".$this->userData['code']);
        Throw New \Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
    }
    private function throwMain(){
        Throw New \Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!');
    }
}