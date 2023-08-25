<?php

class Slo_rola_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getList():array{
        return $this->Main->squery("SELECT `ID`,`SKROT`,`NAZWA`,`OPIS` FROM `slo_rola`;");
    }
    public function getShortList():array{
        return $this->Main->squery("SELECT `ID`,`NAZWA` FROM `slo_rola`;");
    }
    public function getNotDeletedShortList():array{
        return $this->Main->squery('SELECT `ID`,`NAZWA` FROM `slo_rola` WHERE `WSK_U`=\'0\' ORDER BY `ID` ASC ');
    }
    public function getRolePermissions(string|int $id_rola=0):array{
        return $this->Main->squery("SELECT `u`.`SKROT` FROM `upr_i_slo_rola` as `ur`, `uprawnienia` as `u` WHERE `ur`.`id_upr`=`u`.`id` AND `ur`.`id_rola`=:id_rola",[':id_rola'=>[$id_rola,'INT']],'FETCH_ASSOC','fetchAll');
    }
   // public function getUserUniqueRolePermissions(string|int $id_rola=0):array{
        
  //  }
}