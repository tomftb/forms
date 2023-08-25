<?php
/**
 * Description of Filled_form_field
 *
 * @author tomborc
 */
class Filled_form_field_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getAll(){
        return $this->Main->squery('SELECT *
                        FROM `filled_form_field` ORDER BY `id` DESC'
                );
    }
    public function getByIdForm(string|int $id_filled_form=0):array{
        return $this->Main->squery('SELECT 
                        (CASE WHEN `id_form_field` IS NULL THEN 0 ELSE `id_form_field` END) as `i`
                        ,`value` as `v`
                         FROM `filled_form_field` WHERE `delete_status`=\'0\' AND `id_filled_form`=:id_filled_form ORDER BY `id` DESC',[':id_filled_form'=>[$id_filled_form,'INT']]
                );
    }
    public function getNotNullByIdForm(string|int $id_filled_form=0):array{
        return $this->Main->squery('SELECT 
                        `id_form_field` as `i`
                        ,`value` as `v`
                         FROM `filled_form_field` WHERE `delete_status`=\'0\' AND `id_filled_form`=:id_filled_form AND `id_form_field` IS NOT NULL ORDER BY `id` DESC',[':id_filled_form'=>[$id_filled_form,'INT']]
                );
    }
    public function getByIdFilledFormIdFormField(string|int $id_filled_form=0,string|int $id_form_field=0):array{
        return $this->Main->squery('SELECT 
                        `value` as `v`
                        FROM `filled_form_field` WHERE `delete_status`=\'0\' AND `id_filled_form`=:id_filled_form AND `id_form_field`=:id_form_field Limit 0,1',[':id_filled_form'=>[$id_filled_form,'INT'],':id_form_field'=>[$id_form_field,'INT']]
                ,'FETCH_ASSOC','fetchAll');
    }
}
