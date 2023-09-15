<?php

class Project_report_stage_subsection_row_p_variable_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(int $id_parent=0,int $id_variable=0,string $name='',string $value='',string $type='v'):void{
        $this->Main->query2(
            "INSERT INTO `project_report_stage_subsection_row_p_variable` ("
                . "`id_parent`"
                . ",`id_variable`"
                . ",`name`"
                . ",`value`"
                . ",`type`"
                . ") VALUES ("
                . ":id_parent"
                . ",:id_variable"
                . ",:name"
                . ",:value"
                . ",:type"
                . ");"
                ,array_merge([
                    ':id_parent'=>[$id_parent,'INT'],
                    ':id_variable'=>[$id_variable,'INT'],/* PDO NOT ACCEPT FLOAT */
                    ':name'=>[$name,'STR'],
                    ':value'=>[$value,'STR'],
                    ':type'=>[$type,'STR']
                ]
                )
        );
    }
}