<?php
class Allocation_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getList():array{
        return $this->Main->squery("SELECT * FROM `allocation`;");
    }
    public function getAbbreviationList():array{
        return $this->Main->squery("SELECT `id` as `i`,`name` as `n`,`default_checked` as `d` FROM `allocation`;");
    }
    public function getIdList():array{
        return $this->Main->squery("SELECT `id` FROM `allocation`;",[],'FETCH_ASSOC','fetchAll');
    }
    public function getEmployeeAllocation(int $id=0):array{
        return $this->Main->squery("SELECT 
            `id` as `i`
            , `name` as `n`
            , (CASE WHEN (SELECT `ea`.`id_employee` FROM `employee_allocation` as `ea` WHERE `ea`.`id_allocation`=`a`.`id` AND `ea`.`id_employee`=:id) IS NULL THEN 'n' ELSE 'y' END) as `d` 
            FROM 
            `allocation` as `a` 
            WHERE 1;"
                ,[
                    ':id'=>[$id,'INT']
                ]
        );
    }

}