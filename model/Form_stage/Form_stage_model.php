<?php
/**
 * Description of Form_stage_model
 *
 * @author tomborc
 */
class Form_stage_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(object $data):void{
        $this->Main->query2(
                "INSERT INTO `form_stage` (`department_id`,`department_name`,`title`,".parent::getUserKey().") VALUES (:department_id,:department_name,:title,".parent::getUserValue().");"
                ,array_merge([
                            ':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':title'=>[$data->title,'STR']
                        ], parent::getUserParm()));
    }
    public function update(object $data):void{
        $this->Main->query2("UPDATE `form_stage` SET "
                . "`department_id`=:department_id"
                . ",`department_name`=:department_name"
                . ",`title`=:title"
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':title'=>[$data->title,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function getList(string $hide_status='0',string $delete_status='0'):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title`"
                . ",`create_date`"
                . ",`mod_date`"
                . "FROM "
                . "`form_stage` "
                . "WHERE "
                . "`hide_status`=:hide_status "
                . "AND `delete_status`=:hide_status "
                . "AND `id`>0 "
                . "ORDER BY "
                . "`create_date`"
                ,[
                    ':hide_status'=>[$hide_status,'STR']
                    ,':delete_status'=>[$delete_status,'STR']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
}
