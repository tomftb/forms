<?php

interface ManageProjectTeamCommand
{
    public function getProjectTeam();
}
final class ManageProjectTeam implements ManageProjectTeamCommand{
    private $member=array();
    private $teamPostFields=array('pers','percent','ds','de');
    private $idProject='';
    private $actTeamMembers=array();
    private $emailTeamList='';
    private $adminEmailList=array();
    const maxPercentPersToProj=100;
    private $Log;
    //private $dbLink;
    private ?object $Model;
    function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities=NEW Utilities();
        //$this->dbLink=LoadDb::load();
        $this->Model=new \stdClass();
        $this->Model->{'Employee'}=new \Employee_model();
        $this->Model->{'Project'}=new \Project_model();
        $this->Model->{'Employee_project'}=new \Employee_project_model();
        $this->Model->{'Parametry'}=new \Parametry_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getProjectTeam(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int)$id=intval(filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT),10);
        $this->Utilities->jsonResponse([
            'id'=>$id
            ,'team'=>$this->Model->{'Employee'}->getTeamInput($id)
            ,'project'=>$this->Model->{'Project'}->getProjectData($id)
        ],'pTeamOff');   
    }
    public function getTeamMember($id){
        $this->Log->log(1,"[".__METHOD__."] ID => ".$id);
        return $this->Model->{'Employee_project'}->getTeamMember($id);
    }
    public function pTeamOff()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $post=filter_input_array(INPUT_POST);
        $this->Utilities->keyExist($post,'id');
        $this->Utilities->isEmptyKeyValue($post,'id',true);
        $v['id']=$this->Utilities->getNumber($post['id']);
        $v['team']=$this->Model->{'Employee'}->getTeamInput($v['id']);
        $v['ava']=self::getAvailableTeam($v['id']);  
        $this->Log->logMulti(2,$v,__LINE__."::".__METHOD__."");
        $this->Utilities->jsonResponse($v,'pTeam');  
    }
    public function pTeam()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->keyExist($this->inpArray,'id');
        $this->Utilities->isEmptyKeyValue($this->inpArray,'id',true);
        $this->idProject=$this->Utilities->getNumber($this->inpArray['id']);
        UNSET($this->inpArray['id']);
        /* TO DO
        $this->adminEmailList=self::getAdminEmail();
         * 
         */
        self::setTeam();
        $this->Utilities->jsonResponse('','cModal');  
    }
    public function getAvailableTeam(string|int $idProject=0){
        $this->Log->log(1,"[".__METHOD__."] ID Project => ".$idProject);
        (array) $team=[];
        foreach($this->Model->{'Employee_project'}->getTeamById($idProject) as $data)
        {
            if($data['ava']>0){
                array_push($team,$data);
            }
        }
        return $team;
    }

    private function setTeam(){
        $this->Log->log(1,"[".__METHOD__."]");
        $project=$this->Model->{'Project'}->getShortProjectData($this->idProject);
        self::setTeamMembers();    
        $this->Log->logMulti(0,$this->member,'member');
        array_map(array($this, 'checkTeamMemberConsistency'),$this->member);
        self::setupMember();              
        array_map(array($this, 'checkTeamMemberAvailable'),$this->member); 
        self::setNewTeamMembers(); 
        self::sendNotify($project);
    }
    private function setupMember(){
        foreach($this->member as $id => $m){
            $p=$this->Model->{'Employee'}->getMemeber($m['pers']);
            $this->member[$id]['imie']=$p['imie'];
            $this->member[$id]['nazwisko']=$p['nazwisko'];
            $this->member[$id]['email']=$p['email'];
            $this->emailTeamList.="<tr><td>".$p['imie'].' '.$p['nazwisko'].'</td><td>'.$this->member[$id]['ds'].'</td><td>'.$this->member[$id]['de'].'</td></tr>';
        }  
    }
    private function setTeamMembers()
    {
        $this->Log->log(1,"[".__METHOD__."]");
        $this->Log->logMulti(1,$this->inpArray);
        foreach($this->inpArray as $k => $v)
        {
            /* CHECK IS EMPTY */
            if(trim($v)===''){
                Throw New Exception('['.$k.'] VALUE IS EMPTY',1);
            }
            self::checkAndSetTeamMember($k,$v);
        }
    }
    private function checkAndSetTeamMember($k,$v)
    {
        $this->Log->log(1,"[".__METHOD__."]");
        /*
         * CHECK FIELDS EXIST
         * pers_
         * percent_
         * ds_
         * de_
         */
        $tmp=explode('_',$k);
        if(!array_key_exists(1, $tmp)){
            Throw New Exception('ARRAY KEY [1] NOT FOUND',1);
        }
        if(!in_array($tmp[0],$this->teamPostFields)){
            Throw New Exception('KEY NOT EXIST IN ACCEPTED FORM FIELDS => '.$tmp[0],1);
        }
        /* SETUP PROPER MySQL DATE */
        self::checkDate($tmp[0],$v);
        $this->member[$tmp[1]][$tmp[0]]=$v;
    }
    private function checkDate($tmp,&$v)
    {
        $this->Log->log(2,__METHOD__."\r\nkey - ".$tmp."\r\n value");
        $this->Log->logMulti(2,$v);
        if($tmp==='ds' || $tmp==='de'){
            
            $v=$this->Utilities->getMysqlDate($v,'.');
        }
    }
    private function checkTeamMemberConsistency($teamMember)
    {
        $this->Log->log(1,"[".__METHOD__."]");
        if(count($teamMember)!==count($this->teamPostFields)){
            Throw New Exception('CONSISTENCY ERROR => count(input_array)!=count(teamPostFields)',1);
        }
    }
    private function checkTeamMemberAvailable($teamMember)
    {
        $this->Log->log(1,"[".__METHOD__."]".$teamMember['pers']);
        $member=$this->Model->{'Employee_project'}->getAvaTeamMember($teamMember['pers'],$this->idProject);
        $this->Log->log(1,"[".__METHOD__."] COUNT => ".count($member));
        $this->Log->logMulti(0,$member);
        if(count($member)!=1){
            Throw New Exception('Pracownik '.$teamMember['imie'].' '.$teamMember['nazwisko'].' nie jest dostępny.',0);
        }
        $this->Log->logMulti(0,$member);
        if($member[0]['ava']<$teamMember['percent']){
            Throw New Exception('Dla pracownika '.$teamMember['imie'].' '.$teamMember['nazwisko'].' wskazano niedozwoloną wielkość udziału. Dostępna wartość - '.$member[0]['ava'],0);
        }
    }
    private function setNewTeamMembers()
    {
        $this->Log->log(1,"[".__METHOD__."]");
        $this->actTeamMembers=$this->Model->{'Employee'}->getProjectTeam($this->idProject);
        $this->Log->logMulti(0,$this->actTeamMembers,'actTeamMembers');
        /* SET CHANGE */
        $change=false;
        /* REMOVE NOT SENDED */
       // try{
            //$this->Main->beginTransaction(); //PHP 5.1 and new
            foreach($this->actTeamMembers as $a){
                self::removeTeamMember($a,$change);
            } 
            /* SET ACTION */
            foreach($this->member as $id => $m){
                self::updInsMember($id,$m,$change);
            }  
            //$this->Main->commit();  //PHP 5 and new
       // }
        //catch (PDOException $e){
            //$this->Main->rollback(); 
           // throw New Exception("DATABASE ERROR: ".$e->getMessage(),1); 
	//} 
        if(!$change){
            Throw New Exception('Nie wprowadzono żadnych zmian!',0);
        }
    }
    private function updInsMember($i,&$m,&$c){
        $this->Log->log(1,"[".__METHOD__."]");
        $found=false;
        foreach($this->actTeamMembers as $a)
        {
            if(intval($a['pers'])===intval($m['pers']) && intval($a['percent'])===intval($m['percent']) && $a['ds']==$m['ds'] && $a['de']==$m['de']){
                $this->Log->log(1,"[".__METHOD__."] FOUND IDENTICAL");
                $found=true;
            }
            else if(intval($a['pers'])===intval($m['pers'])){
                $this->Log->log(1,"[".__METHOD__."] FOUND");
                $this->Model->{'Employee_project'}->update($m['pers'],$this->idProject,$m['imie'],$m['nazwisko'],$m['percent'],$m['ds'],$m['de']);
                $c=true;
                $found=true;
            } 
        }
        if(!$found){
            $c=true;
            $this->Model->{'Employee_project'}->add($m['pers'],$this->idProject,$m['imie'],$m['nazwisko'],$m['percent'],$m['ds'],$m['de']);
        }
    }
    private function removeTeamMember($a,&$c)
    {
        $this->Log->log(1,"[".__METHOD__."]");
        $found=false;
        foreach($this->member as $m)
        {
            if(intval($a['pers'])===intval($m['pers'])){
                $this->Log->log(1,"[".__METHOD__."] FOUND, NOT REMOVE");
                $found=true;
            }
        }
        if(!$found){
            $this->Log->log(1,"[".__METHOD__."] NOT FOUND, REMOVE ID MEMBER=> ".$a['pers'].", ID PROJECT => ".$this->idProject);
            $this->Model->{'Employee_project'}->remove($a['pers'],$this->idProject);
            $c=true;
        }
    }
    protected function emailBody($p)
    {     
        $mailBody="<link href=\"http://fonts.googleapis.com/css?family=Lato:300,400,700&amp;subset=latin,latin-ext\" rel=\"stylesheet\" type=\"text/css\">";
        $mailBody.="<style type=\"text/css\"> table.lato { font-family: 'Lato', Arial,monospace; font-weight:normal;font-size:14px; }p.lato { font-family: 'Lato', Arial,monospace; font-weight:normal;font-size:16px; } </style>";
        $mailBody.="<p class=\"lato\">Zarejestrowano aktualizację zgłoszonego projektu o specyfikacji:</p>";
        $mailBody.="<table class=\"lato\" style=\"border:0px;border-collapse: collapse;\">";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Numer:&nbsp;</p></td><td colspan=\"2\">".$p['numer_umowy']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;\">Klient:&nbsp;</p></td><td colspan=\"2\">".$p['klient']."</td></tr>";
        $mailBody.="<tr><td  style=\"padding-bottom:15px;\"><p style=\"margin:1px;\">Temat:&nbsp;</p></td><td colspan=\"2\" style=\"padding-bottom:15px;\">".$p['temat_umowy']."</td></tr>";
        $mailBody.="<tr><td><p style=\"margin:1px;color:#ff9900;text-align:center;\" >Przypisani członkowie zespołu:&nbsp</p></td><td><p style=\"color: #008000;\">Data od:</p></td><td><p style=\"color: #008000;\">Data do:</p></td></tr>";
        $mailBody.=$this->emailTeamList;
        $mailBody.="<tr><td style=\"padding-top:15px;\"><p style=\"margin:1px;\">Aktualizujący:&nbsp;</p></td><td colspan=\"2\" style=\"padding-top:20px;\">".$_SESSION['nazwiskoImie']." (".$_SESSION["mail"].")</td></tr>";
        $mailBody.="</table>";
        $this->Log->log(0,"[".__METHOD__."] mailBody:");
        return ($mailBody);
    }
    private function emailRecipient()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        /* set admin list */
        $recEmail=self::getAdminEmail();
        $this->Log->logMulti(1,$this->member,__METHOD__." emailRecipient");
        foreach($this->member as $value){
            $pracEmail=array($value['email'],$value['imie']." ".$value['nazwisko']);
            array_push($recEmail,$pracEmail);
        }
        return ($recEmail);
    }
    private function getAdminEmail(){
        /* array of emaiuls */
        $this->Log->log(0,"[".__METHOD__."] ");
        $recEmail=[];
        foreach($this->Model->{'Parametry'}->getParmValue([':k'=>['ADMIN_MAIL_RECIPIENT','STR']]) as $admin){
            foreach(explode(';',$admin['v']) as $user){
                $this->Log->log(0,"[".__METHOD__."] ".$user);
                array_push($recEmail,array($user,'Admin'));
            }
        }        
        return $recEmail;
    }
    private function sendNotify($p){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->mail=NEW \Email();
        $this->mail->sendMail(
                                    'Zgłoszenie na aktualizację członków zespołu :: '.$p['klient'].', '.$p['temat_umowy'].', '.$p['typ'],
                                    self::emailBody($p),
                                    self::emailRecipient(),
                                    'Uaktualniono członków zespołu. Niestety pojawiły się błędy w wysłaniu powiadomienia.',
                                    true);
    }
    function __destruct(){}
}