<?php
class Form_stage_row_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(object $data,int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row` (`id_parent`,`value`,`name`,`type`,".parent::getUserKey().") VALUES (:id_parent,:value,:name,:type,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                ], parent::getUserParm()
                )
        );
    }
    public function update(object $data):void{
        $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`value`=:value"
                . ",`name`=:name"
                . ",`type`=:type"
                . ",`delete_status`='0'"
                . ",`delete_reason`=''"
                . ",`delete_date`=NULL"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function setNewVersion(int $id_parent=0){
                $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`delete_status`='1'"
                . ",`delete_reason`='NEW VERSION'"
                . ",`delete_date`='".parent::getDate()."'"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id_parent`=:id_parent"
                , array_merge(
                           [
                            ':id_parent'=>[$id_parent,'INT']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function insertChild(object $data,int $id_parent=0,int $id_row):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row` (`id_parent`,`id_row`,`value`,`name`,`type`,".parent::getUserKey().") VALUES (:id_parent,:id_row,:value,:name,:type,".parent::getUserValue().");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                            ,':id_row'=>[$id_row,'STR']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                ], parent::getUserParm()
                )
        );
    }
    public function updateChild(object $data):void{
        $this->Main->query2("UPDATE `form_stage_row` SET "
                . "`value`=:value"
                . ",`name`=:name"
                . ",`type`=:type"
                . ",`delete_status`='0'"
                . ",`delete_reason`=''"
                . ",`delete_date`=NULL"
                . ",".parent::getUpdateSql().""
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':value'=>[$data->value,'STR']
                            ,':name'=>[$data->name,'STR']
                            ,':type'=>[$data->type,'STR']
                            ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function getByIdParent(string|int $id_parent=0):array{
        return $this->Main->squery('SELECT '
                . '`id` as `id_db`'
                . ',`name`'
                . ',`type`'
                . ',`value`'
                . ' FROM `form_stage_row` '
                . ' WHERE '
                . '`id_parent`=:id_parent '
                . 'AND `id_row` IS NULL'
                ,[
                    ':id_parent'=>[$id_parent,'INT']
                ]
                ,'FETCH_OBJ','fetchAll');
    }
    public function getNoIdDbByIdParent(string|int $id_parent=0):array{
        return $this->Main->squery('SELECT '
                . '`id`'
                . ',\'\' as `id_db`'
                . ',`name`'
                . ',`type`'
                . ',`value`'
                . ' FROM `form_stage_row` '
                . ' WHERE '
                . '`id_parent`=:id_parent '
                . 'AND `id_row` IS NULL'
                ,[
                    ':id_parent'=>[$id_parent,'INT']
                ]
                ,'FETCH_OBJ','fetchAll');
    }
    public function insertProperty(string|int $id_row=0, string $name='',string $value=''):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row_property` (`id_row`,`name`,`value`) VALUES (:id_row,:name,:value);"
                ,[
                    ':id_row'=>[$id_row,'STR']
                    ,':value'=>[$value,'STR']
                    ,':name'=>[$name,'STR']
                ]
        );
    }
    public function deleteProperty(string|int $id_row=0):void{
        $this->Main->query2("DELETE FROM `form_stage_row_property` "
                . " WHERE "
                . "`id_row`=:id_row"
                ,[
                    ':id_row'=>[$id_row,'INT']
                ]
        );
    }
    public function insertStyle(string|int $id_row=0, string $name='',string $value=''):void{
        $this->Main->query2(
                "INSERT INTO `form_stage_row_style` (`id_row`,`name`,`value`) VALUES (:id_row,:name,:value);"
                ,[
                    ':id_row'=>[$id_row,'STR']
                    ,':value'=>[$value,'STR']
                    ,':name'=>[$name,'STR']
                ]
        );
    }
    public function deleteStyle(string|int $id_row=0):void{
                $this->Main->query2("DELETE FROM `form_stage_row_style` "
                . " WHERE "
                . "`id_row`=:id_row"
                ,[
                    ':id_row'=>[$id_row,'INT']
                ]
        );
    }
    public function deleteGlossary(string|int $id_row=0):void{
                $this->Main->query2("DELETE FROM `form_stage_row_glossary` "
                . " WHERE "
                . "`id_row`=:id_row"
                ,[
                    ':id_row'=>[$id_row,'INT']
                ]
        );
    }
    public function insertGlossary(object $row_glossary,string|int $id_row=0):void{
        //print_r($row_glossary);
        $this->Main->query2(
                "INSERT INTO `form_stage_row_glossary` (`id_row`,`id_glossary`,`name`,`id_glossary_position`,`position_name`) VALUES (:id_row,:id_glossary,:name,:id_glossary_position,:position_name);"
                ,[
                    ':id_row'=>[$id_row,'STR']
                    ,':id_glossary'=>[$row_glossary->id_glossary,'STR']
                    ,':name'=>[$row_glossary->name,'STR']
                    ,':id_glossary_position'=>[$row_glossary->id_glossary_position,'STR']
                    ,':position_name'=>[$row_glossary->position_name,'STR']
                ]
        );
    }
    public function getGlossaryByIdRow(string|int $id_row=0):array{
        foreach($this->Main->squery('SELECT `id_glossary`,`name`,`id_glossary_position`,`position_name` FROM `form_stage_row_glossary` WHERE `id_row`=:id_row',[':id_row'=>[$id_row,'INT']],'FETCH_OBJECT','fetchAll') as $form_stage_row_glossary){
            return $form_stage_row_glossary;
        }
        Throw New \Exception('form_stage_row_glossary with id_row - `'.$id_row.'` not exists in database!',0);
    }
    public function getChild(string|int $id_row=0):array{
        foreach($this->Main->squery('SELECT `id` as `id_db`,`value`,`name`,`type` FROM `form_stage_row` WHERE `id_row`=:id_row',[':id_row'=>[$id_row,'INT']],'FETCH_OBJECT','fetchAll') as $form_stage_row_glossary){
            return $form_stage_row_glossary;
        }
        Throw New \Exception('form_stage_row with id_row - `'.$id_row.'` not exists in database!',0);
    }
}
