<?php
/**
 * Description of Filled_form_model
 *
 * @author tomborc
 */
class Filled_form_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getAll(){
        return $this->Main->squery("SELECT `id` as `i`, `name` as `n`, `create_date` as `cd`, `mod_date` as `md` FROM `filled_form` WHERE `delete_status`='0'");
    }
    public function getByIdForm(string|int $id_form=0):array{
        return $this->Main->squery("SELECT `id` as `i`, `name` as `n`, `create_date` as `cd`, `mod_date` as `md` FROM `filled_form` WHERE `delete_status`='0' AND `id_form`=:id_form",[':id_form'=>[$id_form,'INT']]);
    }
}