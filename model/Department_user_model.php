<?php

class Department_user_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getUserDepartments(string|int $id_user=0):array{
        return $this->Main->squery("SELECT "
                ."`d`.`ID` as `id`"
                .", `d`.`NAME` as `name`"
                ." FROM " 
                ."`department_user` as `du` "
                .",`department` as `d` "
                ." WHERE "
                . " `du`.`id_department`=`d`.`ID` "
                . " AND `du`.`id_user`=:id_user "
                ,[
                    ':id_user'=>[$id_user,'INT']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }

}