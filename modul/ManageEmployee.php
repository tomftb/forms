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
        $this->Model->{'Allocation'}=new \Allocation_model();
        $this->Model->{'Employee_allocation'}=new \Employee_allocation_model();
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
        $this->Model->{'Employee'}->employeeExists($this->inpArray['Imie'],$this->inpArray['Nazwisko'],0); 

        self::addEmployee();     
        $this->Utilities->jsonResponse('','cModal');
    }
    public function eEmployeeOn(){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'ID',true,1);
        $this->Log->log(0," ID - ".$this->inpArray['ID']); 
        self::checkEmployeeValueLength();
        $this->Model->{'Employee'}->employeeExists($this->inpArray['Imie'],$this->inpArray['Nazwisko'],$this->inpArray['ID']); 
        self::updateEmployee();
        $this->Utilities->jsonResponse('','cModal');          
    }
    protected function setEmployeeAllocation(int $idEmployee=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        // CHECK AVALIABLE DICTIONARY
        $specPost=self::getSpecTabId();
        $this->checkSpecInDb($specPost);
        $this->Model->{'Employee_allocation'}->deleteByIdEmployee($idEmployee);
        foreach($specPost as $a){
            $this->Model->{'Employee_allocation'}->insertByIdEmployee($idEmployee,intval($a,10));
        }
    }
    public function eEmployeeSpecOn(){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'ID',true,1);
        $this->Log->log(0," ID - ".$this->inpArray['ID']); 
        self::setEmployeeAllocation(intval($this->inpArray['ID'],10));
        $this->Utilities->jsonResponse('','cModal');          
    }
    protected function checkSpecInDb($t1){
        /*
         * CHECK EXIST IN DB
         * t1 => POST
         */
        $this->Log->log(0,"[".__METHOD__."]");  
        $specDb=self::getSpec();
        foreach($t1 as $v){
            $this->Log->log(0,"[".__METHOD__."] ID => ".$v); 
            if(!in_array($v,$specDb)){  
                Throw New Exception ("DICTIONARY ID => ".$v." NOT FOUND IN DB",1);
            }         
        }
    }
    private function getSpec(){
        $db=array(); 
        foreach($this->Model->{'Allocation'}->getIdList() as $v){
            array_push($db,$v['id']);
        }
        $this->Log->logMulti(2,$db,__LINE__."::".__METHOD__." db");
        return ($db);
    }
    protected function checkEmployeeValueLength()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $err='';
        $this->inpArray['Imie']=trim($this->inpArray['Imie']);
        $this->inpArray['Nazwisko']=trim($this->inpArray['Nazwisko']);
        if(strlen($this->inpArray['Imie'])<3 || strlen($this->inpArray['Nazwisko'])<3){
            $err.=$this->infoArray['imie_nazwisko'][0]."<br/>";
        }
        if(strlen($this->inpArray['Imie'])>30 || strlen($this->inpArray['Nazwisko'])>30){
             $err.=$this->infoArray['imie_nazwisko'][2]."<br/>";
        }
        if($err){
            Throw New \Exception($err,0);
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
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            $this->Model->{'Employee'}->beginTransaction();
            $this->Model->{'Employee'}->update($this->inpArray['Imie'],$this->inpArray['Nazwisko'],$this->inpArray['Stanowisko'],$this->inpArray['Email'],$this->inpArray['ID']);
            self::setEmployeeAllocation($this->inpArray['ID']);
            $this->Model->{'Employee'}->commit();  
        }
        catch (PDOException $e){
            $this->Model->{'Employee'}->rollback();
            Throw New \Exception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1); 
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
        $this->Utilities->jsonResponse($this->Model->{'Allocation'}->getAbbreviationList(),$this->inpArray['function']);
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
    public function getEmployeeSpec(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int) $id=self::getId();
         $this->Utilities->jsonResponse([
            $this->Model->{'Employee'}->getEmployeeUpperData($id)
            ,$this->Model->{'Employee_allocation'}->getEmployeeAllocation($id)
        ],'eEmployeeSpec');
    }
    # RETURN CURRENT PROJECT DETAILS
    public function getEmployeeDetails(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int) $id=self::getId();
        $this->Utilities->jsonResponse([
                                        $this->Model->{'Employee'}->getEmployeeUpperData($id)
                                        ,$this->Model->{'Employee_allocation'}->getEmployeeAllocation($id)
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