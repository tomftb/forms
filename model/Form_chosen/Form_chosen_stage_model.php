<?php
class Form_chosen_stage_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function insert(object $data, int $id_parent=0):void{
        $this->Main->query2(
                "INSERT INTO `form_chosen_stage` ("
                . "`id_parent`"
                . ",`id_form_stage`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title`"
                . ",".parent::getUserKey().""
                . ") VALUES ("
                . ":id_parent"
                . ",:id_form_stage"
                . ",:department_id"
                . ",:department_name"
                . ",:title"
                . ",".parent::getUserValue().""
                . ");"
                ,array_merge([
                            ':id_parent'=>[$id_parent,'INT']
                            ,':id_form_stage'=>[$data->id,'INT']
                            ,':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':title'=>[$data->title,'STR']
                        ], parent::getUserParm()));
    }
    public function update(object $data, int $id_parent=0):void{
        $this->Main->query2("UPDATE `form_chosen_stage` SET "
                . "`id_form_stage`=:id_form_stage"
                . ",`department_id`=:department_id"
                . ",`department_name`=:department_name"
                . ",`title`=:title"
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id "
                . "AND `id_parent`=:id_parent"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':id_parent'=>[$id_parent,'INT']
                            ,':id_form_stage'=>[$data->id,'INT']
                            ,':department_id'=>[$data->department_id,'INT']
                            ,':department_name'=>[$data->department_name,'STR']
                            ,':title'=>[$data->title,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function remove(object $data):void{
        $this->Main->query2("UPDATE `form_chosen_stage` SET "
                . "`delete_status`='1'"
                . ",`delete_reason`=:reason"
                . ",`delete_date`='".parent::getDate()."' "
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':reason'=>[$data->reason,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function hide(object $data):void{
        $this->Main->query2("UPDATE `form_chosen_stage` SET "
                . "`hide_status`='1'"
                . ",`hide_reason`=:reason"
                . ",`hide_date`='".parent::getDate()."' "
                . ",".parent::getUpdateSql()." "
                . " WHERE "
                . "`id`=:id"
                , array_merge(
                           [
                            ':id'=>[$data->id_db,'INT']
                            ,':reason'=>[$data->reason,'STR']
                ]
                ,parent::getAlterUserParm()
                )
        );
    }
    public function getList(string $hide_status='0',string $delete_status='0'):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`id_form_stage`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title`"
                . "FROM "
                . "`form_chosen_stage` "
                . "WHERE "
                . "`hide_status`=:hide_status "
                . "AND `delete_status`=:hide_status "
                . "AND `id`>0 "
                . "ORDER BY "
                . "`create_date`"
                ,[
                    ':hide_status'=>[$hide_status,'STR']
                    ,':delete_status'=>[$delete_status,'STR']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function getListByIdParent(string|int $id_parent=0,string $hide_status='0',string $delete_status='0'):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`id_form_stage`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title`"
                . "FROM "
                . "`form_chosen_stage` "
                . "WHERE "
                . "`hide_status`=:hide_status "
                . "AND `delete_status`=:hide_status "
                . "AND `id`>0 "
                . "AND `id_parent`=:id_parent "
                . "ORDER BY "
                . "`create_date`"
                ,[
                    ':hide_status'=>[$hide_status,'STR']
                    ,':delete_status'=>[$delete_status,'STR']
                    ,':id_parent'=>[$id_parent,'INT']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function getAvailableList():array{
        return $this->Main->squery("SELECT "
                . "`id` as `id_db`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title` "
                . " FROM "
                . "`form_chosen_stage` "
                . "WHERE "
                . "`hide_status`='0' "
                . "AND `delete_status`='0' "
                . "AND `id`>0 "
                . " ORDER BY "
                . "`create_date`"
                ,[]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function getAvailableListNoIdDb():array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",'' as `id_db`"
                . ",`department_id`"
                . ",`department_name`"
                . ",`title` "
                . " FROM "
                . "`form_chosen_stage` "
                . "WHERE "
                . "`hide_status`='0' "
                . "AND `delete_status`='0' "
                . "AND `id`>0 "
                . " ORDER BY "
                . "`create_date`"
                ,[]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function exists(string|int $id=0):string{
        foreach($this->Main->squery('SELECT `id` as `id` FROM `form_chosen_stage` WHERE `id`=:id',[':id'=>[$id,'INT']]) as $form_stage){
            return $form_stage['id'];
        }
        Throw New \Exception('form_chosen_stage with id - `'.$id.'` not exists in database!',0);
    }
    public function get(string|int $id=0):array{
        return $this->Main->squery('SELECT '
                . '`id` as `id_db`'
                . ',`department_id`'
                . ',`department_name`'
                . ',`title`'
                . ',`create_user_login`'
                . ',`create_user_email`'
                . ',`create_date`'
                . ',`mod_user_login`'
                . ',`mod_user_email`'
                . ',`mod_date`'
                . ',`buffer_user_id`'
                . ',`hide_status`'
                . ',`hide_reason`'
                . ',`delete_status`'
                . ',`delete_reason` '
                . ' FROM `form_chosen_stage` '
                . ' WHERE '
                . '`id`=:id'
                ,[
                    ':id'=>[$id,'INT']
                ]
                ,'FETCH_OBJ','fetchAll');
        //foreach($this->Main->squery('SELECT `id` as `id_db`,`department_id`,`department_name`,`title`,`create_user_login`,`create_user_email`,`create_date`,`mod_user_login`,`mod_user_email`,`buffer_user_id`,`hide_status`,`hide_reason`,`delete_status`,`delete_reason` FROM `form_stage` WHERE `id`=:id',[':id'=>[$id,'INT']],'FETCH_OBJ','fetchAll') as $form_stage){
          //  return $form_stage;
        //}
        //Throw New \Exception('form_stage with id - `'.$id.'` not exists in database!',0);
    }
    public function getStageUserById(string|int $id=0):array{       
        foreach($this->Main->squery('SELECT `create_user_login`,`create_user_email`,`create_date`,`mod_user_login`,`mod_user_email`,`mod_date` FROM `form_chosen_stage` WHERE `id`=:id',[':id'=>[$id,'INT']],'FETCH_OBJECT','fetchAll') as $form_stage_row_glossary){
            return $form_stage_row_glossary;
        }
        Throw New \Exception('form_chosen_stage with id - `'.$id.'` not exists in database!',0);
    }
}
