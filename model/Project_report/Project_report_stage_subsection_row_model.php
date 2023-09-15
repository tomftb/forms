<?php

class Project_report_stage_subsection_row_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }    
    public function add(int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `project_report_stage_subsection_row` (`id_parent`,".parent::getUserKey().") VALUES (:id_parent,".parent::getUserValue().");"
                ,array_merge([':id_parent'=>[$id_parent,'INT']], parent::getUserParm()));
    }
    public function getByIdParent(int $id_parent=0):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`type` "
                . "FROM "
                . "`project_report_stage_subsection_row` "
                . "WHERE "
                . "`id_parent`=:id_parent"
                ,['id_parent'=>[$id_parent,'INT']]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
}