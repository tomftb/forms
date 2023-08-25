<?php


class Autos_uzytkownik_model extends Database_model {
    private ?int $lastInsertedUserId=0;

    public function __construct(){
        parent::__construct();
    }
    private function getUserParameterSkeleton(object $user){
        return [
            ':id'=>[$user->id,'INT']
            ,':imie'=>[trim($user->name),'STR']
            ,':nazwisko'=>[trim($user->surname),'STR']
            ,':login'=>[trim($user->login),'STR']
            ,':email'=>[trim($user->mail),'STR']
            ,':typ'=>[$user->{'accounttype'},'INT']
            ,':city'=>[$user->city,'STR']
            ,':department'=>[$user->{'department'},'STR']
        ];
    }
    public function insert(object $user){
        (array)$parm=self::getUserParameterSkeleton($user);
        $parm[":id"]=[parent::getNewId('uzytkownik'),'INT'];
        $this->Main->query("INSERT INTO `uzytkownik` (`id`,`imie`,`nazwisko`,`login`,`haslo`,`email`,`typ`,`city`,`department`,".parent::getAlterKey().") VALUES
		(:id,:imie,:nazwisko,:login,:haslo,:email,:typ,:city,:department,".parent::getAlterValue().");",array_merge($parm,parent::getAlterUserParm()));
        $this->lastInsertedUserId=$parm[':id'][0];
    }
    public function update(object $user){      
        (array) $alter_parm=[
            ':mod_host'=>[filter_input(INPUT_ENV,'REMOTE_ADDR',FILTER_VALIDATE_IP),'STR']
            ,':mod_date'=>[parent::getDate(),'STR']
        ];
        $this->Main->query("UPDATE `uzytkownik` SET "
                . "`imie`=:imie"
                . ",`nazwisko`=:nazwisko"
                . ",`login`=:login"
                . ",`email`=:email"
                . ",`typ`=:typ"
                . ",`city`=:city"
                . ",`department`=:department"
                . ",`mod_date`=:mod_date"
                . ",`mod_host`=:mod_host"
                . " WHERE `id`=:id",array_merge(self::getUserParameterSkeleton($user),$alter_parm));
    }
}
