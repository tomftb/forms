<?php
/**
 * Description of Form_stage_section_model
 *
 * @author tomborc
 */
class Form_stage_section_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(object $data,int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_section` (`id_parent`,".parent::getUserKey().") VALUES (:id_parent,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                ], parent::getUserParm()
                )
        );
    }
    public function update(object $data):void{
        $this->Main->query2("UPDATE `form_stage_section` SET "
                . "".parent::getUpdateSql().""
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id,'INT']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
}
