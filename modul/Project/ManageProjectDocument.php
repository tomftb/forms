<?php

class ManageProjectDocument {
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
        'status'=>'0',
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
        $this->response['status']='1';
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
    public function insertNewDok(string $document=''){
        $this->Log->log(0,"[".__METHOD__."] INSERT INTO DB => ".$document);
        $this->response['status']='1';
        $this->Model->{'Project_document'}->insert(random_int(1000000000, 1099511627776),$this->idProject,$document);
       self::setupActDokListField($this->addLabel.$document);
    }
    private function removeNotSendedDoc($dok){
        $this->Log->log(0,"[".__METHOD__."]\r\n SET delete_status = `1`\r\n ID - `".$dok['ID']."`\r\n VALUE - `".$dok['Nazwa']."`");
        /*
         * FOR TEST
         */
        //$dok['ID']=999;
        if($this->documentExist($this->idProject,$dok['ID'])){
            $this->Model->{'Project_document'}->setDeleteStatusByIdProject($dok['ID'],$this->idProject);
             $this->response['status']='1';
            self::setupActDokListField(self::sRed."USUNIĘTO".self::sEnd.": ".$dok['Nazwa']);
        }
        else{
            Throw New Exception("DOCUMENT NOT FOUND IN DATABASE => ID => ".$dok['ID'].", NAZWA => ".$dok['NAZWA'],1);
        }
    }
    private function documentExist(int $id_project=0,int $id=0):bool{
        $this->Log->log(0,"[".__METHOD__."]");  
        if (count($this->Model->{'Project_document'}->getByIdProject($id_project,$id))>0){
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