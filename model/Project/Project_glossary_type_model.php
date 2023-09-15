<?php

class Project_glossary_type_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function get(){
        return $this->Main->squery('SELECT * FROM `project_glossary_type` ORDER BY `ID` ASC');
    }
    public function getProjectOnTop(int $ID=0):array{
        return $this->Main->squery('SELECT * FROM `project_glossary_type` WHERE `ID`=:ID UNION SELECT * FROM `project_glossary_type` WHERE `ID`!=:ID; ',[':ID'=>[$ID,'INT']]);
    }
}