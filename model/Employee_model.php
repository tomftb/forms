<?php

class Employee_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getAll():array{
        return $this->Main->squery('SELECT * FROM `v_all_prac_v5` ORDER BY `ID` ASC'); 
    }
    public function add(array $parm=[]):void{
       
    }
    public function employeeExist(array $parm=[':imie'=>['','STR'],':nazwisko'=>['','STR']]):void{
        foreach($this->Main->squery('SELECT `imie`,`nazwisko` FROM `employee` WHERE `imie`=:imie AND `nazwisko`=:nazwisko AND `delete_status`=0',$parm,'FETCH_ASSOC','fetchAll') as $employee){
            Throw New \Exception("Istnieje już pracownik ".$employee['imie']." ".$employee['nazwisko']." o podanym imieniu i nazwisku",0);
        }
     }
    public function employeeExistId(array $parm=[':imie'=>['','STR'],':nazwisko'=>['','STR'],':id'=>[0,'INT']]):void{
        foreach($this->Main->squery('SELECT `imie`,`nazwisko` FROM `employee` WHERE `imie`=:imie AND `nazwisko`=:nazwisko AND `delete_status`=0',$parm,'FETCH_ASSOC','fetchAll') as $employee){
            Throw New \Exception("Istnieje już pracownik ".$employee['imie']." ".$employee['nazwisko']." o podanym imieniu i nazwisku z id ".$parm[":id"][0],0);
        }
    }
    public function getEmployeesLike(string $filter=''):array{
        return $this->Main->squery('SELECT * FROM `v_all_prac_v5` WHERE `ID` LIKE (:f) OR `ImieNazwisko` LIKE (:f) OR `Stanowisko` LIKE (:f) OR `Procent` LIKE (:f) OR `Email` LIKE (:f) ORDER BY `ID` asc',[':f'=>['%'.$filter.'%','STR']]); 
    }
    public function getEmployeeData(int $id=0):array{
        foreach($this->Main->squery('SELECT * FROM `v_all_prac_v4` WHERE ID=:i',[':i'=>[$id,'INT']]) as $employee){
           return $employee;
        }
        Throw New Exception ('Pracownik o id '.$id.' został usunięty.',0);
    }
    public function getProjectTeam(string|int $idProject=0):array{
        return $this->Main->squery("SELECT `id_employee` as 'pers','name' as `imie`,'surname' as `nazwisko`,`percentage` as 'percent',concat(substr(`employee_project`.`start_date`,9,11),'.',substr(`employee_project`.`start_date`,6,2),'.',substr(`employee_project`.`start_date`,1,4)) as 'ds',concat(substr(`employee_project`.`end_date`,9,11),'.',substr(`employee_project`.`end_date`,6,2),'.',substr(`employee_project`.`end_date`,1,4)) as 'de' FROM `employee_project` WHERE `id_project`=:id",[':id'=>[$idProject,'INT']]);
    }
    public function getTeam(string|int $idProject=0){
        return $this->Main->squery('SELECT `id_employee` as `idPracownik`, CONCAT(`name`,\' \',`surname`) as `ImieNazwisko`,`percentage` as `procentUdzial`,`start_date` as `datOd`,`end_date` as `datDo` FROM `employee_project` WHERE `id_project`=:id AND `delete_status`=\'0\'',[':id'=>[$idProject,'INT']]);
    }
    public function getMemeber(string|int $id=0):array{
        foreach($this->Main->squery('SELECT `imie`,`nazwisko`,`email` FROM `employee` WHERE `id`=:id',[':id'=>[$id,'INT']]) as $employee){
           return $employee;
        }
        Throw New Exception ('Pracownik o id '.$id.' nie istnieje. Został usunięty?',0);
    }
}
