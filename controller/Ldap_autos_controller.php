<?php

/**
 * Description of Ldap_autos_controller
 *
 * @author tomborc
 */
class Ldap_autos_controller extends Base_controller{

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,__METHOD__."");
        $this->Model->{'Uzytkownik'}=new \Uzytkownik_model();
        $this->Model->{'Autos_uzytkownik'}=new \Autos_uzytkownik_model();
        $this->Model->{'App_account_type'}=new \App_account_type_model();
    }
    public function setUser(object $user){
        /* GET ID FROM `app_account_type` */
        //private ?int $useraccounttype=1;
        $user->{'accounttype'}=$this->Model->{'App_account_type'}->getAccountIdByCode('ldapAutos');
        self::userExists($user);
    }
    public function userExists($user){
        $user->id=$this->Model->{'Uzytkownik'}->getUserIdByLogin($user->login);
        if($user->id>0){
            /* UPDATE */
            $this->Model->{'Autos_uzytkownik'}->update($user);
        }
        else{
            /* TURN OFF INSERT */
            //$this->Model->{'Autos_uzytkownik'}->insert($user);
            /* INSERT USER AUTOS PERMISSIONS */
            
        }
    }
    private function getAccountTypeId(){
        
    }
}
