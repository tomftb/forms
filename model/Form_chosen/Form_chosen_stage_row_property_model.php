<?php
class Form_chosen_stage_row_property_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }

    public function insertProperty(string|int $id_row=0, string $name='',string $value=''):void{
        $this->Main->query2(
                "INSERT INTO `form_chosen_stage_row_property` (`id_row`,`name`,`value`) VALUES (:id_row,:name,:value);"
                ,[
                    ':id_row'=>[$id_row,'STR']
                    ,':value'=>[$value,'STR']
                    ,':name'=>[$name,'STR']
                ]
        );
    }
    public function deleteProperty(string|int $id_row=0):void{
        $this->Main->query2("DELETE FROM `form_chosen_stage_row_property` "
                . " WHERE "
                . "`id_row`=:id_row"
                ,[
                    ':id_row'=>[$id_row,'INT']
                ]
        );
    }
    public function getListByIdParent(string|int $id_parent=0):array{
        return $this->Main->squery('SELECT '
                . '`name`'
                . ',`value`'
                . ' FROM `form_chosen_stage_row_property` '
                . ' WHERE '
                . ' `id_row`=:id_parent '
                ,[
                    ':id_parent'=>[$id_parent,'INT']
                ]
                ,'FETCH_OBJ','fetchAll');
    }
}
