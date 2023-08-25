<?php
/**
 * Description of Form_col_model
 *
 * @author tomborc
 */
class Form_col_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
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
    public function getLabelByFormId(string|int $id=0, string $at_main_page='1'):array{
        
        return $this->Main->squery("SELECT "
                . "`fcp`.`id` as `i`"
                . ",`fcp`.`value` as `v`"
                . "FROM "
                . "`form_col_property` as `fcp`"
                . ",`form_col` as `fc`"
                . ",`form_row` as `fr`"
                . ",`form` as `f`"
                . " WHERE "
                . " `fcp`.`id_parent`=`fc`.`id` AND `fc`.`id_parent`=`fr`.`id` AND `fr`.`id_parent`=`f`.`id`"
                . " AND `fcp`.`property`='label'"
                . " AND `f`.`id`=:id"
                . " AND `f`.`delete_status`='0' AND `fr`.`delete_status`='0' AND `fc`.`delete_status`='0' AND `fcp`.`delete_status`='0' AND `fc`.`at_main_page`=:at_main_page ORDER BY `fc`.`order`",[':id'=>[$id,"INT"],':at_main_page'=>[$at_main_page,'STR']]);
    }
    public function getAllLabelByFormId(string|int $id=0):array{
        
        return $this->Main->squery("SELECT "
                . "`fcp`.`id` as `i`"
                . ",`fcp`.`value` as `v`"
                . "FROM "
                . "`form_col_property` as `fcp`"
                . ",`form_col` as `fc`"
                . ",`form_row` as `fr`"
                . ",`form` as `f`"
                . " WHERE "
                . " `fcp`.`id_parent`=`fc`.`id` AND `fc`.`id_parent`=`fr`.`id` AND `fr`.`id_parent`=`f`.`id`"
                . " AND `fcp`.`property`='label'"
                . " AND `f`.`id`=:id"
                . " AND `f`.`delete_status`='0' AND `fr`.`delete_status`='0' AND `fc`.`delete_status`='0' AND `fcp`.`delete_status`='0' ORDER BY `fc`.`order`",[':id'=>[$id,"INT"]]);
    }
}

