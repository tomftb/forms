<?php
class Employee_allocation_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function deleteByIdEmployee(int $id_employee=0):void{
        $this->Main->query2("DELETE FROM `employee_allocation` 
            WHERE `id_employee`=:id_employee;"
                ,[
                    ':id_employee'=>[$id_employee,'INT']
                ]
        );
    }
    public function insertByIdEmployee(int $id_employee=0,int $id_allocation=0):void{
        $this->Main->query('INSERT INTO `employee_allocation` ('
                . '`id_employee`'
                . ',`id_allocation`'
                . ') VALUES ('
                . ':id_employee'
                . ',:id_allocation'
                . ')'
                ,[
                    'id_employee'=>[$id_employee,'INT']
                    ,'id_allocation'=>[$id_allocation,'STR']
                ]
        ); 
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
    public function getEmployeesLike(string $name=''):array{
        return $this->Main->squery("SELECT "
                . "`e`.`id`"
                . ",CONCAT(`e`.`imie`,' ',`e`.`nazwisko`) as `ImieNazwisko` "
                . "FROM "
                . "`employee` as `e`"
                . ",`employee_allocation` as `ea`"
                . ",`allocation` as `a` "
                . "WHERE "
                . "`ea`.`id_employee`=`e`.`id` "
                . "AND `ea`.`id_allocation`=`a`.`id` "
                . "AND `a`.`name`=:name"
                . ";"
                ,[
                    ':name'=>[$name,'STR']
                ]
        );
    }
    public function getExceptEmployeesLike(string $name='', string $imie_nazwisko='',int $id=0){
        return $this->Main->squery("SELECT "
                . "`e`.`id`"
                . ",CONCAT(`e`.`imie`,' ',`e`.`nazwisko`) as `ImieNazwisko` "
                . "FROM "
                . "`employee` as `e`"
                . ",`employee_allocation` as `ea`"
                . ",`allocation` as `a` "
                . "WHERE "
                . "`ea`.`id_employee`=`e`.`id` "
                . "AND `ea`.`id_allocation`=`a`.`id` "
                . "AND `a`.`name`=:name "
                . "AND (`e`.`id`!=:id AND CONCAT(`e`.`imie`,' ',`e`.`nazwisko`)!=:imie_nazwisko)"
                . ";"
                ,[
                    ':name'=>[$name,'STR']
                    ,':id'=>[$id,'INT']
                    ,':imie_nazwisko'=>[$imie_nazwisko,'STR']
                ]
        );
    }
}