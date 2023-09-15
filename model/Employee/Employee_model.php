<?php

class Employee_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getAll():array{
        return $this->Main->squery('SELECT '
                . '`e`.`id` AS `ID`'
                . ', concat(`e`.`imie`,\' \',`e`.`nazwisko`) AS `ImieNazwisko`'
                . ', `e`.`stanowisko` AS `Stanowisko`'
                . ', (SELECT (CASE WHEN SUM(`ep`.`percentage`) IS NULL THEN 0 ELSE SUM(`ep`.`percentage`) END) FROM `employee_project` as `ep`, `project` as `p` WHERE `ep`.`id_project`=`p`.`id` AND `p`.`delete_status`=\'0\' AND `ep`.`id_employee`=`e`.`id` ) AS `Procent` '
                . ', `e`.`email` AS `Email`'
                . 'FROM '
                . ' `employee` as `e`'
                . 'WHERE  '
                . '`e`.`delete_status`=\'0\' '
                . 'ORDER BY `e`.`id` ASC'
        ); 
    }
    public function add(array $parm=[]):void{
       
    }
    public function employeeExists(string $imie='',string $nazwisko='',int $id=0):void{
        foreach($this->Main->squery('SELECT `imie`,`nazwisko` FROM `employee` WHERE `imie`=:imie AND `nazwisko`=:nazwisko AND `id`!=:id AND `delete_status`=\'0\'',[':id'=>[$id,'INT'],'imie'=>[$imie,'STR'],'nazwisko'=>[$nazwisko,'STR']],'FETCH_ASSOC','fetchAll') as $employee){
            Throw New \Exception("Istnieje już pracownik ".$employee['imie']." ".$employee['nazwisko']."!",0);
        }
    }
    public function getEmployeesLike(string $filter=''):array{
        return $this->Main->squery('SELECT '
                . '`e`.`id` AS `ID`'
                . ', concat(`e`.`imie`,\' \',`e`.`nazwisko`) AS `ImieNazwisko`'
                . ', `e`.`stanowisko` AS `Stanowisko`'
                . ', (SELECT (CASE WHEN SUM(`ep`.`percentage`) IS NULL THEN 0 ELSE SUM(`ep`.`percentage`) END) FROM `employee_project` as `ep`, `project` as `p` WHERE `ep`.`id_project`=`p`.`id` AND `p`.`delete_status`=\'0\' AND `ep`.`id_employee`=`e`.`id` ) AS `Procent` '
                . ', `e`.`email` AS `Email`'
                . 'FROM '
                . ' `employee` as `e` '
                . 'WHERE  '
                . '(`e`.`id` LIKE (:f) '
                . 'OR  concat(`e`.`imie`,\' \',`e`.`nazwisko`) LIKE (:f) '
                . 'OR `e`.`stanowisko` LIKE (:f) '
                //. 'OR `Procent` LIKE (:f) '
                . 'OR `e`.`email` LIKE (:f)) '
                . 'AND `e`.`delete_status`=\'0\' '
                . 'ORDER BY `e`.`id` asc',
                [
                    ':f'=>['%'.$filter.'%','STR']
                ]
        ); 
    }
    public function getEmployeeData(int $id=0):array{
        foreach($this->Main->squery('SELECT `id`,`imie`,`nazwisko`,`stanowisko`,`email` FROM `employee` WHERE `id`=:i AND `delete_status`=\'0\'',[':i'=>[$id,'INT']]) as $employee){
           return $employee;
        }
        Throw New Exception ('Pracownik o id '.$id.' został usunięty.',0);
    }
    public function getEmployeeUpperData(int $id=0):array{
        foreach($this->Main->squery('SELECT `id` as `ID`,`imie` as `Imie`,`nazwisko` as `Nazwisko`,`stanowisko` as `Stanowisko`,`email` as `Email` FROM `employee` WHERE `id`=:i AND `delete_status`=\'0\'',[':i'=>[$id,'INT']]) as $employee){
           return $employee;
        }
        Throw New Exception ('Pracownik o id '.$id.' został usunięty.',0);
    }
    public function getProjectTeam(string|int $idProject=0):array{
        return $this->Main->squery("SELECT "
                . "`id_employee` as 'pers'"
                . ",'name' as `imie`"
                . ",'surname' as `nazwisko`"
                . ",`percentage` as 'percent'"
                . ",concat(substr(`employee_project`.`start_date`,9,11),'.',substr(`employee_project`.`start_date`,6,2),'.',substr(`employee_project`.`start_date`,1,4)) as 'ds'"
                . ",concat(substr(`employee_project`.`end_date`,9,11),'.',substr(`employee_project`.`end_date`,6,2),'.',substr(`employee_project`.`end_date`,1,4)) as 'de' "
                . "FROM "
                . "`employee_project` "
                . " WHERE "
                . "`id_project`=:id",[':id'=>[$idProject,'INT']]);
    }
    public function getTeam(string|int $idProject=0):array{
        return $this->Main->squery('SELECT `id_employee` as `idPracownik`, CONCAT(`name`,\' \',`surname`) as `ImieNazwisko`,`percentage` as `procentUdzial`,`start_date` as `datOd`,`end_date` as `datDo` FROM `employee_project` WHERE `id_project`=:id AND `delete_status`=\'0\'',[':id'=>[$idProject,'INT']]);
    }
    public function getTeamInput(string|int $id_project=0){
         return $this->Main->squery("SELECT "
                 . "`id_employee` as `idPracownik`"
                 . ",CONCAT(`name`,' ',`surname`) as `ImieNazwisko`"
                 . ",`percentage` as `procentUdzial`"
                 . ",concat(substr(`start_date`,9,11),'.',substr(`start_date`,6,2),'.',substr(`start_date`,1,4)) as 'datOd'"
                 . ",concat(substr(`end_date`,9,11),'.',substr(`end_date`,6,2),'.',substr(`end_date`,1,4)) as 'datDo' "
                 . " FROM "
                 . "`employee_project` "
                 . " WHERE "
                 . "`id_project`=:id_project "
                 . "AND `delete_status`='0'"
                 ,[
                     ':id_project'=>[$id_project,'INT']
                ]
        );
    }
    public function getMemeber(string|int $id=0):array{
        foreach($this->Main->squery('SELECT `imie`,`nazwisko`,`email` FROM `employee` WHERE `id`=:id',[':id'=>[$id,'INT']]) as $employee){
           return $employee;
        }
        Throw New Exception ('Pracownik o id '.$id.' nie istnieje. Został usunięty?',0);
    }
    public function update(string $imie='',string $nazwisko='',string $stanowisko='',string $email='',int $id=0):void{
            $this->Main->query('UPDATE `employee` SET '
                    . '`imie`=:imie'
                    . ',`nazwisko`=:nazwisko'
                    . ',`stanowisko`=:stanowisko'
                    . ',`email`=:email'
                    . ','.parent::getUpdateSql()
                    . ' WHERE '
                    . '`id`=:id'
            ,array_merge(
                    [
                        ':imie'=>[$imie,'STR']
                        ,':nazwisko'=>[$nazwisko,'STR']
                        ,':stanowisko'=>[$stanowisko,'STR']
                        ,':email'=>[$email,'STR']
                        ,':id'=>[$id,'INT']
                    ]
                    ,parent::getAlterUserParm()
            ));
    }
    public function setDeleteStatus(int $id=0):void{
            $this->Main->query('UPDATE `employee` SET `delete_status`=\'1\' WHERE `id`=:id',[':id'=>[$id,'STR']]);

    }
}


