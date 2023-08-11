<?php
class ManageEmployee
{
    private ?object $Model;
    private $inpArray=array();
    protected $infoArray=array
            (
                "imie_nazwisko"=>array
                (
                    "Podane Imię lub Nazwisko jest za krótkie",
                    "Istnieje już pracownik o podanym Imieniu i Nazwisku",
                    "Podane Imię lub Nazwisko jest za długie"
                ),
                "input"=>array
                (
                    "Nie uzupełniono pola.",
                    "Wprowadzona wartość jest za długa",
                    "Wprowadzona wartość jest za krótka"
                )
            );
    private $Log;
    private $dbLink;
    private $date="1970-01-01 00:00:01";
    private $RA='127.0.0.1';
    private ?int $id=0;
    function __construct()
    {
        $this->Model=new \stdClass();
        $this->Log=Logger::init(__METHOD__);
        $this->dbLink=LoadDb::load();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities=NEW \Utilities();
        $this->Model->{'Employee'}=new \Employee_model();
        $this->date=date("Y-m-d H:i:s");
        $this->RA=filter_input(INPUT_SERVER,'REMOTE_ADDR');
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function cEmployee(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        self::checkEmployeeValueLength();
        self::employeeExist();
        self::addEmployee();     
        $this->Utilities->jsonResponse('','cModal');
    }
    private function employeeExist(){
        $this->Log->log(0,"[".__METHOD__."]");  
        $this->Model->{'Employee'}->employeeExist([':imie'=>[$this->inpArray['Imie'],'STR'],':nazwisko'=>[$this->inpArray['Nazwisko'],'STR']]);
    }
    private function employeeExistId(){
        $this->Log->log(0,"[".__METHOD__."]");  
        $this->Model->{'Employee'}->employeeExistId([':imie'=>[$this->inpArray['Imie'],'STR'],':nazwisko'=>[$this->inpArray['Nazwisko'],'STR'],':id'=>[$this->inpArray['ID'],'INT']]); 
    }
    public function eEmployeeOn(){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'ID',true,1);
        self::checkEmployeeValueLength();
        self::employeeExistId();
        self::updateEmployee();
        $this->Utilities->jsonResponse('','cModal');          
    }
    protected function setEmployeeAllocation(int $idEmployee=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        // CHECK AVALIABLE DICTIONARY
        $specPost=self::getSpecTabId();
        $specDb=self::getSpec();
        $this->checkSpecInDb($specPost,$specDb);
        self::setSpec($specDb,$specPost,$idEmployee);
    }
    private function setSpec($t1,$t2,$idEmployee)
    {
        /*
         * SET SLO
         * t1 => DATABASE
         * t2 => POST
         */
        foreach($t1 as $v)
        {
            $sql=[
              'idp'=>[$idEmployee,'INT'],
              'ids'=>[$v,'INT']
            ];
            if(in_array($v,$t2)){
                SELF::addEmployeeAllocation($sql);
            }
            else{
                self::removeEmployeeAllocation($sql);
            }
        } 
    }
    public function eEmployeeSpecOn()
    {
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'ID',true,1);
        self::setEmployeeAllocation($this->inpArray['ID']);
        $this->Utilities->jsonResponse('','cModal');          
    }
    protected function checkSpecInDb($t1,$t2)
    {
        /*
         * CHECK EXIST IN DB
         * t1 => POST
         * t2 => DATABASE
         */
        $this->Log->log(0,"[".__METHOD__."]");   
        foreach($t1 as $v){
            $this->Log->log(0,"[".__METHOD__."] ID => ".$v); 
            if(!in_array($v,$t2)){  
                Throw New Exception ("DICTIONARY ID => ".$v." NOT FOUND IN DB",1);
            }         
        }
    }
    private function getSpec(){
        $db=array(); 
        foreach($this->dbLink->squery('SELECT `ID` FROM `v_slo_u_spec`',[],'FETCH_ASSOC','fetchAll') as $v){
            array_push($db,$v['ID']);
        }
        $this->Log->logMulti(2,$db,__LINE__."::".__METHOD__." db");
        return ($db);
    }
    protected function checkEmployeeValueLength()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $err='';
        if(strlen($this->inpArray['Imie'])<3 || strlen($this->inpArray['Nazwisko'])<3){
            $err.=$this->infoArray['imie_nazwisko'][0]."<br/>";
        }
        if(strlen($this->inpArray['Imie'])>30 || strlen($this->inpArray['Nazwisko'])>30){
             $err.=$this->infoArray['imie_nazwisko'][2]."<br/>";
        }
        if($err){
            Throw New Exception($err,0);
        }
    }
    protected function addEmployee(){
        $this->Log->log(0,"[".__METHOD__."]");
        $id = random_int(1000000000, 1099511627776);
        $parm = [
                ':id'=>[$id,'INT'],
                ':imie'=>[$this->inpArray['Imie'],'STR'],
                ':nazwisko'=>[$this->inpArray['Nazwisko'],'STR'],
                ':stanowisko'=>[$this->inpArray['Stanowisko'],'STR'],
		':email'=>[$this->inpArray['Email'],'STR'],
                ':create_user_id'=>[intval($_SESSION['userid'],10),'INT'],
                ':create_user_login'=>[$_SESSION['username'],'STR'],
                ':create_user_full_name'=>[$_SESSION['nazwiskoImie'],'STR'],
                ':create_user_email'=>[$_SESSION['mail'],'STR'],
                ':create_date'=>[$this->date,'STR'],
                ':create_host'=>[$this->RA,'STR'],
                ':mod_user_id'=>[intval($_SESSION['userid'],10),'INT'],
                ':mod_user_login'=>[$_SESSION['username'],'STR'],
                ':mod_user_full_name'=>[$_SESSION['nazwiskoImie'],'STR'],
                ':mod_user_email'=>[$_SESSION['mail'],'STR'],
                ':mod_date'=>[$this->date,'STR'],
                ':mod_host'=>[$this->RA,'STR']
            ];
            
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            $this->dbLink->query('INSERT INTO `employee` (`id`,`imie`,`nazwisko`,`stanowisko`,`email`,`create_user_id`,`create_user_login`,`create_user_full_name`,`create_user_email`,`create_date`,`create_host`,`mod_user_id`,`mod_user_login`,`mod_user_full_name`,`mod_user_email`,`mod_date`,`mod_host`) 
		VALUES
		(:id,:imie,:nazwisko,:stanowisko,:email,:create_user_id,:create_user_login,:create_user_full_name,:create_user_email,:create_date,:create_host,:mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_date,:mod_host)'
            ,$parm);
            self::setEmployeeAllocation($parm[':id'][0]); 
            $this->dbLink->commit();  
        }
        catch (PDOException $p){
            $this->Main->rollback();
            Throw New \Exception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$p->getMessage(),1); 
        } 
      
    }
    protected function updateEmployee(){
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            $sql=[
                ':imie'=>[$this->inpArray['Imie'],'STR'],
                ':nazwisko'=>[$this->inpArray['Nazwisko'],'STR'],
                ':stanowisko'=>[$this->inpArray['Stanowisko'],'STR'],
                ':email'=>[$this->inpArray['Email'],'STR'],
                ':id'=>[$this->inpArray['ID'],'INT'],
                ':mod_user_id'=>[intval($_SESSION['userid'],10),'INT'],
                ':mod_user_login'=>[$_SESSION['username'],'STR'],
                ':mod_user_full_name'=>[$_SESSION['nazwiskoImie'],'STR'],
                ':mod_user_email'=>[$_SESSION['mail'],'STR'],
                ':mod_date'=>[$this->date,'STR'],
                ':mod_host'=>[$this->RA,'STR']
            ];
            $this->dbLink->query('UPDATE `pracownik` SET `imie`=:imie, `nazwisko`=:nazwisko, `stanowisko`=:stanowisko,`email`=:email,`mod_user_id`=:mod_user_id,`mod_user_login`=:mod_user_login,`mod_user_full_name`=:mod_user_full_name,`mod_user_email`=:mod_user_email,`mod_date`=:mod_date,`mod_host`=:mod_host WHERE `id`=:id'
            ,$sql);
            self::setEmployeeAllocation($this->inpArray['ID']);
            $this->dbLink->commit();  
        }
        catch (PDOException $e){
            $this->dbLink->rollback();
            Throw New Exception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1); 
        }  
    }
    protected function addEmployeeAllocation($sql){
        // CHECK IS EXIST
        if(self::employeeSpecExists($sql)===0){
            // NOT EXIST -> ADD
            $this->Log->log(1,"[".__METHOD__."] SPEC SENDED IN POST AND NOT EXIST IN DB=> ADD"); 
            $this->dbLink->query('INSERT INTO `employee_allocation` (`id_employee`,`id_allocation`) VALUES (:idp,:ids)',$sql); 
        }
        else{
            $this->Log->log(1,"[".__METHOD__."] SPEC SENDED IN POST BUT ALREADY EXIST => NOTHING TO DO"); 
        }
    }
    protected function removeEmployeeAllocation($sql)
    {
        if(self::employeeSpecExists($sql)>0){
            // EXIST -> REMOVE
            $this->Log->log(1,"[".__METHOD__."] SPEC EXIST BUT NOT SENDED IN POST => REMOVE"); 
            $this->dbLink->query('DELETE FROM `employee_allocation` WHERE `id_employee`=:idp AND `id_allocation`=:ids',$sql); 
        }   
        else{
            $this->Log->log(1,"[".__METHOD__."] SPEC NOT SENDED IN POST AND NOT EXIST ID DB => NOTHING TO DO"); 
        }
    }
    private function employeeSpecExists($sql){
        return count($this->dbLink->squery('SELECT * FROM `employee_allocation` WHERE `id_employee`=:idp AND `id_allocation`=:ids',$sql,'FETCH_ASSOC','fetchAll'));
    }
    protected function getSpecTab(){
        $tmpArray=array();
        $id='';
        $name='';
        $i=0;
        foreach($this->inpArray as $key => $value)
        {
            if(strpos($key,'cbox-')!==false) 
            {
                $tmpData=explode('-',$key);
                $id=explode(':',$tmpData[1]);
                $name=explode(':',$tmpData[2]);
                $tmpArray[$i]['ID']=$id[1];
                $tmpArray[$i]['NAZWA']=$name[1];
                $tmpArray[$i]['CHECK']=$value;
                $i++;
            }
        }
        return $tmpArray;
    }
    protected function getSpecTabId()
    {
        $tmpArray=array();
        $id='';
        foreach($this->inpArray as $key => $value)
        {
            if(strpos($key,'cbox-')!==false) 
            {
                $tmpData=explode('-',$key);
                $id=explode(':',$tmpData[1]);
                array_push($tmpArray,$id[1]);
            }
        }
        $this->Log->logMulti(2,$tmpArray,__LINE__."::".__METHOD__." specPost");
        return $tmpArray;
    }
    protected function checkAndAddignTeamValue($key,$value,&$teamValueToFind,&$persAttributes,&$allPers,&$counter,$teamValueToFindLength)
    {
        $found=strpos($key,$teamValueToFind);
        if($found!==null && trim($found)!=='')
        {    
            //echo 'str pos - '.$found."\n";
            $persAttributes[$counter]=$value;
            $counter++;
            if($counter===$teamValueToFindLength)
            {
                // LAST ELEMENT OF PERS
                array_push($allPers,$persAttributes);
                $counter=0;
            }
        }
    }
    # DELETED EMPLOYEE IN DB
    public function dEmployee()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'ID',true,1);
        if(count(self::getEmplProj($this->inpArray['ID']))>0){
            Throw New Exception ('Employee can\'t be deleted. This employee appears in projects.',0);
        }  
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            $this->dbLink->query('UPDATE `employee` SET `delete_status`=1 WHERE `id`=:i',[':i'=>[$this->inpArray['ID'],'STR']]);
            $this->dbLink->commit();  
        }
        catch (PDOException $e){
            $this->dbLink->rollback();
            Throw New Exception("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1);
        }
        $this->Utilities->jsonResponse('','cModal');
    }
    public function getEmployeesSpecSlo(){
        $this->Utilities->setGetString('function',$this->inpArray);
        $this->Utilities->jsonResponse($this->dbLink->squery('SELECT * FROM `v_slo_u_spec` ORDER BY `ID` ASC'),$this->inpArray['function']);
    }
    public function getEmployeesLike(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->log(0,"[".__METHOD__."] filter - ".filter_input(INPUT_GET,'filter'));
        $this->Utilities->jsonResponse(['perm'=>$_SESSION['perm'],'data'=>$this->Model->{'Employee'}->getEmployeesLike(self::getFilter())],'sEmployees');
    }
     # RETURN ALL NOT DELETED PROJECT FROM DB
    public function getEmployeeProjects()
    {      
        $this->Utilities->setGet('id',$this->inpArray);
        $data[0]=$this->inpArray['id'];
        $data[1]=self::getEmplProj($this->inpArray['id']);
        $this->Utilities->jsonResponse($data,'projects');
    }
     # RETURN ALL NOT DELETED PROJECT FROM DB FOR DELETING EMPLOYY
    public function getDeletedEmployeeProjects()
    {
        $this->Utilities->setGet('id',$this->inpArray);
            /* TO DO 
            $data[1]=$this->query('SELECT \'NoPERM\' FROM v_proj_prac_v4 WHERE ID_Pracownik=? ORDER BY ID_Projekt ASC',$this->Utilities->getData());
            $this->response['info']='NO PERMISSION TO SEE EMPLOYEE PROJECTS';
             * 
             */
        $data[0]=$this->inpArray['id'];
        $data[1]=$this->dbLink->squery('SELECT `ID_Projekt`,`Numer_umowy`,`Temat_umowy`,`Procent_udziału`,`Data_od`,`Data_do` FROM `v_proj_prac_v4` WHERE `ID_Pracownik`=:i ORDER BY `ID_Projekt` ASC',[':i'=>[$this->inpArray['id'],'INT']]);       
        $this->Utilities->jsonResponse($data,'dEmployee');
    }
    private function getEmplProj($id)
    {
        return ($this->dbLink->squery('SELECT `ID_Projekt`,`Numer_umowy`,`Temat_umowy`,`Procent_udziału`,`Data_od`,`Data_do` FROM `v_proj_prac_v4` WHERE `ID_Pracownik`=:i ORDER BY `ID_Projekt` ASC',[':i'=>[$id,'INT']]));
    }
    # RETURN ALL EMPLOYEE SPEC DICTIONARY and other FROM DB
    private function employeeSpec($idEmployee)
    {
        $this->Log->log(0,"[".__METHOD__."] ID Employess => ".$idEmployee);
        // GET DICTIONARY
        $emplSpec=$this->dbLink->squery('SELECT * FROM `v_slo_u_spec` ORDER BY `ID` ASC ');
        // GET EMPLOYEE DICTIONARY 
        $emplSlo=$this->dbLink->squery('SELECT * FROM `v_all_prac_spec` WHERE `idPracownik`=:i ORDER BY `idSlownik` ASC ',['i'=>[$idEmployee,'INT']]);
        // COMBINE
        return ($this->combineSloEmployeeSpec($emplSpec,$emplSlo));
    }
    public function getEmployeeSpec(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int) $id=self::getId();
         $this->Utilities->jsonResponse([
            $this->Model->{'Employee'}->getEmployeeData($id)
            ,self::employeeSpec($id)
        ],'eEmployeeSpec');
    }
    protected function combineSloEmployeeSpec($slo,$empSol)
    {
        foreach($slo as $id => $value)
        {
            foreach($empSol as $key => $valueEmpl)
            {
                if($value['ID']===$valueEmpl['idSlownik'])
                {
                    $slo[$id]['DEFAULT']='t';
                    unset($empSol[$key]);
                    break;
                }
            }
        }
        return $slo;
    }
    # RETURN CURRENT PROJECT DETAILS
    public function getEmployeeDetails(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int) $id=self::getId();
        $this->Utilities->jsonResponse([
            $this->Model->{'Employee'}->getEmployeeData($id)
            ,self::employeeSpec($id)
        ],'eEmployee');
    }

    public function getModulEmployeesDefaults(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities->jsonResponse(['perm'=>$_SESSION['perm'],'data'=>$this->Model->{'Employee'}->getAll()],'runMain');
    }
    function __destruct(){}
    private function getId(){
        return filter_input(INPUT_GET,"id",FILTER_VALIDATE_INT);
    }
    private function setId(){
        $this->id=filter_input(INPUT_GET,"id",FILTER_VALIDATE_INT);
    }
    private function getFilter(){
        $filter=filter_input(INPUT_GET,'filter');
        if(is_null($filter)){
            return '';
        }
        return $filter;
    }
}