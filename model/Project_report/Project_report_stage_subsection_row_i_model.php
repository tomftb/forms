<?php

class Project_report_stage_subsection_row_i_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(int $id=0, int $id_parent=0):void{
        $this->Main->query2(
            "INSERT INTO `project_report_stage_subsection_row_i` ("
                . "`id`"
                . ",`id_parent`"
                . ",".parent::getUserKey().""
                . ") VALUES ("
                . ":id"
                . ",:id_parent"
                . ",".parent::getUserValue().""
                . ");"
            ,array_merge(
                    [
                        ':id'=>[$id,'INT']
                        ,':id_parent'=>[$id_parent,'INT']
                    ]
                    ,parent::getUserParm()
            )
        );   
    }
    public function updateDeleteStatus(int $id=0,string $delete_status='1', string $delete_reason=''):void{
        $this->Main->query2("UPDATE "
                . "`project_report_stage_subsection_row_i` "
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
    public function getChild(int $id_parent=0):array{
        return $this->Main->squery(""
                . "SELECT "
                . "`id` "
                . "FROM "
                . "`project_report_stage_subsection_row_i` "
                . "WHERE "
                . "`id_parent`=:id_parent "
                . "AND `delete_status`='0';"
                ,[':id_parent'=>[$id_parent,'INT']]
                ,'FETCH_OBJ'
                ,'fetchAll');
    }
}