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
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getAll(){
        return $this->Main->squery("SELECT `id` as `i`, `name` as `n`, `create_date` as `cd`, `mod_date` as `md` FROM `form` WHERE `delete_status`='0'");
    }
    public function getById(string|int $id=0):array{
        foreach($this->Main->squery("SELECT "
                . "`id` as `i`"
                . ",`name` as `n`"
                . ",`create_user_login` as `cul`"
                . ",`create_user_full_name` as `cufn`"
                . ",`create_user_email` as `cue`"
                . ",`create_date` as `cd`"
                . ",`mod_date` as `md` "
                . ",`mod_user_login` as `mul` "
                . ",`mod_user_email` as `mue` "
                . " FROM "
                . " `form` "
                . " WHERE "
                . " `delete_status`='0' "
                . " AND `id`=:id"
                ,
                [
                    ':id'=>[$id,'INT']
                ]
                ) as $form){
            return $form;
        }
        Throw New Exception ('Formularz o id `'.$id.'` został usunięty.',0); 
    }
    public function getById_2(string|int $id=0):array{
        return $this->Main->squery("SELECT "
                . "`id` "//as `id_db`
                . ",`name` "//as `title`
                . ",`create_user_login`"
                . ",`create_user_email`"
                . ",`create_date`"
                . ",`mod_date`"
                . ",`mod_user_login`"
                . ",`mod_user_email`"
                . ",`department_id`"
                . ",`department_name`"
                . " FROM "
                . " `form` "
                . " WHERE "
                . " `delete_status`='0' "
                //. " AND `hide_status`='0' "
                . " AND `id`=:id"
                ,
                [
                    ':id'=>[$id,'INT']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
                );
    }
    public function insert(object $data):void{
        $this->Main->query2(
                "INSERT INTO `form` ("
                . "`name`"
                . ",`department_id`"
                . ",`department_name`"
                . ",".parent::getUserKey().""
                . ") VALUES ("
                . ":name"
                . ",:department_id"
                . ",:department_name"
                . ",".parent::getUserValue().""
                . ");"
                ,array_merge([
                            ':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':name'=>[$data->title,'STR']
                        ], parent::getUserParm()));
    }
    public function update(object $data):void{
        $this->Main->query2("UPDATE `form` SET "
                . "`department_id`=:department_id"
                . ",`department_name`=:department_name"
                . ",`name`=:name"
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':name'=>[$data->title,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function remove(object $data):void{
        $this->Main->query2("UPDATE `form` SET "
                . "`delete_status`='1'"
                . ",`delete_date`='".parent::getDate()."' "
                . ",`delete_reason`=:reason"
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':reason'=>[$data->reason,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function hide(object $data):void{
        $this->Main->query2("UPDATE `form` SET "
                . "`hide_status`='1'"
                . ",`hide_date`='".parent::getDate()."' "
                . ",`hide_reason`=:reason"
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':reason'=>[$data->reason,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
}