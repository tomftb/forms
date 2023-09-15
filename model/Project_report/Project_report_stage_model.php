<?php

class Project_report_stage_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }    
    public function add(int $ordinal_number=0,string $title='',string $valuenewline='',string $part='',int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `project_report_stage` (`id_parent`,`ordinal_number`,`title`,`new_page`,`part`,".parent::getUserKey().") VALUES (:id_parent,:ordinal_number,:title,:new_page,:part,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT'],
                            ':ordinal_number'=>[$ordinal_number,'INT'],
                            ':title'=>[$title,'STR'],
                            ':new_page'=>[$valuenewline,'STR'],
                            ':part'=>[$part,'STR']
                        ], parent::getUserParm()));
    }
    public function getPartByIdParent(int $id_parent=0, string $part=''):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`id_parent`"
                . ",`ordinal_number`"
                . ",`title`"
                . ",`new_page` as 'valuenewline' "
                . "FROM "
                . "`project_report_stage` "
                . "WHERE "
                . "`id_parent`=:id_parent "
                . "AND `delete_status`='0' "
                . "AND `part`=:part "
                . "ORDER BY "
                . "`ordinal_number` "
                . "ASC"
                ,[
                    ':id_parent'=>[$id_parent,'INT']
                    ,':part'=>[$part,'STR']
                ]
                ,'FETCH_OBJ'
        ,'fetchAll');
    }
}