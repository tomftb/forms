<?php

class Uprawnienia_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getList():array{
        return $this->Main->squery("SELECT `ID`,`SKROT`,`NAZWA`,`OPIS` FROM `uprawnienia` WHERE 1");
    }
    public function getShortList():array{
        return $this->Main->squery("SELECT `ID`,`NAZWA` FROM `uprawnienia` WHERE 1");
    }
    public function getListWithDefault():array{
        return $this->Main->squery("SELECT `ID`,`SKROT`,`NAZWA`,`OPIS`,'n' as `DEFAULT` FROM `uprawnienia` WHERE 1");
    }
    public function getIdList():array{
        return $this->Main->squery("SELECT `ID` FROM `uprawnienia` WHERE 1");
    }
    public function getUserById(string|int $id_user=0):array{
        return $this->Main->squery("SELECT `u`.`SKROT` FROM `uzyt_i_upr` as `uu`, `uprawnienia` as `u` WHERE `uu`.`id_uprawnienie`=`u`.`id` AND `uu`.`id_uzytkownik`=:id_user",[':id_user'=>[$id_user,'INT']]);
    }
    public function getUserPerm(array $input=[':id'=>array(0,'INT')]){
        return $this->Main->squery("SELECT `SKROT` FROM `v_uzyt_i_upr_v2` WHERE `idUzytkownik`=:id",$input);
    }
    public function getUserUniqePerm(string|int $id_uzytkownik=0,string|int $id_rola=0):array{
        return $this->Main->squery("SELECT `u`.`SKROT` FROM `uprawnienia` as `u`, `uzyt_i_upr` as `uu` WHERE `u`.`id`=`uu`.`id_uprawnienie` AND `id_uzytkownik`=:id_uzytkownik AND `u`.`id` NOT IN (SELECT `ur`.`id_upr` FROM `upr_i_slo_rola` as `ur` WHERE `ur`.`id_rola`=:id_rola)",[':id_uzytkownik'=>[$id_uzytkownik,'INT'],':id_rola'=>[$id_rola,'INT']]);
    }
    public function getUserPermissionsList(string|int $id_uzytkownik=0):array{
        return $this->Main->squery("SELECT `id_uprawnienie` as `ID`,'t' as `DEFAULT` FROM `uzyt_i_upr` WHERE `id_uzytkownik`=:id_uzytkownik",[':id_uzytkownik'=>[$id_uzytkownik,'INT']]);
    }
    public function getUserPermissionsListWithDefault(string|int $id_uzytkownik=0):array{
        return $this->Main->squery("SELECT "
                . "`u`.`ID`"
                . ",`u`.`NAZWA`"
                . ", (select CASE WHEN count(`uu`.`id_uprawnienie`)>0 THEN 't' ELSE 'n' END as 'DEF' FROM `uzyt_i_upr` as `uu` where `u`.`id`=`uu`.`id_uprawnienie` AND `uu`.`id_uzytkownik`=:id_uzytkownik) as `DEFAULT` "
                . "FROM "
                . "`uprawnienia` as `u`;"
                ,[':id_uzytkownik'=>[$id_uzytkownik,'INT']]);
    }
    public function removeUserPermission(string|int $id_uzytkownik=0, string|int $id_uprawnienie=0):void{
        $this->Main->query('DELETE FROM `uzyt_i_upr` WHERE `id_uzytkownik`=:id_uzytkownik AND `id_uprawnienie`=:id_uprawnienie',[':id_uzytkownik'=>[$id_uzytkownik,'INT'],':id_uprawnienie'=>[$id_uprawnienie,'INT']]); 
    }
    public function removeUserAllPermission(string|int $id_uzytkownik=0):void{
        $this->Main->query('DELETE FROM `uzyt_i_upr` WHERE `id_uzytkownik`=:id_uzytkownik',['id_uzytkownik'=>[$id_uzytkownik,'INT']]); 
    }
    public function add(string|int $id_uzytkownik=0, string|int $id_uprawnienie=0):void{
        $this->Main->query('INSERT INTO `uzyt_i_upr` (`id_uzytkownik`,`id_uprawnienie`) VALUES (:id_uzytkownik,:id_uprawnienie)',[':id_uzytkownik'=>[$id_uzytkownik,'INT'],':id_uprawnienie'=>[$id_uprawnienie,'INT']]);
    }
}