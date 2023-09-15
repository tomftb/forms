<?php
class App_account_type_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getList():array{
        return $this->Main->squery("SELECT `ID`,`SKROT`,`NAZWA`,`OPIS` FROM `slo_rola`;");
    }
    public function getShortList():array{
        return $this->Main->squery("SELECT `ID`,`NAZWA` FROM `slo_rola`;");
    }
    public function getNotDeletedShortList():array{
        return $this->Main->squery("SELECT a.`id`,a.`name` FROM `app_account_type` a WHERE a.`wsk_u`='0' ORDER BY a.`id`");
    }
    public function getAccountNameById(string|int $id=0):string{ 
        foreach($this->Main->squery("select `name` FROM `app_account_type` WHERE `id`=:id AND `wsk_u`='0'",[':id'=>[$id,'INT']]) as $account){
            return $account['name'];
        }
        Throw new Exception('ACCOUNT TYPE '.$id.' NOT EXIST IN DATABASE',1);
    }
    public function getAccountIdByCode(string|int $code=''):string{ 
        foreach($this->Main->squery("select `id` FROM `app_account_type` WHERE `code`=:code AND `wsk_u`='0'",[':code'=>[$code,'STR']]) as $account){
            return $account['id'];
        }
        Throw new Exception('app_account_type with code `'.$code.'` NOT EXIST IN DATABASE',1);
    }
}