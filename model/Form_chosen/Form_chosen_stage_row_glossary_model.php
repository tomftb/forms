<?php
class Form_chosen_stage_row_glossary_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getListByIdParent(string|int $id_parent=0):array{
        return $this->Main->squery('SELECT '
                . '`id_glossary`'
                . ',`name`'
                . ',`id_glossary_position`'
                . ',`position_name`'
                . ' FROM `form_chosen_stage_row_glossary` '
                . ' WHERE '
                . '`id_row`=:id_parent '
                ,[
                    ':id_parent'=>[$id_parent,'INT']
                ]
                ,'FETCH_OBJ','fetchAll');
    }
}
