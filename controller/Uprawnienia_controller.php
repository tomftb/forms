<?php
class Uprawnienia_controller extends \Base_controller{
    
    public function __construct(){
        parent::__construct();
        $this->Model->{'Uzytkownik'}=new \Uzytkownik_model();
    }
    public function __destruct(){
        
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getUserPermissions(int $id_uzytkownik=0,int $id_rola=0):array{
        try{
            return self::getFullPermissions($this->Model->{'Uzytkownik'}->getUserRolePerm([':id_rola'=>[$id_rola,'INT']]),$this->Model->{'Uzytkownik'}->getUserPerm([':id'=>array($id_uzytkownik,'INT')]));
        }
	catch (PDOException $e){
            $this->Log->log(0,"[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage());
            Throw New Exception('[ERROR] Wystąpił krytyczny błąd aplikacji! Skontaktuj się z Administratorem!',1);
	}
    }
    private function getFullPermissions(array $rolePerm=[],array $userPerm=[]){
        $this->Log->log(0,"[".__METHOD__."]");
        $permissions=array();
        $tmpUserPerm=$userPerm;
        foreach($rolePerm as $v){
            array_push($permissions,$v['SKROT']);
            /*
             * UNSET FROM $userPerm
             */
            UNSET($tmpUserPerm[$v['SKROT']]);
        }
        /*
         * LOOP OVER TMP USER PERM
         */
        foreach($tmpUserPerm as $v){
            array_push($permissions,$v['SKROT']);
        }
        $this->Log->logMulti(2,$permissions,);
        return $permissions;
    }
    public function check(string $permission='',array $permissions=[]):void{
        $this->Log->log(0,"[".__METHOD__."] permission - ".$permission);
        if(empty($permissions)){
            $this->Log->log(0,"[".__METHOD__."] Empty permissions array");
            Throw New \Exception('['.$permission.'] Brak uprawnienia',0);
        }
        if(!in_array($permission,$permissions)){
            Throw New \Exception('['.$permission.'] Brak uprawnienia',0);
        }
    }
    public function silentCheck(string $permission='',array $permissions=[]):string{
        $this->Log->log(0,"[".__METHOD__."] permission - ".$permission);
        if(empty($permissions)){
            return 'Empty permissions array!';
        }
        if(!in_array($permission,$permissions)){
            return '[LOG_INTO_APP] Brak uprawnienia';
        }
        return '';
    }
    public function checkSession(string $permission=''):void{
        $this->Log->log(0,"[".__METHOD__."] permission - ".$permission);
        self::inspectSession();
        if(!in_array($permission,$_SESSION["perm"])){
            $this->Log->log(0,"[".__METHOD__."] no permission - ".$permission);
            Throw New \Exception('['.$permission.'] Brak uprawnienia',0);
        }
    }
    private function inspectSession(){
        if(empty($_SESSION)){
            Throw New \Exception('SESSION is empty!',1);
        }
        if(!array_key_exists("perm",$_SESSION)){
            Throw New \Exception('SESSION `perm` key not exists!',1);
        }
        if(!is_array($_SESSION["perm"])){
            Throw New \Exception('SESSION `perm` key not array!',1);
        }
    }
}
