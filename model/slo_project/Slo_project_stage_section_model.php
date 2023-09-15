<?php

class Slo_project_stage_section_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(int $id=0,$id_parent=0):void{
        $this->Main->query2(
            "INSERT INTO `slo_project_stage_section` ("
                . "`id`"
                . ",`id_parent`"
                . ",".parent::getUserKey().""
                . ") VALUES ("
                . ":id"
                . ",:id_parent"
                . ",".parent::getUserValue().""
                . ");"
            ,array_merge([
                ':id'=>[$id,'INT']
                ,':id_parent'=>[$id_parent,"INT"]
            ]
            ,parent::getUserParm()));   
    }
    public function updateDelete(int $id=0, string $delete_status='1', string $delete_reason='NEW VERSION'):void{
        // AND `delete_status`='0'
        $this->Main->query("UPDATE "
                . "`slo_project_stage_section` "
                . "SET "
                . "`delete_status`=:delete_status"
                . ",`delete_reason`=:delete_reason"
                . ",`delete_date`=:delete_date"
                . ",".parent::getUpdateSql()." "
                . "WHERE `id`=:id",
                array_merge([
                    ':id'=>[$id,'INT']
                    ,':delete_date'=>[parent::getDate(),'STR']
                    ,':delete_reason'=>[$delete_reason,"STR"]
                    ,':delete_status'=>[$delete_status,'STR']]
                    ,parent::getAlterUserParm()));
    }
    public function updateDeleteViaParent(int $id_parent=0, string $delete_status='1', string $delete_reason='NEW VERSION'):void{
        // AND `delete_status`='0'
        $this->Main->query("UPDATE "
                . "`slo_project_stage_section` "
                . "SET "
                . "`delete_status`=:delete_status"
                . ",`delete_reason`=:delete_reason"
                . ",`delete_date`=:delete_date"
                . ",".parent::getUpdateSql()." "
                . "WHERE `id_parent`=:id_parent",
                array_merge([
                    ':id_parent'=>[$id_parent,'INT']
                    ,':delete_date'=>[parent::getDate(),'STR']
                    ,':delete_reason'=>[$delete_reason,"STR"]
                    ,':delete_status'=>[$delete_status,'STR']]
                    ,parent::getAlterUserParm()));
    }
}