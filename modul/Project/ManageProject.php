<?php
/*
 * RECEIVER
 */



interface ManageProjectCommand
{
    public function pDelete();
    public function pPDF();
    public function pGenDoc();
    public function getProjectDefaultValues();
    public function pCreate();
    public function pDetails();
    public function pEmail();
    public function getprojectslike();
    public function pClose();
    public function getProjectCloseSlo();
}
final class ManageProject implements ManageProjectCommand
{
    private $dbLink;
    private $Utilities;
    private $Log;
    private $stageDbId=0;
    private $projectStageDb=[];
    private $stageValueDbId=0;
    private $idProject=0;
    private $input=[];
    private $date="1970-01-01 00:00:01";
    private $RA='127.0.0.1';
    private ?object $Model;
    private $responseType='POST';
    private $inpArray=array();
    private $inpArrayDok=array();
    private $lastProjectData=array();
    private $projectDiff=array();
    private $filter='';
    private $mail='';
    private $valueToReturn=null;
    private $projectDocList='';

    private $projPrac=array();
    private $projectChange=0;
    private $notify='n';
    private $modul=array();
    private $taskPerm= ['perm'=>'','type'=>''];
    private $projectParm=array(
                        'dir'=>array(
                            'old'=>'',
                            'new'=>'',
                            'change'=>false,
                            'field'=>array(
                                'klient'=>'',
                                'temat_umowy'=>'',
                                'typ_umowy'=>'',
                                'd-term_realizacji'=>''
                            )
                        ),
                        'size'=>array(
                            'old'=>'',
                            'old_size'=>'',
                            'new'=>'',
                            'new_size'=>'',
                            'change'=>false,
                            'field'=>array(
                                'r_dane'=>'',
                                'j_dane'=>''
                                )
                        ),
                        'quota'=>array(
                            'quota'=>'',
                            'old_quota'=>'',
                            'change'=>false,
                            'field'=>array(
                                'quota'=>''
                            )
                        ),
                        'size_quota'=>array(
                            'new_size_quota'=>'',
                            'old_size_quota'=>''
                        )
            );
    private $projectParameters=array();
    private $infoArray=array
            (
                "numer_umowy"=>array
                (
                    "Nie podano numeru umowy",
                    "Istnieje już projekt o podanym numerze umowy"
                ),
                "temat_umowy"=>array
                (
                    "Nie podano tematu projektu",
                    "Istnieje już projekt o podanym temacie"
                ),
                "id_projekt"=>array
                (
                    "Musisz wskazać co najmniej jedną osobę do projektu",
                    "Pracownik jest już przypisany do projektu"
                ),
                "input"=>array
                (
                    "Nie uzupełniono pola.",
                    "Wprowadzona wartość jest za długa",
                    "Wprowadzona wartość jest za krótka"
                ),
                "err_mail"=>array
                (
                    "Projekt został utworzony/zaktualizowany.<br/>Niestety pojawił się błąd przy próbie wysłania powiadomienia e-mail.<br/>Zamknij to okno przyciskiem Anuluj.",
                    "Pojawiły się błąd przy próbie wysłania powiadomienia e-mail.<br/> Zamknij to okno przyciskiem Anuluj i spróbuj póżniej."
                )
            );
    
    const zm="<span style=\"font-weight:bold;color:#ff0000\">(ZMIANA)</span> &rarr;";
    const spanBlack="<span style=\"font-weight:bold;color:#000000\">";
    const sGreen="<span style=\"font-weight:bold;color:#008000\">";
    const sEnd="</span>";
    
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->Log->log(0,"[".__METHOD__."]");
        $this->notify='n';
        $this->modul['DOCUMENT']=NEW ManageProjectDocument();
        $this->modul['REPORT']=NEW ManageProjectReport();
        $this->modul['FILE']=NEW ManageProjectReport();
        $this->utilities=NEW Utilities();
        $this->response=NEW Response('Project');
        $this->dbLink=LoadDb::load();
        $this->date=date("Y-m-d H:i:s");
        $this->RA=filter_input(INPUT_SERVER,'REMOTE_ADDR');

        $this->Model=new \stdClass();
        $this->Model->{'Project'}=new \Project_model();
        $this->Model->{'Project_document'}=new \Project_document_model();
        $this->Model->{'Project_glossary_type'}=new \Project_glossary_type_model();
        $this->Model->{'Project_glossary_document'}=new \Project_glossary_document_model();
        $this->Model->{'Project_glossary_implementation'}=new \Project_glossary_implementation_model();
        $this->Model->{'Project_glossary_system'}=new \Project_glossary_system_model();
        $this->Model->{'Employee_allocation'}= new \Employee_allocation_model();
        $this->Model->{'Employee_project'}= new \Employee_project_model();
        $this->Model->{'Parametry'}= new \Parametry_model();
        $this->Model->{'Dictionary_measurement_units'}=new \Dictionary_measurement_units_model();
        $this->Model->{'Slo'}=new \Slo_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    private function setInput(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->getPost(true,true);
        if($this->utilities->getStatus()==='0'){
            $this->inpArray=$this->utilities->getData();
        }
        else{
            Throw New \Exception ($this->utilities->getInfo(),1);
        }
        
        $this->inpArrayDok=$this->utilities->getDoc();
        $this->Log->log(0,"[".__METHOD__."] inpArray:");
        $this->Log->logMulti(0,$this->inpArray,"L::".__LINE__."::".__METHOD__);
        $this->Log->log(0,"[".__METHOD__."] inpArrayDok:");
        $this->Log->logMulti(0,$this->inpArrayDok,"L::".__LINE__."::".__METHOD__);
    }
    public function pPDF(){
        $this->Log->log(0,"[".__METHOD__."]");
        $id_project=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->utilities->isValueEmpty($id_project);
        $projectDetails=$this->Model->{'Project'}->getProjectDataForPdf($id_project);   
        $projectDoc=$this->Model->{'Project_document'}->getNamesByIdProject($id_project);   
        $projectTeam=$this->Model->{'Employee_project'}->getTeamPdfInput($id_project); 
        $PDF = new \createPdf($projectDetails,$projectDoc,$projectTeam,APP_ROOT,UPLOAD_PROJECT_PDF_DIR);
        $this->utilities->jsonResponse($PDF->getPdf(),'downloadProjectPdf');
    }
    public function pGenDoc(){
        $this->Log->log(0,"[".__METHOD__."]");
        $id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->utilities->isValueEmpty($id);
        $sql[':id']=[$id,'INT'];
        $projectDetails=$this->dbLink->squery('SELECT `create_date`,`create_user_full_name`,`create_user_email`,`rodzaj_umowy`,`numer_umowy`,`temat_umowy`,`klient`,`kier_grupy`,`term_realizacji` as \'d-term_realizacji\',`harm_data`,`koniec_proj` as \'d-koniec_proj\',`nadzor`,`kier_osr`,`technolog`,`klient`,`typ` as \'typ_umowy\',`system`,`r_dane`,`j_dane`,`quota` FROM `project` WHERE `id`=:id AND `wsk_u`=0 ',$sql)[0];
        $doc = new \WordDoc\createDoc($projectDetails,$_FILES,'Project'.$this->utilities->getData(),'.docx',UPLOAD_PROJECT_REPORT_DOC_DIR,$this->Log);
        $doc->createProjectReport();
        $this->utilities->jsonResponse($doc->getDocName(),'downloadProjectDoc');
    }
    private function getIdDataPost(&$v)
    {
        /*
         * $v => value
         */
        $tmp_data=explode('|',$v);
        $id=$tmp_data[0];
        $value='';
        if(count($tmp_data)>0){
            // remove head
            array_shift($tmp_data);
            $value = implode (" ",$tmp_data);
        }
        $v=array($id,$value);
    }
    private function getIdDataProjectPost(){
         $this->Log->log(0,"[".__METHOD__."]");
        /*
         * GET AND EXPLODE ID WITH DATA ON |
         */
        $this->Log->log(0,"[".__METHOD__."]");
        self::getIdDataPost($this->inpArray['typ_umowy']);
        //$this->Log->logMulti(0,$this->inpArray['typ_umowy'],__METHOD__);
        self::getIdDataPost($this->inpArray['system_umowy']);
        self::getIdDataPost($this->inpArray['kier_grupy']);
        self::getIdDataPost($this->inpArray['gl_tech']);
        self::getIdDataPost($this->inpArray['gl_kier']);
        self::getIdDataPost($this->inpArray['nadzor']);
        $this->Log->logMulti(0,$this->inpArray);
        
        if(!array_key_exists('rodzaj_umowy', $this->inpArray)){
            Throw New Exception('Wskaż punkt `Do realizacji`',0);
        }
        //die();
        $this->inpArray['rodzaj_umowy']=explode('|',$this->inpArray['rodzaj_umowy']);
    }
    public function pCreate(){
        $this->Log->log(0,"[".__METHOD__."]");
        self::setInput();
        $this->response->setType('POST');
        self::isEmpty('Numer',$this->inpArray['numer_umowy']);
        self::isEmpty('Temat',$this->inpArray['temat_umowy']);
        $this->Model->{'Project'}->exists('numer_umowy',$this->inpArray['numer_umowy'],$this->infoArray['numer_umowy'][1]);
        $this->Model->{'Project'}->exists('temat_umowy',$this->inpArray['temat_umowy'],$this->infoArray['temat_umowy'][1]);
        self::getIdDataProjectPost();
        self::setProjectDir();
        self::setQuotaField($this->inpArray['quota']);
        self::setProjectParm($this->inpArray);
        self::setProjectSizeQuota();
        self::setProjPrac();
        try{
            $this->inpArray['id'] = random_int(1000000000, 1099511627776);
            $this->Model->{'Project'}->beginTransaction(); //PHP 5.1 and new
            $this->Model->{'Project'}->insert($this->inpArray);
            /*
            * SET CHANGE
            */
            $this->projectChange=1;
            
            /*
            * SET PROEJCT DOCUMENTS
            */
            self::parseResponse($this->modul['DOCUMENT']->addDok($this->inpArray['id'],$this->inpArrayDok));
            /* Must BEFORE COMMIT, OTHERWISE LAST ID = 0 */
            $this->Model->{'Project'}->commit();  //PHP 5 and new
        }
	catch (\PDOException $e){
            $this->Model->{'Project'}->rollback(); 
            throw New \Exception("DATABASE ERROR: ".$e->getMessage(),1); 
	}
        $this->notify='y';
        self::sendNotify(
                        "Zgłoszenie na utworzenie Projektu :: ".$this->inpArray['klient'].', '.$this->inpArray['temat_umowy'].', '.$this->inpArray['typ_umowy'][1],
                        'Zarejestrowano zgłoszenie na utworzenie nowego projektu o specyfikacji:',
                                $this->inpArray);
        $this->utilities->jsonResponse('','cModal');
    }
    private function setupInputValue($field='')
    {
        /*
         * GET SPECIFICATION FIELD VALUE
         */
        $this->Log->log(0,"[".__METHOD__."] field => ".$field);
        if(is_array($this->inpArray[$field]))
        //if(is_array($this->inpArray['system_umowy']))
        {
            $this->Log->logMulti(1,$this->inpArray[$field],__METHOD__);
            //$this->Log->logMulti(1,$this->inpArray['system_umowy'],__METHOD__);
            if(!array_key_exists(1, $this->inpArray[$field]))
            //if(!array_key_exists(1, $this->inpArray['system_umowy']))
            {
                $this->response->setError(1,"ARRAY KEY => 1 NOT EXIST IN inpArray[".$field."]");
                return '';
            } 
            return ($this->inpArray[$field][1]);
            //return ($this->inpArray['system_umowy'][1]);
        }
        
        return ($this->inpArray[$field]);
        //return ($this->inpArray['system_umowy']);
    }
    public function pEmail(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->utilities->validateKey($this->inpArray,'id',true,1);
        $data=$this->Model->{'Project'}->getProjectForEmail($this->inpArray['id']);
        self::setProjectEmailFields($data);
        $this->Log->logMulti(0,$data,__METHOD__);
        try{
            $this->mail=NEW Email();
            $this->mail->sendMail(
                                $data['subject'],
                                self::projectBodyMailTemplate($data['subject'],$data),
                                self::getRecipient(),
                                $this->infoArray['err_mail'][1],
                                true
            );
        }
        catch(\Exception $e){
            $this->Log->logMulti(0,$e->getMessage());
            Throw New \Exception($this->infoArray['err_mail'][1],0);
        } 
        $this->utilities->jsonResponse('','cModal','POST'); 
    }
    private function getProjectDoc(){
        $this->Log->log(0,"[".__METHOD__."]");
        $tmp=''; 
        foreach($this->Model->{'Project_document'}->getNamesByIdProject($this->inpArray['id']) as $v){
            $tmp.="-&nbsp;".$v['name']."<br/>";
        }
        return $tmp;
    }
    private function getRecipient()
    {
        $patt=array();
        foreach($this->inpArray as $k => $v)
        {
            if(preg_match('/^e(\d)+$/i',$k) && (trim($v)!==''))
            {
                array_push($patt,array($v,''));
            }
        }
        $this->Log->logMulti(0,$patt,__METHOD__);
        return $patt;
    }
    private function setProjectEmailFields(&$d)
    {
        $d['size']=$d['r_dane'].$d['j_dane'];
        $d['s_quota']=intval($d['quota'],10)*intval($d['r_dane'],10);
        $d['applicant']=$d['create_user_full_name']."(".$d['create_user_email'].")";
        $d['dir']=self::setDirName($d['klient'],$d['temat_umowy'],$d['typ_umowy'],$d['d-term_realizacji']);
        $d['doc']=self::getProjectDoc();
        $d['users']=$d['nadzor'].", ".$d['kier_grupy'].", ".$d['technolog'].".";
        $d['subject']="Powtórne powiadomienie o założeniu Projektu :: ".$d['klient'].', '.$d['temat_umowy'].', '.$d['typ_umowy'];
    }
    private function setProjPrac()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->logMulti(0,$this->inpArray,__LINE__."::".__METHOD__." inpArray"); 
        array_push($this->projPrac,
                array($this->inpArray['nadzor'][0],$this->inpArray['nadzor'][1]),
                array($this->inpArray['kier_grupy'][0],$this->inpArray['kier_grupy'][1]),
                array($this->inpArray['gl_tech'][0],$this->inpArray['gl_tech'][1]),
                array($this->inpArray['gl_kier'][0],$this->inpArray['gl_kier'][1]));   
    
        //$this->Log->logMulti(0,$this->projPrac,__METHOD__." projPrac"); 
    }
    private function setPostProjPac()
    {
        $emailAddr=array();
        //array_push($this->projPrac,
        foreach($this->inpArray as $key => $value)
        {
            if(substr($key,0,13)==='emailAccount-')
            {
                array_push($emailAddr,array($value,$value));
            }
        }
        $this->Log->logMulti(0,$emailAddr,__METHOD__." emailAddr"); 
        return $emailAddr;
    }
    private function getProjPracList()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $projPracList=$this->inpArray['nadzor'][1].",".$this->inpArray['kier_grupy'][1].",".$this->inpArray['gl_tech'][1].".";
        $this->Log->log(1,"[".__METHOD__."] Project workers list => ".$projPracList);
        return($projPracList);
    }
    private function cNewProjRecMail($admin=0)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $recEmail=[];
        self::getAdminEmail($admin,$recEmail);
        $pracEmail=array();
        $this->Log->logMulti(1,$this->projPrac,__METHOD__." projPrac");
        foreach($this->projPrac as $value)
        {
            $sql=[
                    ':id'=>[$value[0],'INT']
            ];
            foreach($this->dbLink->squery("SELECT `Email` FROM `employee` WHERE id=:id",$sql) as $v){
                //$pracEmail=array($v['Email'],$value[1]);
                array_push($recEmail,array($v['Email'],$value[1]));
            }
            //$pracEmail=;
            //if(count($pracEmail)){
               // $pracEmail=array($pracEmail[0]['Email'],$value[1]);
              //  array_push($recEmail,$pracEmail);
           // }
        }
        $this->Log->log(0,"[".__METHOD__."] employees EMAILS:");
        $this->Log->logMulti(1,$recEmail);
        return ($recEmail);
    }
    private function getAdminEmail($admin,&$recEmail=[]){
        $this->Log->log(0,"[".__METHOD__."] ");
        if(!$admin){ return false; }
        $this->Log->log(0,"[".__METHOD__."] ADMINS:");
        foreach(explode(';',$this->Model->{'Parametry'}->getParmViaShortcut('PROJECT_ADMIN_MAIL_RECIPIENT')) as $user){
            $this->Log->log(0,"[".__METHOD__."] user - ".$user);
            if(trim($user)!==''){
                array_push($recEmail,array($user,'Admin'));
            }
        }
    }
    private function cNewProjSubjectMail($head){
        return('Zgłoszenie na utworzenie udziału dla Projektu :: '.$head);
    }
    private function cRepeatInfoSubjectMail($head){
        return('Powtórne powiadomienie o utworzonym udziale dla Projektu :: '.$head);
    }
    private function projectBodyMailTemplate($s,$d){
        /*
         * s => subject
         * d => data
         */
        $mailBody="<link href=\"http://fonts.googleapis.com/css?family=Lato:300,400,700&amp;subset=latin,latin-ext\" rel=\"stylesheet\" type=\"text/css\">";
        $mailBody.="<style type=\"text/css\"> table.lato { font-family: 'Lato', Arial,monospace; font-weight:normal;font-size:14px; }p.lato { font-family: 'Lato', Arial,monospace; font-weight:normal;font-size:16px; } </style>";
        $mailBody.="<p class=\"lato\">".$s."</p>";
        $mailBody.="<table class=\"lato\" style=\"border:0px;border-collapse: collapse;\">";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Numer</p></td><td>-&nbsp;".$d['numer_umowy']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Klient</p></td><td>-&nbsp;".$d['klient']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Temat</p></td><td>-&nbsp;".$d['temat_umowy']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Typ</p></td><td>-&nbsp;".$d['typ_umowy']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\"><br/>Rozmiar pliku bazowego</p></td><td><br/>-&nbsp;".$d['size']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">*Mnożnik quota</p></td><td>-&nbsp;".$d['quota']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Sugerowana quota</p></td><td>-&nbsp;".$d['s_quota']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Przypisani użytkownicy</p></td><td>-&nbsp;".$d['users']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\"></br>Zgłaszający</p></td><td><br/>-&nbsp;".$d['applicant']."</td></tr>";	
        $mailBody.="<tr><td><p style=\"margin:1px;\"><br/>*Katalog</p></td><td><br/>-&nbsp;".$d['dir']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">*System</p></td><td>-&nbsp;".$d['system']."</td></tr>";
        $mailBody.="<tr><td style=\"vertical-align: top;\" valign=\"top\"><p style=\"margin:1px;\">*Termin realizacji</p></td><td>-&nbsp;".self::sGreen."START".self::sEnd.": ".$d['d-term_realizacji']."<br/>-&nbsp;".self::sGreen."KONIEC".self::sEnd.": ".$d['d-koniec_proj']."</td></tr>";
        $mailBody.="<tr><td style=\"vertical-align: top;\" valign=\"top\"><p style=\"margin:1px;\">*Powiązane dokumenty</p></td><td>".$d['doc']."</td></tr>";
        $mailBody.="</table>";
        $this->Log->log(0,$mailBody);
        return ($mailBody);
    }
    private function parseLastProjectData()
    {
        if(count($this->lastProjectData)===0) { return false;}
        $this->Log->log(1,"[".__METHOD__."][POST]");
        $this->Log->logMulti(1,$this->inpArray,__METHOD__);
        $this->Log->log(1,"[".__METHOD__."][DB]");
        $this->Log->logMulti(1,$this->lastProjectData,__METHOD__);
        $this->projectDiff = array_diff($this->inpArray, $this->lastProjectData);
        $this->Log->log(1,"[".__METHOD__."][POST<->DB]");
        $this->Log->logMulti(1,$this->projectDiff,__METHOD__);
        $this->projectChange=count($this->projectDiff);
        $this->Log->log(0,"[".__METHOD__."][POST<->DB] count diff => ".$this->projectChange);
    }
    public function pEdit(){
        $this->Log->log(0,"[".__METHOD__."]");
        self::setInput();
        $this->utilities->keyExist($this->inpArray,'id');
        $this->utilities->isEmptyKeyValue($this->inpArray,'id',true,0);
        $this->utilities->keyExist($this->inpArray,'numer_umowy');
        $this->utilities->isEmptyKeyValue($this->inpArray,'numer_umowy',true,0);
        $this->utilities->keyExist($this->inpArray,'temat_umowy');
        $this->utilities->isEmptyKeyValue($this->inpArray,'temat_umowy',true,0);
        $this->inpArray['numer_umowy']=trim($this->inpArray['numer_umowy']);
        $this->inpArray['temat_umowy']=trim($this->inpArray['temat_umowy']);
        $this->dbLink->checkMaxValuelength('numer_umowy',$this->inpArray['numer_umowy'],'project');
        $this->dbLink->checkMaxValuelength('temat_umowy',$this->inpArray['temat_umowy'],'project');
        self::projectExists('numer_umowy');
        self::projectExists('temat_umowy');
        $this->lastProjectData=$this->Model->{'Project'}->getProjectPostField($this->inpArray['id']);
        //$this->Log->logMulti(2,$this->inpArray,__METHOD__." inpArray"); 
        //$this->Log->logMulti(2,$this->lastProjectData,__METHOD__." lastProjectData"); 
        //die();
        self::setQuotaField($this->lastProjectData['quota']);
        self::parseLastProjectData();
        self::setProjectParm($this->lastProjectData);
        self::setProjectDiff();
        self::getIdDataProjectPost();
        self::setProjectDir();
        self::setProjectSizeQuota();
        self::setProjPrac();
        self::updateProject(); 
        self::parseNotifyFields();
        self::sendNotify(
                        "Zgłoszenie aktualizacji Projektu :: ".$this->inpArray['klient'].', '.$this->inpArray['temat_umowy'].', '.$this->inpArray['typ_umowy'][1],
                        'Zarejestrowano zgłoszenie na aktualizację projektu o specyfikacji:',
                        $this->lastProjectData);
             
        $this->utilities->jsonResponse('','cModal');
    }
    private function updateProject(){
        try{
            $this->Log->log(0,"[".__METHOD__."]");
            $this->Log->logMulti(0,$this->inpArray,__METHOD__);
            $this->Model->{'Project'}->beginTransaction(); //PHP 5.1 and new
            /*
             * UPDATE PROJECT
             */
            $this->Model->{'Project'}->update($this->inpArray);
            $this->Model->{'Project'}->commit();  //PHP 5 and new
        }
        catch (\PDOException $e){
            $this->Model->{'Project'}->rollback(); 
            throw New \Exception(__METHOD__.$e,1);
	}
        /*
         * UPDATE PROJECT DOCUMENTS
         */
        self::parseResponse($this->modul['DOCUMENT']->updateDoc($this->inpArray['id'],$this->inpArrayDok));
    }
    private function projectExists(string $field=''){
        $this->Log->log(0,"[".__METHOD__."] ".$field." => ".$this->inpArray[$field]);  
        if(empty($this->inpArray[$field])){
            return false;
        }
        foreach($this->Model->{'Project'}->projectExists($field,$this->inpArray[$field],$this->inpArray['id']) as $project){
            Throw New \Exception($this->infoArray[$field][1],0);
        }
    }
    private function setQuotaField($quota)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->inpArray['quota']=intval($this->projectParameters['PROJ_QUOTA']);
        $this->projectParm['quota']['old_quota']=intval($quota);
    }
    public function pDocEdit()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->setInput(filter_input_array(INPUT_POST));
        $this->utilities->validateKey($this->inpArray,'id',true,1);
        self::parseResponse($this->modul['DOCUMENT']->updateDoc($this->inpArray['id'],$this->inpArrayDok)); 
        
        /*
         * IT IS POSSIBLE TO ADD EMAIL NOTYFICATION
         */
        //$this->response->setError(0,'TEST STOP');
        $this->utilities->jsonResponse('','cModal');
    }
    public function pDoc(){
        $this->Log->log(0,"[".__METHOD__."]");
        $id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->utilities->jsonResponse(['id'=>$id
            ,'project'=>$this->Model->{'Project'}->getProjectData($id)
            ,'dokPowiazane'=> $this->Model->{'Project_document'}->getById($id)
            ],'pDoc');         
    }
    private function setProjectDiff()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        if($this->projectChange===0)
        {
            $this->Log->log(0,"[".__METHOD__."] BRAK ZMIAN WARTOŚCI PROJEKTU");
            //$this->response->setError(0,"BRAK ZMIAN!");
            //return false;
        }
        // update $lastProjectData for email message
        array_walk($this->lastProjectData,array('self', 'prepareDataRemoveId'));
        array_walk($this->projectDiff,array('self', 'prepareDataRemoveId'));  
        array_walk($this->lastProjectData,array('self', 'updateProjectArray'));  
    }
    private function setProjectDir()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * Project data array
         * for new project inpArray
         * for update project lastProjectData
         */
        $this->projectParm['dir']['new']=self::setDirName(
                                                            $this->inpArray['klient'],
                                                            $this->inpArray['temat_umowy'],
                                                            $this->inpArray['typ_umowy'][1],
                                                            $this->inpArray['d-term_realizacji']
        );
        if($this->projectParm['dir']['change'])
        {
            $this->projectParm['dir']['old']=self::setDirName(
                                                            $this->projectParm['dir']['field']['klient'],
                                                            $this->projectParm['dir']['field']['temat_umowy'],
                                                            $this->projectParm['dir']['field']['typ_umowy'],
                                                            $this->projectParm['dir']['field']['d-term_realizacji']
                    )." ".self::zm;
            self::fixNewDir();
        }  
        self::setDir();
    }
    private function setDirName($klient,$temat,$typ,$date)
    {
        //$k=strtr(utf8_decode($k), utf8_decode('àáâãäąçćèéêëęìíîïñòóôõöóùúûüýÿśÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ'), 'aaaaaacceeeeeiiiinoooooouuuuyysAAAAACEEEEIIIINOOOOOUUUUY');
        $k=preg_replace('/ /','_',$klient);
        $t=preg_replace('/ /','_',$temat);
        $u=preg_replace('/\\//','_',$typ);
        $dir=$k."_".$t."_".$u."_".$this->utilities->getYearFromData($date);
        $this->Log->log(0,"[".__METHOD__."] ".$dir);
        return $dir;
    }
    private function fixNewDir()
    {
        $this->projectParm['dir']['new']=self::spanBlack.$this->projectParm['dir']['new']."</span>";
        $this->Log->log(0,"[".__METHOD__."][new-fix] ".$this->projectParm['dir']['new']);
    }
    private function setDir()
    {
          $this->projectParm['dir']['new']=$this->projectParm['dir']['old']." ".$this->projectParm['dir']['new'];
          $this->Log->log(0,"[".__METHOD__."][new-old] ".$this->projectParm['dir']['new']);
    }
    
    private function setProjectSizeQuota()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * Project data array
         * for new project inpArray
         * for update project lastProjectData
         */
        self::setBaseFileSize();
        self::setQuota();
        self::setSuggestedQuota();
    }
    private function setBaseFileSize()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        self::setOldSize();
        if($this->projectParm['size']['change'])
        {
            self::setNewSize();
        }
        self::setEmailSize();
    }
    private function setQuota()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        self::setOldQuota();
        if($this->projectParm['quota']['change'])
        {
            self::setNewQuota();
        }
        self::setEmailQuota();
    }
     private function setSuggestedQuota()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        self::setOldSuggestedQuota();
        if($this->projectParm['quota']['change'] || $this->projectParm['size']['change'])
        {
            self::setNewSuggestedQuota();
        }
        self::setEmailSuggestedQuota();
    }
    private function setNewSize()
    {
        /*
         * $this->inpArray['r_dane']);
         * $this->inpArray['j_dane']);
         * add info about change
         */
        $this->projectParm['size']['new_size']=self::zm." ".self::spanBlack.$this->inpArray['r_dane'].$this->inpArray['j_dane'].self::sEnd;
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['size']['new_size']);   
    }
    private function setOldSize()
    {
        $this->projectParm['size']['old_size']=$this->projectParm['size']['field']['r_dane'].$this->projectParm['size']['field']['j_dane'];
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['size']['old_size']);
    }
    private function setEmailSize()
    {
        $this->projectParm['size']['new_size']=$this->projectParm['size']['old_size']." ".$this->projectParm['size']['new_size'];
    }
    private function setNewQuota()
    {
        /*
         * VALUE Already defined in method setQuotaField;
         * ADD CSS
         */
        $this->projectParm['quota']['quota']=self::zm." ".self::spanBlack.$this->inpArray['quota'].self::sEnd;
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['size']['new_size']);   
    }
    private function setOldQuota()
    {
        /*
         * Already defined in method setQuotaField;
         */
        //$this->projectParm['quota']['old_quota']='';
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['quota']['old_quota']);
    }
    private function setEmailQuota()
    {
        $this->projectParm['quota']['quota']=$this->projectParm['quota']['old_quota'].' '.$this->projectParm['quota']['quota'];
    }
    private function setNewSuggestedQuota()
    {
        /*
         * VALUE Already defined in method setQuotaField;
         * ADD CSS
         */
        if($this->projectParm['size']['change'] && $this->projectParm['quota']['change'])
        {
            $this->Log->log(0,"[".__METHOD__."] CHANGE SIZE (WITH UNIT) AND QUOTA");
            $this->projectParm['size_quota']['new_size_quota']=intval($this->inpArray['r_dane'])*intval($this->inpArray['quota']).$this->inpArray['j_dane'];
        }  
        else if($this->projectParm['size']['change'] && !$this->projectParm['quota']['change'])
        {
            $this->Log->log(0,"[".__METHOD__."] CHANGE SIZE (WITH UNIT)");
            $this->projectParm['size_quota']['new_size_quota']=intval($this->inpArray['r_dane'])*intval($this->projectParm['quota']['old_quota']).$this->inpArray['j_dane'];
        }
        else if(!$this->projectParm['size']['change'] && $this->projectParm['quota']['change'])
        {
            $this->Log->log(0,"[".__METHOD__."] CHANGE QUOTA");
            $this->projectParm['size_quota']['new_size_quota']=intval($this->projectParm['size']['field']['r_dane'])*intval($this->inpArray['quota']).$this->projectParm['size']['field']['j_dane'];
        }
        else
        {
            $this->response->setError(1, 'WRONG CASE !! NOTHING CHANGE !');  
            $this->projectParm['size_quota']['new_size_quota']='ERROR';
        }
        $this->projectParm['size_quota']['new_size_quota']=self::zm." ".self::spanBlack.$this->projectParm['size_quota']['new_size_quota'].self::sEnd;
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['size_quota']['new_size_quota']);   
    }
    private function setOldSuggestedQuota()
    {
        $this->projectParm['size_quota']['old_size_quota']=intval($this->projectParm['size']['field']['r_dane'])*intval($this->projectParm['quota']['old_quota']).$this->projectParm['size']['field']['j_dane'];
        $this->Log->log(0,"[".__METHOD__."] ".$this->projectParm['size_quota']['old_size_quota']);
    }
    private function setEmailSuggestedQuota()
    {
        $this->projectParm['size_quota']['new_size_quota']=$this->projectParm['size_quota']['old_size_quota'].' '.$this->projectParm['size_quota']['new_size_quota'];
    }
    private function updateProjectArray($v,$k)
    {
        if(array_key_exists ( $k ,$this->projectDiff ))
        {
            $this->Log->log(0,"[".__METHOD__."][$k] ".$v." KEY EXISTS -> update ".$this->projectDiff[$k]);
            $this->lastProjectData[$k]=$this->lastProjectData[$k]." ".self::zm." ".self::spanBlack.$this->projectDiff[$k]."</span>";
            $this->Log->log(0,"[".__METHOD__."] ".$this->lastProjectData[$k]); 
            self::checkProjectParmChange($k,$v,$this->projectParm['dir']); 
            self::checkProjectParmChange($k,$v,$this->projectParm['size']); 
            self::checkProjectParmChange($k,$v,$this->projectParm['quota']);
        }
    }
    private function checkProjectParmChange($k,$v,&$parm)
    {
        $this->Log->log(1,"[".__METHOD__."]");
        //$this->Log->log(1,"[".__METHOD__."] original array");
        $this->Log->logMulti(0,$parm,__METHOD__);
        if(array_key_exists($k,$parm['field']) && $parm['change']===false)
        //if(in_array($k,$parm['field']))
        {
            $this->Log->log(0,"[".__METHOD__."][f:$k][v:$v] array_key_exists in parm[field]");
            $parm['change']=true;
        }
    }
    private function setProjectParm($data)
    {
        $this->Log->logMulti(0,$data,__LINE__."::".__METHOD__);
        $this->projectParm['dir']['field']['klient']=$data['klient'];
        $this->projectParm['dir']['field']['temat_umowy']=$data['temat_umowy'];
        $this->projectParm['dir']['field']['typ_umowy']=$data['typ_umowy'];
        $this->projectParm['dir']['field']['d-term_realizacji']=$data['d-term_realizacji'];
        $this->projectParm['size']['field']['r_dane']=$data['r_dane'];
        $this->projectParm['size']['field']['j_dane']=$data['j_dane'];
        $this->projectParm['quota']['field']['quota']=$data['quota'];
    }
    private function prepareDataRemoveId(&$v)
    {
        $tmp_data=explode('|',$v);
        //$this->Log->log(0,"[".__METHOD__."] original array");
        //$this->Log->logMulti(0,$tmp_data,__METHOD__);
        if(count($tmp_data)>1)
        {
            // remove head
            array_shift($tmp_data);
            //$this->Log->log(0,"[".__METHOD__."] after array_shift");
            //$this->Log->logMulti(0,$tmp_data,__METHOD__);
            // scale tail
            $v = implode (" ",$tmp_data);
            //$this->Log->log(0,"[".__METHOD__."] new value, after implode -> ".$v);
        }
    }

    private function getNotifyFields()
    {
        $nf=$this->dbLink->squery('SELECT SUBSTRING(`SKROT`,20) AS "SKRT" FROM `parametry` WHERE `SKROT` LIKE "INFORM_CHANGE_PROJ_%" AND `WARTOSC`=1 ORDER BY `ID` ASC');
        //$this->Log->logMulti(0,$nf,__METHOD__."=>notifyFields");
        return $nf;
    }
    private function parseNotifyFields()
    {
        /*
         * nf = notify fields, array with 0,1 value
         * 0 -> not send on change
         * 1 -> send on change
         * 
         */
        /*
         * ERROR EXIST OR NO CHANGE
         */
        if($this->response->getError() || $this->projectChange===0) { return '';}
        $this->Log->logMulti(0,$this->projectDiff,__METHOD__."=>projectDiff");
         
        foreach(self::getNotifyFields() as $i => $f)
        {
            if(array_key_exists($f['SKRT'], $this->projectDiff))
            {
                $this->Log->log(0,"[".__METHOD__."] FOUND NOTIFY FIELD (".$f['SKRT'].") => setup var notify = y");
                $this->notify='y';
                break;
            }
        }    
    }
    private function sendNotify($subject,$body,$data)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * ERROR EXIST OR NO CHANGE
         */
        if($this->response->getError() || $this->projectChange===0) { return '';}   
        $this->Log->log(0,"[".__METHOD__."] notify var => ".$this->notify);
        if($this->notify==='n'){ return false;}
        /*
         * FIX DATA FOR TEMPLATE
         */
        self::setDataForBodyEmailTemplate($data);
        if($this->response->getError()) { return false; }
        $this->mail=NEW \Email();            
        /*
         * SET IN BLOCK BECAUSE = Email library can send lvl 2 and this execute die in ErrorHandler
         */
        try{
            $this->mail->sendMail(
                $subject
                ,self::projectBodyMailTemplate($body,$data)
                ,self::cNewProjRecMail(1)
                ,$this->infoArray['err_mail'][0]
                ,true
            );
        }
        catch(\Exception $e){
            $this->Log->logMulti(0,$e->getMessage());
            Throw New \Exception($this->infoArray['err_mail'][0],0);
        }         
    }
    private function setDataForBodyEmailTemplate(&$d){
        $this->Log->logMulti(0,$d,__METHOD__);
        $d['typ_umowy']=self::setupInputValue('typ_umowy');
        $d['size']=$this->projectParm['size']['new_size'];
        $d['quota']=$this->projectParm['quota']['quota'];
        $d['s_quota']=$this->projectParm['size_quota']['new_size_quota'];
        $d['users']=$this->getProjPracList();
        $d['applicant']=$_SESSION['nazwiskoImie']." (".$_SESSION["mail"].")";
        $d['dir']=$this->projectParm['dir']['new'];
        $d['system']=self::setupInputValue('system_umowy'); 
        $d['doc']="- ".$this->projectDocList;
    }
    # RETURN ALL NOT DELETED PROJECT FROM DB
    public function getAllProjects()
    {
        $valueToReturn=array();
        array_push($valueToReturn,$this->query('SELECT * FROM v_all_proj WHERE 1=? ORDER BY id desc',1));
        array_push($valueToReturn,$_SESSION['perm']);
        $this->valueToReturn=$valueToReturn;
    }
    public function getprojectslike(){
        $this->Log->log(0,"[".__METHOD__."] ");
        $this->utilities->jsonResponse(['data'=>$this->Model->{'Project'}->getProjectsLike("%".filter_input(INPUT_GET,'s',FILTER_SANITIZE_STRING)."%"
                                                                                            ,"%".filter_input(INPUT_GET,'filter',FILTER_SANITIZE_STRING)."%"
                                                                                            ,'0')],'sAll');
    }
    # GET PROJECT DETAILS
    public function pDetails(){
        $this->Log->log(0,"[".__METHOD__."] ");
        (int)$id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $v=$this->Model->{'Project'}->get_v_all_proj_v10($id); 
        /*
         * SET DATEPICKER INPUT FIELD
         */
        $v['term_realizacji']=$this->utilities->getDatePickerDate($v['term_realizacji']);
        $v['harm_data']=$this->utilities->getDatePickerDate($v['harm_data']);
        $v['koniec_proj']=$this->utilities->getDatePickerDate($v['koniec_proj']);
        $this->Log->logMulti(0,$v);
        $v['rodzaj_umowy']=$this->Model->{'Project_glossary_implementation'}->getProjectOnTop($id);               
        $v['nadzor']=array_merge([$this->Model->{'Project'}->getProjectNadzor($id)],$this->Model->{'Employee_allocation'}->getExceptEmployeesLike('Lider',$v['nadzor'],intval($v['nadzor_id'],10)));
        $v['kier_grupy']=array_merge([$this->Model->{'Project'}->getProjectKierownikGrupy($id)],$this->Model->{'Employee_allocation'}->getExceptEmployeesLike('Manager',$v['kier_grupy'],intval($v['kier_grupy_id'],10)));
        $v['gl_tech']=array_merge([$this->Model->{'Project'}->getProjectTechnolog($id)],$this->Model->{'Employee_allocation'}->getExceptEmployeesLike('Główny technolog',$v['technolog'],intval($v['technolog_id'],10)));
        $v['gl_kier']=array_merge([$this->Model->{'Project'}->getProjectKierownikOsrodka($id)],$this->Model->{'Employee_allocation'}->getExceptEmployeesLike('Kierownik ośrodka',$v['kier_osr'],intval($v['kier_osr_id'],10)));      
        $v['typ_umowy']=$this->Model->{'Project_glossary_type'}->getProjectOnTop($id);
        $v['system_umowy']=$this->Model->{'Project_glossary_system'}->getProjectOnTop($id);
        $v['unitSlo']=self::setProjectMeasurementDictionary($v['j_dane']);
        $v['project']=$this->Model->{'Project'}->getProjectData($id);
        $v['dokPowiazane']=$this->Model->{'Project_document'}->getById($id);
        echo json_encode($this->response->setResponse(__METHOD__,$v,'pDetails','POST')); 
    }
    private function setProjectMeasurementDictionary(string $nazwa=''):array{
        $this->Log->log(0,"[".__METHOD__."] ");
        /* Project first */
        $all=[$nazwa];
        /* SET Rest */
        foreach($this->Model->{'Dictionary_measurement_units'}->getExceptName($nazwa)  as $v){
            array_push($all,$v['name']);
        }
        return $all;
    }
    public function getProjectEmailData()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->utilities->setGet('id',$this->inpArray);
        $v['id']=$this->inpArray['id'];
        $v['project']=$this->Model->{'Project'}->getProjectData($this->inpArray['id']);
        $v['email']=$this->Model->{'Project'}->getProjectEmployeesEmail($this->inpArray['id']);
        $this->utilities->jsonResponse($v,'pEmail');  
    }
     # RETURN ALL AVAILABLE MEMBERS
    public function getAllavailableEmployee()
    {
        $this->valueToReturn=$this->query('SELECT * FROM v_udzial_sum_procent_prac WHERE sumProcentowyUdzial<? ORDER BY idPracownik ASC ',100);
    }
    public function pDelete(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->setInput();
        $this->utilities->keyExistEmpty('id',$this->inpArray);
        self::setReason();
        $this->Model->{'Project'}->setDeleteStatus($this->inpArray);
        $this->utilities->jsonResponse('','cModal'); 
    }
    public function pClose(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->setInput();
        $this->utilities->keyExistEmpty('id',$this->inpArray);
        self::setReason();
        $this->Model->{'Project'}->setCloseStatus($this->inpArray);
        $this->utilities->jsonResponse('','cModal'); 
    }
    private function setReason(){
        $this->Log->log(0,"[".__METHOD__."]");
        $reason=explode("|",$this->inpArray['reason']);
        if($reason[0]==='0'){
            $reason[1]=$this->inpArray['extra'];
        }
        if(trim($reason[1])===''){
            Throw New Exception('Podaj powód!',0);
        }
        /*
         * OVERRIDE
         */
        $this->inpArray['reason']=$reason[1];
    }
    public function getReturnedValue()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        echo json_encode($this->valueToReturn);
    }
    private function isEmpty($key,$data)
    {
        if(trim($data)===''){
            Throw New Exception ("[".$key."]".$this->infoArray['input'][0],0);
        }
    }
    public function getProjectCloseSlo(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int)$id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->utilities->jsonResponse([
            'project'=>$this->Model->{'Project'}->getProjectData($id)
             ,'slo'=>$this->Model->{'Slo'}->getByName('pClose')
        ],'pClose');  
    }
    public function getProjectDeleteSlo(){
        $this->Log->log(0,"[".__METHOD__."]");
        if($this->utilities->checkInputGetValInt('id')['status']===1){
            Throw New Exception($this->utilities->getInfo(),1);
        }
        $v['id']=$this->utilities->getData();
        $v['project']=$this->Model->{'Project'}->getProjectData($v['id']);
        $v['slo']=$this->dbLink->squery('SELECT `s`.`id`,`s`.`nazwa` FROM `slo` as `s`, `app_task` as `a` WHERE `s`.`id_app_task`=`a`.`id` AND `a`.`name`=\'pDelete\' and `s`.`delete_status`=\'0\' ORDER BY `id` ASC');
        echo json_encode($this->response->setResponse(__METHOD__,$v,'pDelete','POST'));  
        
    }
    private function parseResponse($response)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$response);
        if($response['status']==='0')
        {
            /*
             * NO CHANGE IN DOCUMENT'S
             * CHECK IS DATA IS ALREADY MODYFIED
             * IF YES, OK
             * IF NO, SET 0
             */
            if($this->projectChange===0){
                // ALREADY SETUP NO CHANGE
                Throw New Exception('BRAK ZMIAN !',0);
            }
            $this->projectDocList=$response['info'];
        }
        else if($response['status']==='1'){
            // CHANGE    
            $this->projectDiff['dok']=1;
            $this->projectChange=1;
            $this->projectDocList=$response['info'];
        }
        else if($response['status']==='2'){
            // ERROR
            Throw New Exception ($response['info'],0);
        }
        else{
            // BAD RESPONSE STATUS
            Throw New Exception ('BAD RESPONSE STATUS FROM MODULE',1);
        }
    }
    public function downloadProjectPdf(){
        $this->Log->log(0,"[".__METHOD__."]");
        FileDownload::getFile(UPLOAD_PROJECT_PDF_DIR,filter_input(INPUT_GET,"file"));
    }
    public function downloadProjectDoc(){
        $this->Log->log(0,"[".__METHOD__."]");
        FileDownload::getFile(UPLOAD_PROJECT_DOC_DIR,filter_input(INPUT_GET,"file"));
    }
    public function showProjectReportFile(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$FileShow=new FileShow();
        //$FileShow->getFile(filter_input(INPUT_GET,"dir"),filter_input(INPUT_GET,"file"));
        FileShow::getFile(UPLOAD_DIR,filter_input(INPUT_GET,"file")); 
    }
    public function showProjectTmpReportFile(){
        $this->Log->log(0,"[".__METHOD__."]");
        FileShow::getFile(TMP_UPLOAD_DIR,filter_input(INPUT_GET,"file")); 
    }
    public function getModulProjectDefaults(){
        $this->Log->log(0,"[".__METHOD__."]");
        $Stage=new \ManageProjectStage();
        $this->utilities->jsonResponse(
                [
                    'perm'=>$_SESSION['perm']
                    ,'data'=>$this->Model->{'Project'}->getProjects()
                    ,'glossary'=>$Stage->getGlossary()
                ],'runMain'); 
    }
    private function updateProjectDb($inp=[]){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->input=$inp;
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            self::update();
            $this->dbLink->commit();  //PHP 5 and new
        }
        catch (PDOException $e){
            $this->dbLink->rollback(); 
            throw New Exception(__METHOD__.$e,1);
	}          
    }
    public function getProjectDefaultValues(){
        $this->Log->log(0,"[".__METHOD__."]");
        $valueToReturn['rodzaj_umowy']=$this->Model->{'Project_glossary_implementation'}->get();
        $valueToReturn['nadzor']=$this->Model->{'Employee_allocation'}->getEmployeesLike('Lider');
        $valueToReturn['kier_grupy']=$this->Model->{'Employee_allocation'}->getEmployeesLike('Manager');
        $valueToReturn['dokPowiazane']=$this->Model->{'Project_glossary_document'}->get();
        $valueToReturn['gl_tech']=$this->Model->{'Employee_allocation'}->getEmployeesLike('Główny technolog');
        $valueToReturn['gl_kier']=$this->Model->{'Employee_allocation'}->getEmployeesLike('Kierownik ośrodka');
        $valueToReturn['typ_umowy']=$this->Model->{'Project_glossary_type'}->get();
        $valueToReturn['system_umowy']=$this->Model->{'Project_glossary_system'}->get();
        $valueToReturn['unitSlo']=self::getProjectUnitSlo();
        $valueToReturn['quota']=$this->Model->{'Parametry'}->getParmViaShortcut('PROJ_QUOTA');
        $valueToReturn['r_dane']=$this->Model->{'Parametry'}->getParmViaShortcut('PROJ_BASE_FILE_SIZE');
        $valueToReturn['id']='';
        $valueToReturn['numer_umowy']='';
        $valueToReturn['klient']='';
        $valueToReturn['temat_umowy']='';
        $valueToReturn['term_realizacji']=date("d.m.Y");  
        $valueToReturn['harm_data']=date("d.m.Y"); 
        $valueToReturn['koniec_proj']=date("d.m.Y"); 
        $this->utilities->jsonResponse($valueToReturn,'pCreate');
    }
    private function getProjectUnitSlo(){
        $this->Log->log(0,"[".__METHOD__."]");
        
        $sloIterator=New \DataIterator($this->Model->{'Dictionary_measurement_units'}->getUpperCase());
        $def='';
        $all=array();
        
        while ($sloIterator->valid()) {
            $current = $sloIterator->current();
            if($current['DEF']==='t') {
                $def=$current['NAZWA'];
            }
            else{
                array_push($all,$current['NAZWA']);
            }
            $sloIterator->next();
        }
        array_unshift ($all,$def);
        return $all;
    }
    protected function getProjectId(){
        return $this->idProject;
    }
    function __destruct(){}
}