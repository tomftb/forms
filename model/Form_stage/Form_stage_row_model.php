<?php
/**
 * Description of Form_stage_row_model
 *
 * @author tomborc
 */
class Form_stage_row_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(object $data,int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row` (`id_parent`,`value`,`name`,`type`,".parent::getUserKey().") VALUES (:id_parent,:value,:name,:type,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                ], parent::getUserParm()
                )
        );
    }
    public function update(object $data):void{
        $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`value`=:value"
                . ",`name`=:name"
                . ",`type`=:type"
                . ",`delete_status`='0'"
                . ",`delete_reason`=''"
                . ",`delete_date`=NULL"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function setNewVersion(int $id_parent=0){
                $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`delete_status`='1'"
                . ",`delete_reason`='NEW VERSION'"
                . ",`delete_date`='".parent::getDate()."'"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id_parent`=:id_parent"
                , array_merge(
                           [
                            ':id_parent'=>[$id_parent,'INT']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function insertChild(object $data,int $id_parent=0,int $id_row):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row` (`id_parent`,`id_row`,`value`,`name`,`type`,".parent::getUserKey().") VALUES (:id_parent,:id_row,:value,:name,:type,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                            ,':id_row'=>[$id_row,'STR']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                ], parent::getUserParm()
                )
        );
    }
    public function updateChild(object $data):void{
        $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`value`=:value"
                . ",`name`=:name"
                . ",`type`=:type"
                . ",`delete_status`='0'"
                . ",`delete_reason`=''"
                . ",`delete_date`=NULL"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
}
