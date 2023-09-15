<?php

class Employee_project_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getTeamById(string|int $idProject=0){
        return $this->Main->squery("SELECT
		`e`.`id`,
		CONCAT(`e`.`imie`,' ',`e`.`nazwisko`) as 'ImieNazwisko',
                (select (100 - cast(ifnull(sum(`ep`.`percentage`),0) as signed)) FROM `employee_project` as `ep` WHERE `e`.`id`=`ep`.`id_employee` and `ep`.`end_date`<=curdate() and `ep`.`delete_status`='0' AND `id_project`<>:id) as 'ava'         
                FROM 
                `employee` e
                WHERE 
            `e`.`delete_status`='0'
                ",[':id'=>[$idProject,'INT']]);
    }
    public function getAvaTeamMember(string|int $idEmployee=0,string|int $idProject=0):array{ 
	return $this->Main->squery("select 
                            `e`.`id` AS `id`,
                            (select (100 - cast(ifnull(sum(`ep`.`percentage`),0) as signed)) FROM `employee_project` as `ep` 
                            WHERE
                            ((`ep`.`end_date` > curdate()) and `ep`.`delete_status` = '0' AND `ep`.`id_project`<>:idProject AND `ep`.`id_employee` = `e`.`id`)) AS `ava` 
                            FROM `employee` as `e` where `e`.id=:idEmployee AND `e`.`delete_status` = '0';"
                ,[
            ':idProject'=>[$idProject,'INT'],
            ':idEmployee'=>[$idEmployee,'INT'],
        ]);
    }
    public function add(string|int $id_employee=0,string|int $id_project=0,string $name='',string $surname='',int $percentage=0, string $start_date='',string $end_date=''):void{
        (array)$parm=[
             ":id_employee"=>[$id_employee,'INT']
            ,":id_project"=>[$id_project,'INT']
            ,":name"=>[$name,'STR']
            ,":surname"=>[$surname,'STR']
            ,":percentage"=>[$percentage,'INT']
            ,":start_date"=>[$start_date,'STR']
            ,":end_date"=>[$end_date,'STR']
        ];
        $this->Main->query('INSERT INTO `employee_project` 
            (id_employee,id_project,name,surname,percentage,start_date,end_date,'.parent::getUserKey().') 
		VALUES
		(:id_employee,:id_project,:name,:surname,:percentage,:start_date,:end_date,'.parent::getUserValue().')'
            ,array_merge($parm,parent::getUserParm()));  
    }
    public function update(string|int $id_employee=0,string|int $id_project=0,string $name='',string $surname='',int $percentage=0, string $start_date='',string $end_date=''){
        (array)$parm=[
             ":id_employee"=>[$id_employee,'INT']
            ,":id_project"=>[$id_project,'INT']
            ,":name"=>[$name,'STR']
            ,":surname"=>[$surname,'STR']
            ,":percentage"=>[$percentage,'INT']
            ,":start_date"=>[$start_date,'STR']
            ,":end_date"=>[$end_date,'STR']
        ];
        $this->Main->query(
                     'UPDATE `employee_project` SET '
                . '`name`=:name '
                . ',`surname`=:surname '
                . ',`percentage`=:percentage '
                . ',`start_date`=:start_date '
                . ',`end_date`=:end_date '
                . ',`delete_status`=\'0\' '
                . ',`delete_date`=null '
                . ',`delete_reason`="" '
                . ','.parent::getUpdateSql()
                . ' WHERE '
                . 'id_project=:id_project '
                . 'AND id_employee=:id_employee',array_merge($parm,parent::getAlterUserParm()));
    }
    public function remove(string|int $id_employee=0,string|int $id_project=0):void{
        (array)$parm=[
             ":id_employee"=>[$id_employee,'INT']
            ,":id_project"=>[$id_project,'INT']
        ];
        
        $this->Main->query('UPDATE '
                . '`employee_project` '
                . 'SET '
                . parent::getUpdateSql()
                . ',`delete_status`="1"'
                . ',`delete_date`=\''.parent::getDate().'\''
                . ',`delete_reason`="Removed by user"'
                . ' WHERE '
                . '`id_project`=:id_project '
                . 'AND `id_employee`=:id_employee;'
                ,array_merge($parm,parent::getAlterUserParm())); 
            
    }
    public function getTeamMember(string|int $id=0):array{  
         return $this->Main->query('SELECT `id_employee` as `idPracownik`,CONCAT(`name`,\' \',`surname`) as `ImieNazwisko`,`percentage` as `procentUdzial`,`start_date` as `datOd`,`end_date` as `datDo` FROM `employee_project` WHERE `id_employee`=:id and `delete_status`=\'0\'',[':id'=>[$id,'INT']]);
         
    }
    public function getTeamPdfInput(int $id_project=0):array{
        return $this->Main->squery('SELECT '
                . 'CONCAT(`ep`.`name`,\' \',`ep`.`surname`) as `NazwiskoImie`'
                . ',`ep`.`start_date` as `DataOd`'
                . ',`ep`.`end_date` as `DataDo` '
                . ' FROM '
                . ' `employee_project` as `ep` '
                . 'WHERE '
                . '`id_project`=:id_project'
                ,['id_project'=>[$id_project,'INT']]
        );
    }
}
