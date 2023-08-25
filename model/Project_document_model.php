<?php

class Project_document_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function getById(string|int $id=0):array{
        return $this->Main->squery('SELECT `id` as "ID",`name` as "Nazwa" FROM `project_document` WHERE `id_project`=:id ORDER BY `id` ASC',[':id'=>[$id,'INT']]);
    }
}