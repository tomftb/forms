<?php

class ManageProjectDocument {
    //put your code here
    private $inpArrayDok=array();
    private $idProject='';
    private $dbDok=array();
    private $actDocList=array();
    private $br=''; /* break line */
    private $dash=''; /* dash */
    private $addLabel='';
    const sRed="<span style=\"font-weight:bold;color:#ff0000\"> "; /* &rarr; arrow right */
    const sBlack="<span style=\"font-weight:bold;color:#000000\">";
    const sBlue="<span style=\"font-weight:bold;color:#0000ff\">";
    const sEnd="</span>";
    private $Log;
    private $dbLink;
    private $date="1970-01-01 00:00:01";
    private $RA='127.0.0.1';
    private ?object $Model;
    /*
     * status:
     * 0 -> no change
     * 1 -> change
     * 2 -> error
     */
    private $response=array(
        'status'=>0,
        'info'=>''
    );
    
    function __construct()
    {
        $this->Log=Logger::init(__METHOD__);
        $this->Log->log(0,"[".__METHOD__."]");
        $this->dbLink=LoadDb::load();
        $this->Utilities=NEW \Utilities();
        $this->Model=new \stdClass();
        $this->date=date("Y-m-d H:i:s");
        $this->Model->{'Project_document'}=new \Project_document_model();
    }
    public function updateDoc($id,$doc)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        if(trim($id)===''){
            Throw New Exception ("ID PROJECT IS EMPTY",1);
        }
        $this->inpArrayDok=$doc;
        $this->idProject=$id;
        $this->addLabel=self::sBlue."DODANO".self::sEnd.": ";
        try{
            $this->dbLink->beginTransaction(); //PHP 5.1 and new
            $this->dbDok=$this->Model->{'Project_document'}->getById($this->idProject);
            array_map(array($this, 'removeEmptyDok'),array_keys($this->inpArrayDok),$this->inpArrayDok);
            array_map(array($this, 'existInDb'),array_keys($this->inpArrayDok),$this->inpArrayDok); 
            //self::insertNewDok($this->idProject,$this->inpArrayDok,self::sBlue."DODANO".self::sEnd.": ");
            array_map(array($this, 'insertNewDok'),$this->inpArrayDok);
            array_map(array($this, 'removeNotSendedDoc'),$this->dbDok);
            $this->dbLink->commit();  //PHP 5 and new
         }
        catch (PDOException $e){
            $this->dbLink->rollback(); 
            throw New Exception(__METHOD__.$e,1);
	}
        return (self::setResponse());
    }

    public function getDoc($idProject=1)
    {
        $this->Log->log(0,"[".__METHOD__."]");
        if($idProject==='') { $this->setError(1," WRONG ID PROJECT => (".$idProject.")"); }
        $this->dbDok=$this->Model->{'Project_document'}->getById($idProject);
        $this->response['status']=1;
        foreach($this->dbDok as $value)
        {
            self::setupActDokListField($value['NAZWA']);
        }
        //array_map(array($this, 'setupActDokListField'),$this->dbDok); 
        return (self::setResponse());
    }
    private function existInDb($k,$v)
    {
        $this->Log->log(0,"[".__METHOD__."] $k , $v");
        foreach($this->dbDok as $id => $dok)
        {
            $this->Log->log(0,"[".__METHOD__."] $id , ".$dok['Nazwa']);
            if($v===$dok['Nazwa'])
            {
                $this->Log->log(0,"[".__METHOD__."] FOUND => UNSET => ".$dok['Nazwa']);
                self::setupActDokListField($dok['Nazwa']);
                unset($this->inpArrayDok[$k]);
                unset($this->dbDok[$id]);
            }
        }
    }
    public function addDok($idProject=0,$dokArray=[])
    {
        if(intval($idProject)===0){
            Throw New Exception ('WRONG ID PROJECT => '.$idProject,1);
        }
        $this->idProject=$idProject;
        array_map(array($this, 'insertNewDok'),$dokArray); 
        return (self::setResponse());
    }
    public function insertNewDok($dok)
    {
        $this->Log->log(0,"[".__METHOD__."] INSERT INTO DB => ".$dok);
        $this->response['status']=1;
        $this->date=date("Y-m-d H:i:s");
        $id = random_int(1000000000, 1099511627776);
        $sql=[
            ':id_project'=>[$this->idProject,'INT'],
            ':name'=>[$dok,'STR'],
            ':create_user_id'=>[$_SESSION["userid"],'INT'],
            ':create_user_login'=>[$_SESSION["username"],'STR'],
            ':create_user_full_name'=>[$_SESSION["nazwiskoImie"],'STR'],
            ':create_user_email'=>[$_SESSION["mail"],'STR'],
            ':create_date'=>[$this->date,'STR'],
            ':create_host'=>[$this->RA,'STR'],
            ':mod_user_id'=>[$_SESSION["userid"],'INT'],
            ':mod_user_login'=>[$_SESSION["username"],'STR'],
            ':mod_user_full_name'=>[$_SESSION["nazwiskoImie"],'STR'],
            ':mod_user_email'=>[$_SESSION["mail"],'STR'],
            ':mod_date'=>[$this->date,'STR'],
            ':mod_host'=>[$this->RA,'STR']
        ];
        $this->dbLink->query('INSERT INTO `project_document` (`id`,`id_project`,`name`,`create_user_id`,`create_user_login`,`create_user_full_name`,`create_user_email`,`create_date`,`create_host`,`mod_user_id`,`mod_user_login`,`mod_user_full_name`,`mod_user_email`,`mod_date`,`mod_host`) VALUES ('.$id.',:id_project,:name,:create_user_id,:create_user_login,:create_user_full_name,:create_user_email,:create_date,:create_host,:mod_user_id,:mod_user_login,:mod_user_full_name,:mod_user_email,:mod_date,:mod_host)',$sql);     
        self::setupActDokListField($this->addLabel.$dok);
    }
    
    private function removeNotSendedDoc($dok)
    {
        $this->Log->log(0,"[".__METHOD__."] SET delete_status = 1 FOR ".$dok['ID']." => ".$dok['Nazwa']);
        /*
         * FOR TEST
         */
        //$dok['ID']=999;
        if($this->documentExist($this->idProject,$dok['ID']))
        {

            $sql=[
                ':wsk_u'=>['1','STR'],
                ':mod_data'=>[CDT,'STR'],
                ':mod_user'=>[$_SESSION["username"],'STR'],
                ':mod_user_id'=>[$_SESSION["userid"],'INT'],
                ':mod_host'=>[RA,'STR'],
                ':id_projekt'=>[$this->idProject,'INT'],
                ':id'=>[$dok['ID'],'INT']
            ];
            $this->dbLink->query('UPDATE `projekt_dok` SET '
                    . 'wsk_u=:wsk_u,'
                    . 'mod_data=:mod_data,'
                    . 'mod_user=:mod_user,'
                    . 'mod_user_id=:mod_user_id,'
                    . 'mod_host=:mod_host '
                    . 'WHERE '
                    . 'id_projekt=:id_projekt '
                    . 'AND id=:id',$sql); 
            self::setupActDokListField(self::sRed."USUNIĘTO".self::sEnd.": ".$dok['Nazwa']);
        }
        else{
            Throw New Exception("DOCUMENT NOT FOUND IN DATABASE => ID => ".$dok['ID'].", NAZWA => ".$dok['NAZWA'],1);
        }
    }
    private function documentExist($id=0,$idDoc=0){
        $this->Log->log(0,"[".__METHOD__."]");  
        $sql=[
            ':id'=>[$id,'INT'],
            ':idDoc'=>[$idDoc,'INT'],
            ];
       
        if (count($this->dbLink->squery('SELECT * FROM `project_document` WHERE `id_projekt`=:id AND id=:idDoc',$sql))>0){
            return true;
        }
        return false;
    }
    private function setupActDokListField($dok)
    {
        array_push($this->actDocList,$this->br.$this->dash.$dok); 
        if($this->br==='')
        {
            $this->br='<br/>';
            $this->dash='- ';
        }
    }
    private function removeEmptyDok($k,$v)
    {
        $this->Log->log(0,"[".__METHOD__."] $k => ".$v);
        if(trim($v)==='')
        {
           UNSET($this->inpArrayDok[$k]);
        }
    }

    private function setResponse()
    {
        $this->response['info']=implode('',$this->actDocList);
        $this->Log->log(0,"[".__METHOD__."] RETURN STATUS => ".$this->response['status']);
        $this->Log->log(0,"[".__METHOD__."] RETURN INFO => ".$this->response['info']);
        return ($this->response);
    }
}