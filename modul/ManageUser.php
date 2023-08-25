<?php
class ManageUser
{
    private $inpArray=array();
    private $actData=array();
    private $accountType='';
    private $Log;
    private $dbLink;
    private ?object $Model;
    
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->dbLink=LoadDb::load();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities=NEW Utilities();
        $this->Model=new \stdClass();
        $this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
        $this->Model->{'Uzytkownik'}=new \Uzytkownik_model();
        $this->Model->{'Slo_rola'}=new \Slo_rola_model();
        $this->Model->{'App_account_type'}=new \App_account_type_model();
    }
    public function cUser(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->inpArray['ID']=0;
        $this->actData['haslo']='';
        // self::checkInputFields(); /* TO DO */
        self::checkUserValueLength();
        self::checkUserData();
        self::addUser();
        $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>self::getUsers()],'cModal');
    }
    protected function setActSessionPermRole(){
        $this->Log->log(0,"[".__METHOD__."]");
        if($_SESSION['userid']!==$this->inpArray['ID']) { return ''; }        
        $_SESSION['perm']=array();
        (int) $id_rola=intval($this->Model->{'Uzytkownik'}->getUserIdRole($this->inpArray['ID']),10);
        foreach(array_merge($this->Model->{'Uprawnienia'}->getUserUniqePerm($this->inpArray['ID'],$id_rola),$this->Model->{'Slo_rola'}->getRolePermissions($id_rola)) as $v){
            array_push($_SESSION['perm'],$v['SKROT']);
        }
    }
    public function eUserOn(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        //$this->Log->logMulti(2,$this->inpArray,__METHOD__."::POST");
        // self::checkInputFields(); /* TO DO */
        self::checkUserValueLength();
        self::sqlGetUserFullData();
        self::checkUserData();
        self::updateUser();    
        $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>self::getUsers()],'cModal');
    }
    private function checkUserData(){
        $this->Model->{'Uzytkownik'}->checkUserExists(intval($this->inpArray['ID'],10),trim($this->inpArray['Login']),trim($this->inpArray['Imie']),trim($this->inpArray['Nazwisko']));
        self::setAccountType();
        self::checkUserAccountPassword();   
    }
    private function updateUser(){
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            $this->Model->{'Uzytkownik'}->beginTransaction(); //PHP 5.1 and new
            $this->Model->{'Uzytkownik'}->update($this->inpArray,self::setIdRoleParm());
            self::setPermissions();
            self::setActSessionPermRole();
            $this->Model->{'Uzytkownik'}->commit();  
        }
        catch (PDOException $e){
            $this->Model->{'Uzytkownik'}->rollback();
            Throw New Exception("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1);
        }
    }

    private function setAccountType(){
        $this->Log->log(0,"[".__METHOD__."]");
        foreach(explode('|',$this->inpArray['accounttype']) as $account){
            $this->accountType=$this->Model->{'App_account_type'}->getAccountNameById(intval($account,10));
            break;
        }
    }
    private function checkUserAccountPassword(){
        $this->Log->log(0,"ACCOUNT TYPE => ".$this->accountType);
        switch($this->accountType){
            case 'Active Directory':
                /* NOTHING TO DO => SET OLD PASSWORD */
                $this->inpArray['Haslo']=$this->actData['haslo'];
                break;
            case 'Local':
                self::setUserPassword(); 
                break;
            case 'API':
                $this->Log->log(0,"API");
                break;
            case 'Autos Active Directory':
                $this->Log->log(0,"Autos Active Directory");
                $this->inpArray['Haslo']=$this->actData['haslo'];
                break;
            default:
                throw new Exception(' ACCOUNT TYPE `'.$this->accountType.'` NOT OPERATED',1);
        }
    }
    private function setUserPassword(){
        if(strcmp($this->inpArray['Haslo'],'')===0 && strcmp($this->actData['haslo'],'')!==0){
            /* USE OLD PASSWORD */
            $this->inpArray['Haslo']=$this->actData['haslo'];
        }
        else{
            self::checkUserPassword();
            self::setPassword();
        }
    }
    private function checkUserPassword(){
        $this->Log->log(0,"[".__METHOD__."]");
        /* TRIM */
        $this->Log->log(0,$this->inpArray['Haslo']);
        $this->inpArray['Haslo']=trim($this->inpArray['Haslo']);
        /* LENGTH */
        $err=self::checkPasswordLength();
        /* PREG_MATCH = TWO DIGIT */
        if(!preg_match('/.*\d+.*/', $this->inpArray['Haslo'])){
            $err.='<br/>W haśle musi się znależć co najmniej jedna cyfra';
        }
        if(!preg_match('/.*\D+.*\D+.*/', $this->inpArray['Haslo'])){
            $err.='<br/>W haśle muszą się znależć co najmniej dwie litery';
        }
        if(!preg_match('/[!@#$%^&*()_+]+/', $this->inpArray['Haslo'])){
            $err.='<br/>W haśle musi się znależć co najmniej jeden znak specjalny !@#$%^&*()_+';
        }
        if($err){ 
            Throw New Exception($err,0);    
        }
    }
    private function checkPasswordLength(){
        $length = strlen($this->inpArray['Haslo']);
        if($length<6){
                    return 'za krótkie hasło';
        }
        if($length>30){
            return 'za długie hasło';
        }
        return ''; 
    }
    private function setPassword(){
        $this->Log->log(0,"[".__METHOD__."] PASSWORD_BCRYPT ALGORITHM");
        $this->inpArray['Haslo']=password_hash($this->inpArray['Haslo'], PASSWORD_BCRYPT);
        //$this->Log->log(0,$this->inpArray['Haslo']);
        $this->Log->log(0,"LENGTH => ".mb_strlen($this->inpArray['Haslo']));
    }
    protected function setUserPerm($permArray,$userId)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        if($this->getError()) { return '';}
        foreach($permArray as $value)
        {
            //echo $value[0].' - '.$value[1];
            if($value[2]>0){
                self::sqlAddUserPerm($userId,$value[0]);
            }
            else{
                $this->Model->{'Uprawnienia'}->removeUserPermission($userId,$value[0]);
            }
        }
    }
    public function uPerm(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        self::setPermissions();
        self::setActSessionPermRole();
        $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>self::getUsers()],'cModal');
    }
    private function setPermissions(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Uprawnienia'}->removeUserAllPermission($this->inpArray['ID']);
        foreach($this->utilities->getArrayKeyValue('ID',$this->utilities->getCboxFromInput($this->inpArray)) as $perm){
             $this->Model->{'Uprawnienia'}->add($this->inpArray['ID'],$perm); 
        }
    }
    protected function checkExistSloPerm($permTab)
    {
       // CHECK SLO IS AVALIABLE
        foreach($permTab as $value)
        {
            if(!$this->checkExistInDb('v_slo_upr','ID=?',$value[0]))
            { 
                $value[1]=preg_replace('/_/', ' ', $value[1]);
                $this->response->setError(1,"[".$value[1]."] PERMISSION DICTIONARY WAS DELETED");
            }
        }
    }
    protected function checkUserValueLength(){
        $this->Log->log(0,"[".__METHOD__."]");
        $check[0]=$this->utilities->checkValueLength($this->inpArray['Imie'],'polu imię',3,30);
        $check[1]=$this->utilities->checkValueLength($this->inpArray['Nazwisko'],'polu nazwisko',3,30);
        $check[2]=$this->utilities->checkValueLength($this->inpArray['Login'],'polu login',3,30);
        
        if($check[0]!=='' || $check[1]!=='' || $check[2]!==''){
            Throw New Exception($check[0].$check[1].$check[2],0);
        }
    }
    protected function addUser(){
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            $this->Model->{'Uzytkownik'}->beginTransaction();
            $this->Model->{'Uzytkownik'}->add($this->inpArray,self::setIdRoleParm());
            $this->inpArray['ID']=$this->Model->{'Uzytkownik'}->getLastInsertedUserId();
            self::setPermissions();
            $this->Model->{'Uzytkownik'}->commit();
        }
        catch (PDOException $e){
            $this->Model->{'Uzytkownik'}->rollback();
            Throw New Eception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1);
        }   
    }
    private function setIdRoleParm(){
        if(!array_key_exists('Rola', $this->inpArray)){
            Throw New Eception ("[".__METHOD__."] Key `Rola` not exists in this->inpArray!",1);
        }
        return intval($this->inpArray['Rola'],10)===0 ? [NULL,'NULL'] : [$this->inpArray['Rola'],'INT'];

    }
    protected function sqlAddUserPerm($userId,$value)
    {
        $this->Log->log(2,"[".__METHOD__."] USER ID => ".$userId.", VALUE => ".$value);
        /* CHECK IS EXIST */ 
        if(!is_array($this->dbLink->squery("select * FROM `v_uzyt_i_upr` WHERE `idUzytkownik`=".$userId." AND `idUprawnienie`=".$value,[],'FETCH_ASSOC','fetch'))){
            /* NOT EXIST => INSERT */
            $this->dbLink->query('INSERT INTO `uzyt_i_upr` (`id_uzytkownik`,`id_uprawnienie`) VALUES ('.$userId.','.$value.')'); 
        }
    }
    protected function sqlGetUserFullData(){
        $this->Log->log(0,"[".__METHOD__."]");
        $user=$this->dbLink->squery("select * FROM `uzytkownik` WHERE `id`=:i",[':i'=>[$this->inpArray['ID'],'INT']]); 
        if(!is_array($user)){
            throw new Exception(' USER `'.$this->inpArray['ID'].'` NOT EXIST IN DATABASE', 1);
        }
        $this->actData=$user[0];
        $this->Log->logMulti(0,$this->actData);
    }
    # DELETED PROJECT IN DB
    public function dUser(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST); 
        $this->utilities->keyExist($this->inpArray,'ID');
        $this->utilities->isEmptyKeyValue($this->inpArray,'ID',true,1);
        /* TO DO => CHECK INPUT */
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            $this->dbLink->query("UPDATE `uzytkownik` SET `wsk_u`='1' WHERE `id`=:id",[':id'=>[$this->inpArray['ID'],'INT']]); 
            $this->dbLink->commit();  
        }
        catch (PDOException $e){
            $this->dbLink->rollback();
            Throw New Exception("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1);
        }
        $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>self::getUsers()],'cModal');
    }
    public function getUsersLike(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->responseType='GET';
        $f=htmlentities(nl2br(filter_input(INPUT_GET,'filter')), ENT_QUOTES,'UTF-8',FALSE);
        $this->Log->log(0,"[".__METHOD__."] filter => ".$f);
        $this->Log->logMulti(0,filter_input_array(INPUT_GET));
        $select="SELECT u.`id` as 'ID',u.`imie` as 'Imie',u.`nazwisko` as 'Nazwisko',u.`login` as 'Login',u.`email` as 'Email',a.`name` as 'TypKonta', (SELECT r.`NAZWA` FROM `slo_rola` as r WHERE  u.`id_rola`=r.`id` ) as `Rola` FROM `uzytkownik` u, `app_account_type` as a WHERE u.`typ`=a.`id`  AND u.`wsk_u`=:wsk_u AND";
        $where='';
        $idWhere='';
        $query_data=array();
        (array)$users=[];
        
        if(is_numeric($f)){
            $this->Log->log(0,"[".__METHOD__."] filter is numeric ");
            $f_int=intval($f,10);
            $query_data[':id']=array($f_int,'INT');
            $idWhere="u.`id` LIKE (:id) OR ";
        }
        else{
            $this->Log->log(0,"[".__METHOD__."] filter not numeric ");
        }
        $where=" (".$idWhere." u.`imie` LIKE :filtr OR u.`nazwisko` LIKE :filtr OR u.`email` LIKE :filtr OR a.`name` LIKE :filtr) ORDER BY u.`id` ASC";
        self::setGetWsk('u');
        $query_data[':wsk_u']=array($this->inpArray['u'],'STR');
        $query_data[':filtr']=array('%'.$f.'%','STR');
        //echo "test error<br/>";
        try{
            $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>$this->dbLink->squery($select.$where,$query_data)],'sAll'); 
	}
	catch (PDOException $e){
            Throw New Exception("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1);
	}
    }
    private function getUsers(){
        return $this->dbLink->squery("SELECT u.`id` as 'ID',u.`imie` as 'Imie',u.`nazwisko` as 'Nazwisko',u.`login` as 'Login',u.`email` as 'Email',a.`name` as 'TypKonta', (SELECT r.`NAZWA` FROM `slo_rola` as r WHERE  u.`id_rola`=r.`id` ) as `Rola` FROM `uzytkownik` u, `app_account_type` as a WHERE u.`typ`=a.`id`  AND u.`wsk_u`='0' ORDER BY u.Id");   
    }
    private function setGetWsk($wsk='u'){
        $this->inpArray[$wsk]=filter_input(INPUT_GET,$wsk);
        if($this->inpArray[$wsk]===null || $this->inpArray[$wsk]===false){
            $this->Log->log(0,"[".__METHOD__."] wsk_".$wsk." NOT EXIST, SET DEFAULT 0");
            $this->inpArray[$wsk]='0';
        }
    }
    public function getUserDel(){
        $this->Log->log(0,"[".__METHOD__."]");    
        $this->utilities->setGet('id',$this->inpArray);
        /* TO DO GET USER DALA WITH DELETE SLO */
        $this->utilities->jsonResponse($this->inpArray['id'],'dUser');
    }
    # RETURN ALL NOT DELETED DICTIONARY and other FROM DB
    public function getSlo($tableToSelect,$order='ID'){
        $this->query('SELECT * FROM '.$tableToSelect.' WHERE 1=? ORDER BY '.$order.' ASC ',1);
        $this->actData=$this->queryReturnValue();
    }
    # RETURN ALL EMPLOYEE SPEC DICTIONARY and other FROM DB
    public function getUserPerm(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->setGet('id',$this->inpArray);
        array_push($this->actData,$this->inpArray['id']);

        array_push($this->actData,$this->Model->{'Uprawnienia'}->getUserPermissionsListWithDefault($this->inpArray['id']));
        $this->utilities->jsonResponse($this->actData,'uPermOff');
    }
    protected function combineSlo($slo,$sloKey,$usrSol,$sloUserKey){
        $this->Log->log(0,"[".__METHOD__."]");
        // $sloKey = ID
        // $sloUserKey = idUprawnienie
        foreach($slo as $id => $value){
            foreach($usrSol as $key => $valueEmpl){
                if($value[$sloKey]===$valueEmpl[$sloUserKey]){
                    $slo[$id]['DEFAULT']='t';
                    unset($usrSol[$key]);
                    break;
                }
            }
        }
        return $slo;
    }
    # RETURN CURRENT PROJECT DETAILS
    public function getUserDetails(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->setGet('id',$this->inpArray);
        self::getUserAllDetails(); 
        $this->utilities->jsonResponse($this->actData,'eUser');
    }
    private function getUserAllDetails(){
        try{
            /* GET USER DATA */
            self::sqlGetUserData();
            /* GET USER PERM */
            $this->actData['perm']=$this->Model->{'Uprawnienia'}->getUserPermissionsListWithDefault($this->inpArray['id']);
            /* GET USER ROLE */
            self::getUserRole();
            /* GET ACCOUNT TYPE */
            self::getAccountType();
            $this->Log->logMulti(2,$this->actData,__LINE__."::".__METHOD__." data");
        }
        catch (PDOException $e){
            Throw New Exception ("[".__METHOD__."] Wystąpił błąd zapytania bazy danych: ".$e->getMessage(),1); 
        }  
    }
    private function sqlGetUserdata(){
        $this->Log->log(0,"[".__METHOD__."] USER ID => ".$this->inpArray['id']);
        $user=$this->dbLink->squery("SELECT * FROM `v_all_user` WHERE `id`=:i",[':i'=>[$this->inpArray['id'],'INT']]);
        $count=count($user);
        if($count!==1){
            Throw New Exception ('Użytkownik o ID '.$this->inpArray['id'].' został usunięty ',0);
        }
        if($count>1){
            Throw New Exception ('There is more than 1 ('.$count.') user with ID '.$this->inpArray['id'],1);
        }
        $this->actData['user']=$user[0];
    }
    private function getAccountType(){
        $this->Log->log(0,"[".__METHOD__."] TYP KONTA => ".$this->actData['user']['TypKontaValue']);
        $noUserAccount=$this->dbLink->squery("SELECT a.`id`,a.`name` FROM `app_account_type` a WHERE a.`wsk_u`='0' AND a.`id`!=".$this->actData['user']['TypKontaValue']." ORDER BY a.`id`");
        $this->Log->logMulti(2,$noUserAccount,'noUserAccount');
        $account=$this->dbLink->squery("SELECT a.`id`,a.`name` FROM `app_account_type` a WHERE a.`id`=".$this->actData['user']['TypKontaValue']);
        $this->actData['accounttype']=array_merge($account,$noUserAccount);
    }
    public function getUserRole(){
        $this->Log->log(0,"[".__METHOD__."] ID USER ROLE => ".$this->actData['user']['IdRola']);
        $userRoleSlo=[];
        $emptArr=[['ID'=>'0','NAZWA'=>'','DEFAULT'=>'t']];
        /* GET ALL ROLE */ 
        $allRole=$this->dbLink->squery("SELECT * FROM `v_slo_rola`");
        if($this->actData['user']['IdRola']!='')
        {
            // COMBINE USER DICT
            $emptArr=array('ID'=>'0','NAZWA'=>''); 
            $userRole=$this->dbLink->squery('SELECT *,"t" AS "DEFAULT" FROM `v_slo_rola` WHERE `ID`=:i',[':i'=>[$this->actData['user']['IdRola'],'INT']]);
            array_push($userRole,$emptArr);
            foreach($allRole as $key => $value){
                if($value['ID']===$userRole[0]['ID']){
                    unset($allRole[$key]);
                    break;
                }
            }
            $userRoleSlo=array_merge($userRole,$allRole);
        }
        else{
            $userRoleSlo=array_merge($emptArr,$allRole);
        }
       $this->actData['role']=$userRoleSlo;
    }
    public function getNewUserSlo(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->jsonResponse([
            'perm'=>$this->Model->{'Uprawnienia'}->getShortList()
            ,'accounttype'=>$this->Model->{'App_account_type'}->getNotDeletedShortList()
            ,'role'=>array_merge([0=>['ID'=>'0','NAZWA'=>'','DEFAULT'=>'t']],$this->Model->{'Slo_rola'}->getNotDeletedShortList())
           ],'cUser');
    }
    public function getModulUsersDefaults(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->jsonResponse(['perm'=>$_SESSION['perm'],'users'=>self::getUsers()],'runMain');  
    }
    function __destruct(){}
}