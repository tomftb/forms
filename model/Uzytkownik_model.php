<?php

class Uzytkownik_model extends Database_model {
    private ?int $lastInsertedUserId=0;

    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getUserWithAccountType(array $input=[':login'=>['','STR']]){
        return $this->Main->squery("SELECT `u`.`id`,`u`.`imie`,`u`.`nazwisko`,`u`.`email`,`u`.`wsk_u`,`a`.`code`,`u`.`haslo`,`u`.`id_rola` FROM `uzytkownik` as `u`, `app_account_type` as `a` WHERE `u`.`typ`=`a`.`id` AND `u`.`login`=:login",$input);
    }
    public function getUserRolePerm(array $input=[':id_rola'=>[0,'INT']]){
        return $this->Main->squery("SELECT `u`.`SKROT` FROM `upr_i_slo_rola` as `ur`, `uprawnienia` as `u` WHERE `ur`.`id_upr`=`u`.`id` AND `ur`.`id_rola`=:id_rola",$input);
    }
    public function getUserPerm(array $input=[':id'=>array(0,'INT')]){
        return $this->Main->squery("SELECT `SKROT` FROM `v_uzyt_i_upr_v2` WHERE `idUzytkownik`=:id",$input);
    }
    public function getUserIdRole(string|int $id=0):int{
        foreach($this->Main->squery("SELECT (CASE WHEN `id_rola` IS NULL THEN 0 ELSE `id_rola` END) as 'id_rola' FROM `uzytkownik` WHERE `wsk_u`='0' AND `id`=:id",[':id'=>[$id,'INT']]) as $role){
            return $role['id_rola'];
        }
        Throw New \Exception ('Użytkownik z id role = '.$id.' nie istnieje!');
    }
    public function add(array $user=[],array $roleParm=[NULL,'NULL']):void{  
        (array)$parm=self::getUserParameterSkeleton($user,$roleParm);
        $parm[":id"]=[self::getNewId('uzytkownik'),'INT'];
        $this->Main->query("INSERT INTO `uzytkownik` (`id`,`imie`,`nazwisko`,`login`,`haslo`,`email`,`typ`,`id_rola`,".parent::getAlterKey().") VALUES
		(:id,:imie,:nazwisko,:login,:haslo,:email,:typ,:id_rola,".parent::getAlterValue().");",array_merge($parm,parent::getAlterUserParm()));
        $this->lastInsertedUserId=$parm[':id'][0];
    }
    public function update(array $user=[],array $roleParm=[NULL,'NULL']){
        (array)$parm=self::getUserParameterSkeleton($user,$roleParm);
        $this->Main->query("UPDATE `uzytkownik` SET "
                . "`imie`=:imie"
                . ",`nazwisko`=:nazwisko"
                . ",`login`=:login"
                . ",`email`=:email"
                . ",`haslo`=:haslo"
                . ",`typ`=:typ"
                . ",`id_rola`=:id_rola"
                . ",".parent::getUpdateSql()
                . " WHERE `id`=:id",array_merge($parm,parent::getAlterUserParm()));
    }
    public function getLastInsertedUserId():int{
        return $this->lastInsertedUserId;
    }
    private function getUserParameterSkeleton(array $user=[],array $roleParm=[NULL,'NULL']){
        return [
            ':id'=>[$user['ID'],'INT'],
            ':imie'=>[trim($user['Imie']),'STR'],
            ':nazwisko'=>[trim($user['Nazwisko']),'STR'],
            ':login'=>[trim($user['Login']),'STR'],
            ':email'=>[trim($user['Email']),'STR'],
            ':haslo'=>[$user['Haslo'],'STR'],
            ':typ'=>[$user['accounttype'],'INT'],
            ':id_rola'=>$roleParm
        ];
    }

    public function checkUserExists(string|int $id_uzytkownik=0,string $login='',string $imie='',string $nazwisko=''):void{
        $parm=[
            ':id'=>array($id_uzytkownik,'INT'),
            ':login'=>array($login,'STR'),
            ':imie'=>array($imie,'STR'),
            ':nazwisko'=>array($nazwisko,'STR')
            ];
        foreach($this->Main->squery("select `id`,`login`,`imie`,`nazwisko` FROM `uzytkownik` WHERE `id`!=:id AND `wsk_u`='0' AND (`login`=:login OR (`nazwisko`=:nazwisko AND `imie`=:imie))",$parm) as $user){
            Throw New \Exception("Istnieje już użytkownik o podanym loginie `".$user['login']."` lub imieniu `".$user['imie']."` i nazwisku `".$user['nazwisko']."`",0);
        }
    }
    public function getUserIdByLogin(string|int $login=0):int{
        foreach($this->Main->squery("select `id` FROM `uzytkownik` WHERE `login`=:login",[':login'=>array($login,'STR')]) as $user){
            return intval($user['id'],10);
        }
        return 0;
    }

}
