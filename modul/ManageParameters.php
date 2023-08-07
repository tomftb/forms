<?php
class ManageParameters {
    private $inpArray=array();
    protected $filter='';
    private $parmSkrt='';
    private $Log;
    private ?object $Model;
    private ?object $Utilities;
    function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->Model=new \stdClass();
        $this->Model->{'Parametry'}=new \Parametry_model();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities=NEW \Utilities();
    }
    public function getAllParm(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities->jsonResponse(['parm'=>$this->Model->{'Parametry'}->getAll(['f'=>["%".filter_input(INPUT_GET,'f',FILTER_SANITIZE_STRING)."%",'STR']])],'sAll');
    }
    public function updateParm(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->inpArray=filter_input_array(INPUT_POST);
        $this->Utilities->validateKey($this->inpArray,'id',true,1);
        //$this->Utilities->validateKey($this->inpArray,'value',true,1);
        $sql[':i']=[$this->inpArray['id'],'INT'];
        self::verifyParameterId($sql);
        // PARSE TAKE PARM SKROT
        self::setParmSkrt($sql);
        self::parseParm();
        self::update();
        $this->Utilities->jsonResponse(['i'=>$this->inpArray['id']
                ,'d'=>date('Y-m-d H:i:s')
                ,'u'=>$_SESSION['nazwiskoImie']
            ],'pUpdate');
    }
    private function verifyParameterId(array $sql=[':i'=>[0,'INT']]){
        if(count($this->Model->{'Parametry'}->get($sql))!=1){
            Throw New Exception ('Parameter with ID => '.$this->inpArray['id'].' not exist or is more than one',1);
        }
    }
    private function update(){
        $this->Log->log(0,"[".__METHOD__."]");
        $sql=[
                ':W'=>[$this->inpArray['value'],'STR'],
                ':MD'=>[CDT,'STR'],
                ':ML'=>[$_SESSION["username"],'STR'],
                ':MU'=>[$_SESSION["nazwiskoImie"],'STR'],
                ':MUI'=>[$_SESSION["userid"],'STR'],
                ':MH'=>[RA,'STR'],
                ':I'=>[$this->inpArray['id'],'INT']
            ];
        $this->Model->{'Parametry'}->update($sql);
    }
    public function setParmSkrt(array $parm=[':i'=>[0,'INT']]){
        $this->parmSkrt=$this->Model->{'Parametry'}->getParmSkrt($parm);
        $this->Log->logMulti(0,$this->parmSkrt);
    }
    private function parseParm()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $this->parmSkrt="check".$this->parmSkrt;
        if(in_array($this->parmSkrt,array_filter(get_class_methods(__CLASS__),[$this,"getCheck"]))){
            self::{$this->parmSkrt}();
        }
    }
    private function getCheck($var){
         if(preg_match('/^(check)/', $var)){
            return $var;
        }
    }
    private function checkMAIL_PASS(){
        if(strlen($this->inpArray['value'])===0) { return false; }    
        $plchar='\ą\Ą\c\Ć\ę\Ę\ł\Ł\ó\Ó\ś\Ś\ż\Ż\ź\Ź\ń\Ń';
        if(!preg_match('/^[a-zA-Z\_\+\=\-\d'.$plchar.']{2,9}$/', $this->inpArray['value'])){
            Throw New Exception ("BŁĘDNE HASŁO",0); 
        }
    }
    private function checkMAIL_SRV(){
        $tmp=explode('.',$this->inpArray['value']);
        if(count($tmp)<3){
            Throw New Exception ("BŁĘDNY SERWER POCZTY",0); 
        }
        foreach($tmp as $part){
            if(!preg_match('/^[a-zA-Z\d][a-zA-Z\_\-\d]{0,48}[a-zA-Z\d]{0,1}$/', $part)){
                Throw New Exception ("BŁĘDNY SERWER POCZTY",0); 
            }
        }
    }
    private function checkMAIL_USER(){
        if (!filter_var($this->inpArray['value'], FILTER_VALIDATE_EMAIL)){
            Throw New Exception ("BŁĘDNY ADRES EMAIL",0); 
        }
    }
    private function checkMAIL_CHARSET(){
        if(!preg_match('/^[a-zA-Z][a-zA-Z\-\d]{2,9}$/', $this->inpArray['value'])){
            Throw New Exception ("BŁĘDNE KODOWANIE ZNAKÓW",0); 
        }
    }
    private function checkMAIL_PORT_OUT(){
        if(!preg_match('/^\d{2,5}$/', $this->inpArray['value'])){
            Throw New Exception ("BŁĘDNY PORT WYCHODZĄCY",0); 
        }
    }
    private function checkMAIL_RECIPIENT(){
        $err='';
        $tmp=explode(';',$this->inpArray['value']);
        foreach($tmp as $lp => $email){
            if (!filter_var($email, FILTER_VALIDATE_EMAIL)){
               $err.="[LP. ".$lp."] BŁĘDNY ADRES EMAIL<br/>";
            }
        }
        if($err){
            Throw New Exception ($err,0); 
        }
    }
    public function getModulParametersDefaults(){
        $this->Utilities->jsonResponse([
            'perm'=>$_SESSION['perm']
            ,'parm'=>$this->Model->{'Parametry'}->getDefaults()
            ,'color'=>$this->Model->{'Parametry'}->getColor()
            ,'text-align'=>$this->Model->{'Parametry'}->getTextAlign()
            ,'text-decoration'=>$this->Model->{'Parametry'}->getTextDecoration()
            ,'measurement'=>$this->Model->{'Parametry'}->getMeasurement()
            ,'font-family'=>$this->Model->{'Parametry'}->getFontFamily()
            ,'line-spacing'=>$this->Model->{'Parametry'}->getLineSpacing()
            ,'list-type'=>$this->Model->{'Parametry'}->getListType()
            ],'');
    }
    function __destruct(){}
}