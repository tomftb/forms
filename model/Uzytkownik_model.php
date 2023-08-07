<?php

class Uzytkownik_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getUserWithAccountType(array $input=[':login'=>['','STR']]){
        return $this->Main->squery("SELECT `u`.`id`,`u`.`imie`,`u`.`nazwisko`,`u`.`email`,`u`.`wsk_u`,`a`.`code`,`u`.`haslo`,`u`.`id_rola` FROM `uzytkownik` as `u`, `app_account_type` as `a` WHERE `u`.`typ`=`a`.`id` AND `u`.`login`=:login",$input);
    }
    public function getUserRolePerm(array $input=[':id_rola'=>[0,'INT']]){
        return $this->Main->squery("SELECT `SKROT` FROM v_upr_i_slo_rola_v2 WHERE `idRola`=:id_rola",$input);
    }
    public function getUserPerm(array $input=[':id'=>array(0,'INT')]){
        return $this->Main->squery("SELECT `SKROT` FROM `v_uzyt_i_upr_v2` WHERE `idUzytkownik`=:id",$input);
    }
}
