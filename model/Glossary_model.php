<?php

class Glossary_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getIdName():array{
        return $this->Main->squery('SELECT `id`,`name` FROM `glossary` WHERE `id`>0 ORDER BY `id` ASC',[],'FETCH_OBJ','fetchAll');
    }
}
