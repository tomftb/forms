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
        $this->Log->logMulti(2,$this->inpArray);
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
            ,'n-subsection'=>self::getNSubsection()//range(1,12)
            ],'');
    }
    public function getNSubsection(){
        (array) $data=[];
        foreach(range(1,12) as $v){
            $data[$v]=['n'=>$v,'v'=>$v];
        }
        return $data;
    }
    public function getLineSpacingName(string $shortcut=''):string{
         return self::getParameter($shortcut,'getLineSpacingName');
    }
    public function getTextAlignName(string $shortcut=''):string{
        return self::getParameter($shortcut,'getTextAlignName');
    }
    public function getColorName(string $shortcut=''):string{
        return self::getParameter($shortcut,'getColorName');
    }
    private function getParameter(string $shortcut='',string $glossary='getColorName'):string{
        (string) $set='throwError';
        (string) $return='';
        foreach($this->Model->{'Parametry'}->getParmValue(['k'=>[$shortcut,'STR']]) as $val){
            //$this->Log->logMulti(0,$val);
            /* ONLY FIRST */
            $return=$val['v'];
            $set='noError';
            break;
        }
        self::{$set}('Parameter `'.$shortcut.'` not found in database!',1);
        return self::getParameterValue($return,$glossary);
    }
    private function getParameterValue(string $value='', string $glossary='getColorName'):string{
        $this->Log->log(0,"[".__METHOD__."] value - `".$value."`");
        (string) $return='';
        (string) $set='throwError';
        foreach($this->Model->{'Parametry'}->{$glossary}(['k'=>[$value,'STR']]) as $val){
            //$this->Log->logMulti(0,$val);
            /* ONLY FIRST */
            $return=$val['n'];
            $set='noError';
            break;
        }
        self::{$set}('Parameter value `'.$value.'` not found in `'.$glossary.'` glossary!',1);
        return $return;
    }
    private function throwError(string $msg='', int $lvl=1):void{
        Throw New \Exception($msg,1);
    }
    private function noError():void{
    }
    public function getParameters($key='STAGE_TEXT_'){
         /* SETUP PARAMETER TEMPLATE */
        $parm=[
            $key.'COLOR'=>''
            ,$key.'SECTION_BACKGROUND_COLOR'=>''
            ,$key.'BACKGROUND_COLOR'=>''
        ];
        /* `SKROT` as s, `OPIS` as n,`WARTOSC` as v */
        
        //$this->dbLink->squery('SELECT `SKROT` as s, `OPIS` as n,`WARTOSC` as v FROM `parametry` WHERE `SKROT` LIKE "'.$SHORTCUT.'"  ORDER BY `ID` ASC');
        (string) $set='throwError';
        foreach($this->Model->{'Parametry'}->getAllLike([':k'=>[$key."%",'STR']]) as $v){
            $parm[$v['s']]=['n'=>$v['n'],'v'=>$v['v']];
            $set='noError';
        }
        self::{$set}('Application parameters `'.$key.'%` not found in table `parametry`!',1);
        /*
         * UPDATE COLOR
         */
        $parm[$key.'COLOR']['n']=self::getColorName($key.'COLOR');
        $parm[$key.'SECTION_BACKGROUND_COLOR']['n']=self::getColorName($key.'SECTION_BACKGROUND_COLOR');
        $parm[$key.'BACKGROUND_COLOR']['n']=self::getColorName($key.'BACKGROUND_COLOR');
        /*
         * UPDATE MEASUREMENT
         */
        $parm[$key.'FONT_SIZE_MEASUREMENT']['n']=$parm[$key.'FONT_SIZE_MEASUREMENT']['v'];
        $parm[$key.'LEFT_EJECTION_MEASUREMENT']['n']=$parm[$key.'LEFT_EJECTION_MEASUREMENT']['v'];
        $parm[$key.'RIGHT_EJECTION_MEASUREMENT']['n']=$parm[$key.'RIGHT_EJECTION_MEASUREMENT']['v'];
        $parm[$key.'INDENTATION_MEASUREMENT']['n']=$parm[$key.'INDENTATION_MEASUREMENT']['v'];
        $parm[$key.'SPACE_AFTER_MEASUREMENT']['n']=$parm[$key.'SPACE_AFTER_MEASUREMENT']['v'];
        $parm[$key.'SPACE_BEFORE_MEASUREMENT']['n']=$parm[$key.'SPACE_BEFORE_MEASUREMENT']['v'];
        $parm[$key.'LINE_SPACING_MEASUREMENT']['n']=$parm[$key.'LINE_SPACING_MEASUREMENT']['v'];
        $parm[$key.'TABSTOP_MEASUREMENT']['n']=$parm[$key.'TABSTOP_MEASUREMENT']['v'];
        /*
         * UPDATE FONT FAMILY
         */
        $parm[$key.'ALIGN']['n']=self::getTextAlignName($key.'ALIGN');
         /*
         * UPDATE ALIGN
         */
        $parm[$key.'TABSTOP_MEASUREMENT']['n']=$parm[$key.'TABSTOP_MEASUREMENT']['v'];
        /*
         * UPDATE LINE SPACING
         */
        $parm[$key.'LINE_SPACING']['n']=self::getLineSpacingName($key.'LINE_SPACING');
        return $parm;
    }
    function __destruct(){}
}