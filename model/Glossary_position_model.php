<?php

class Glossary_position_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getIdNameByIdGlossary(string|int $id_glossary=0):array{
        return $this->Main->squery('SELECT `id`,`name` FROM `glossary_position` WHERE `id`>0 AND `id_glossary`=:id_glossary ORDER BY `id` ASC',[':id_glossary'=>[$id_glossary,'INT']],'FETCH_OBJ','fetchAll');
    }
}
