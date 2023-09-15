<?php

class Project_report_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function setDeleteState(int $id=0,string $status='1',string $reason='NEW VERSION'):void{
        $this->Main->query2("UPDATE `project_report` SET `delete_status`=:status,`delete_reason`=:reason,".parent::getUpdateSql()." WHERE `id`=:id", 
                        array_merge([':id'=>[$id,'INT'],':status'=>[$status,'STR'],':reason'=>[$reason,'STR']],parent::getAlterUserParm()));
    }      
    public function add(int $id_project=0,int $departmentId=0,string $departmentName=''):void{
        $this->Main->query2(
                "INSERT INTO `project_report` (`id_project`,`departmentId`,`departmentName`,".parent::getUserKey().") VALUES (:id_project,:departmentId,:departmentName,".parent::getUserValue().");"
                ,array_merge([':id_project'=>[$id_project,'INT'],':departmentId'=>[$departmentId,'INT'],':departmentName'=>[$departmentName,'STR']], parent::getUserParm()));
    }
    public function getByIdProject(int $id_project=0):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`id_project`"
                . ",`departmentId`"
                . ",`departmentName`"
                . ",`buffer_user_id`"
                . ",'n' as 'change' "
                . "FROM "
                . "`project_report` "
                . "WHERE "
                . "`id_project`=:id_project "
                . "AND `delete_status`='0' "
                . "ORDER BY "
                . "`id` "
                . "DESC Limit 0,1"
                ,[':id_project'=>[$id_project,'INT']]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function getById(int $id=0):array{
        return $this->Main->squery("SELECT "
                . "`id`"
                . ",`id_project`"
                . ",`departmentId`"
                . ",`departmentName`"
                . ",`buffer_user_id`"
                . ",'n' as 'change' "
                . "FROM "
                . "`project_report` "
                . "WHERE "
                . "`id`=:id "
                . "AND `delete_status`='0' "
                . "ORDER BY "
                . "`id` "
                . "ASC Limit 0,1"
                ,[':id'=>[$id,'INT']]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
}