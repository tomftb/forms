<?php
/**
 * Description of Form_model
 *
 * @author tomborc
 */
class Form_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getAll(){
        return $this->Main->squery("SELECT `id` as `i`, `name` as `n`, `create_date` as `cd`, `mod_date` as `md` FROM `form` WHERE `delete_status`='0'");
    }
    public function getById(string|int $id=0):array{
        foreach($this->Main->squery("SELECT `id` as `i`, `name` as `n`, `create_user_login` as `cul`, `create_user_full_name` as `cufn`,`create_date` as `cd`, `mod_date` as `md` FROM `form` WHERE `delete_status`='0' AND `id`=:id",[':id'=>[$id,'INT']]) as $form){
            return $form;
        }
        Throw New Exception ('Formularz o id `'.$id.'` został usunięty.',0); 
    }
}