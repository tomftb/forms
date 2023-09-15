<?php

class Project_document_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function getById(string|int $id=0):array{
        return $this->Main->squery('SELECT '
                . '`id` as "ID"'
                . ',`name` as "Nazwa"'
                . ' FROM '
                . '`project_document` '
                . ' WHERE '
                . '`id_project`=:id '
                . 'AND `delete_status`=\'0\' '
                . 'ORDER BY '
                . '`id` ASC'
                ,[':id'=>[$id,'INT']]
        );
    }
    public function getNamesByIdProject(int $id_project=0):array{
        return $this->Main->squery('SELECT '
                . '`name` '
                . ' FROM '
                . '`project_document` '
                . 'WHERE '
                . '`id_project`=:id_project '
                . 'AND `delete_status`=\'0\' ',[':id_project'=>[$id_project,'INT']]);
    }
    public function setDeleteStatusByIdProject(int $id=0,int $id_project=0):void{
                  
            $this->Main->query('UPDATE `project_document` SET '
                    . 'delete_status=:delete_status'
                    . ','.parent::getUpdateSql()
                    . ' WHERE '
                    . 'id_project=:id_project '
                    . 'AND id=:id'
                    ,array_merge(
                            [
                                ':delete_status'=>['1','STR']
                                ,':id_project'=>[$id_project,'INT']
                                ,':id'=>[$id,'INT']
                            ]
                            ,parent::getAlterUserParm() 
                    )
            ); 
    }
    public function getByIdProject(int $id_project=0,int $id=0):array{
        return $this->Main->squery('SELECT * FROM `project_document` WHERE `id_project`=:id_project AND `id`=:id',[
            ':id_project'=>[$id_project,'INT'],
            ':id'=>[$id,'INT'],
            ]
        );      
    }
    public function insert(int $id=0,int $id_project=0,string $name=''):void{
        $this->Main->query('INSERT INTO `project_document` ('
                . '`id`'
                . ',`id_project`'
                . ',`name`'
                .','.parent::getUserKey()
                . ') VALUES ('
                .':id'
                . ',:id_project'
                . ',:name'
                . ','.parent::getUserValue()
                .');'
                ,array_merge(
                        [
                        ':id'=>[$id,'INT']
                        ,':id_project'=>[$id_project,'INT']
                        ,':name'=>[$name,'STR'] 
                        ]
                        ,parent::getUserParm()
                )
        );     
        
    }
}