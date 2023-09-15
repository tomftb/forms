<?php
class Utilities
{
    //put your code here
    /*
     * status:
     * 0 -> ok
     * 1 -> error
     *
     */
    private $validDate=false;
    private $validDok=false;
    private $Log;
    private $Error;
    
    private $response=array(
        'status'=>0,
        'info'=>'',
        'data'=>[]
    );
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->ErrorHandler=New \ErrorHandler();
    }
    public function checkInputGetValInt($key){
        $i=filter_input(INPUT_GET,$key,FILTER_VALIDATE_INT);
        $this->Log->log(0,"[".__METHOD__."] KEY => ".$i);
        if(trim($i)!=='')
        {
            $this->response['data']=intval($i);
        }
        else
        {
            //$this->setError(1,' KEY '.$key.' in $_GET IS EMPTY');
        }
        return (self::response());
    }
    public function isValueEmpty($value=''){
        if(trim($value)===''){
           Throw New exception ("VALUE IS EMPTY",1);
        }
    }
    public function checkInputGetValSanitizeString($key)
    {
        $s=filter_input(INPUT_GET,$key); //$key
        //$s=filter_input(INPUT_GET,$key,FILTER_SANITIZE_STRING); //$key
        $this->Log->log(0,"[".__METHOD__."] KEY => ".$key);
        $this->Log->log(0,"[".__METHOD__."] S => ".$s);
        if(trim($s)!=='')
        {
            $this->response['data']=$s;
        }
        else
        {
            //$this->setError(1,' KEY '.$key.' in $_GET IS EMPTY');
        }
        return (self::response());
    }
    public function checkKeyExist($k,$a,&$e)
    {
        $this->Log->log(0,"[".__METHOD__."] KEY => ".$k);
        $this->Log->logMultidimensional(0,$a,"L::".__LINE__."::".__METHOD__);
        if (!array_key_exists($k,$a))
        {
            $e="[ERROR] Wystąpił błąd aplikacji! Skontaktuj się z Administratorem!";
            $this->Log->log(0,' KEY '.$k.' NOT EXIST IN ARRAY');
        }
    }
    public function keyExistEmpty(string|int $k='',array $a=[]):void{
        $this->Log->log(0,"[".__METHOD__."] KEY => ".$k);
        $this->Log->logMultidimensional(0,$a,"L::".__LINE__."::".__METHOD__);
        if (!array_key_exists($k,$a)){
            Throw New \Exception("[".__METHOD__.'] Key `'.$k.'` not exists in array!',1);
        }
        if(trim($a[$k])===''){
            Throw New \Exception("[".__METHOD__.'] Key `'.$k.'` trimed value `'.$a[$k].'` empty!',1);
        }
    }
    public function keyExist(array $a=[],string|int $k=''):void{
        if(!is_array($a)){
            Throw New Exception("[".__METHOD__.'] ARG 1 IS NOT ARRAY!',1);
        }
        if (!array_key_exists($k,$a)){
            Throw New Exception("[".__METHOD__.'] No '.$k.' KEY in ARRAY!',1);
        }
    }
    public function isEmptyKeyValue($a,$k,$t=true,$errLvl=1){
        if($t){
            if(empty(trim($a[$k]))){
                Throw New Exception("[".__METHOD__.'] KEY '.$k.' is Empty (WITH TRIM)!',$errLvl);
            }
        }
        else{
            if(empty($a[$k])){
                Throw New Exception("[".__METHOD__.'] KEY '.$k.' is Empty!',$errLvl);
            }
        }  
    }
    public function validateKey($a=[],$k,$t=true,$errLvl=1){
        if(!is_array($a)){
            Throw New Exception("[".__METHOD__.'] ARG 1 IS NOT ARRAY!',$errLvl);
        }
        self::keyExist($a,$k);
        self::isEmptyKeyValue($a,$k,$t,$errLvl);
    }
    public function getNumber($n,$base=10){
        return intval($n,$base);
    }
    public function setGet($key='id',&$input=[]){
        $input[$key]=self::getNumber(filter_input(INPUT_GET,$key,FILTER_VALIDATE_INT));
        if($input[$key]===0){
            Throw New Exception("[".__METHOD__.'] Wrong ID => '.$input[$key],1);
        }
    }
    public function setGetString($key='id',&$input=[]){
        $input[$key]=filter_input(INPUT_GET,$key,FILTER_SANITIZE_STRING);
        if(trim($input[$key])===''){
            Throw New Exception("[".__METHOD__.'] Key is empty '.$key.' => '.$input[$key],1);
        }
    }
    public function jsonResponse($v='',$f=''){
        echo json_encode([
                'data'=>[
                            'value'=>$v,
                            'function'=>$f
                        ],
                'status'=>0,
                'info'=>''
        ]);
    }
     public function jsonResponseData($v=[]){
        echo json_encode([
                'data'=>$v,
                'status'=>0,
                'info'=>''
            ]);
    }
    public function getPost($trim=true,$date=false){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->validDate=$date;
        $this->response['data']=[];
        $POST = filter_input_array(INPUT_POST);
        $this->Log->logMultidimensional(0,$POST,"L::".__LINE__."::".__METHOD__);
        foreach($POST as $k => $v){
            $this->Log->log(2,"[".__METHOD__."] KEY => ".$k." ,VALUE => ".$v);
            self::myTrim($v,$trim);
            self::checkDateTypePost($k,$v);
            $this->response['data'][$k]=$v;
        }
        $this->Log->log(2,"[".__METHOD__."] response[data]:");
        $this->Log->logMultidimensional(2,$this->response['data'],"L::".__LINE__."::".__METHOD__);
        return (self::response());
    }
    public function getDoc($empty=false)
    {
         $this->Log->log(0,"[".__METHOD__."]");
         $this->Log->logMulti(0,$this->response);
        /*
         * if empty is true assign empty dok as well
         */
        $dok=array();
        foreach($this->response['data'] as $k => $v)
        {
            if(preg_match('/^(dok-).*/i',$k) && $empty===true)
            //if(substr($k, 0,7)==='orgDok-')
            {
                $dok[$k]=$v;
                $this->Log->log(1,"[".__METHOD__."] FOUND EMPTY DOCUMENT ".$k." => ".$v);
            }
            else if(preg_match('/^(dok-).*/i',$k) && $empty===false && $v!=='')
            {
                $dok[$k]=$v;
                $this->Log->log(1,"[".__METHOD__."] FOUND NOT EMPTY DOCUMENT ".$k." => ".$v);
            }
            else
            {
                $this->Log->log(1,"[".__METHOD__."] NOT A DOCUMENT ".$k." => ".$v);
            }
        }
        return $dok;
    }
    public function checkDateTypePost($k,&$v):bool{
        $this->Log->log(1,"[".__METHOD__."]");
        if(!$this->validDate) {return '';}
        if(!preg_match('/^(d-).*/i',$k)){return false;}
        $tmp_date=array();  
        (int) $i=0;
        foreach(explode('.',$v) as $tmp){
            array_push($tmp_date,$tmp);
            $i++;
        }
        $this->Log->log(1," DATE - `".$v."`");
        if($i!==3){
            $this->ErrorHandler->setError('Wrong date `'.$v.'`! Expected format `dd.mm.yyyy`! Field count '.$i.' expected 3.',0);
            return false;
        }
        /*
         * CHECK DAY,MONTH,YEAR
         */
        self::checkDateField('DAY',$tmp_date[0],2);
        self::checkDateField('MONTH',$tmp_date[1],2);
        self::checkDateField('YEAR',$tmp_date[2],4);
        if($this->ErrorHandler->getStatus()==='1'){
            return false;
        }
        /*
         * SET MySQL DATE FORMAT
         */
        $v=$tmp_date[2]."-".$tmp_date[1]."-".$tmp_date[0];
        $this->Log->log(1,"[".__METHOD__."] FOUND AND SET DATE - ".$v);
        return true;
    }
    private function checkDateField(string $date_part='DAY',string $date='',int $length=2):bool{
        $this->Log->log(2,"[".__METHOD__."]");
        $date_length=strlen($date);
        $numbers=range(0,9);
        if($date_length!==$length){
            $this->ErrorHandler->setError('Wrong date `'.$date_part.'` length '.$date_length.'! Expect '.$length,0);
            return false;
        }
        /*
         * FROM END TO BEGGINING
         * WRONG - EXAMPLE 10
            $numbers_end_date=range(1,9);
            $check_numbers=&$numbers_end_date;
            for($i=strlen($date);$i>0;$i--){
                $part=substr($date, $i-1,1);
                $this->Log->log(2," part - ".$part);
                if(!in_array(intval($part,10),$check_numbers)){//
                    $this->ErrorHandler->setError('Wrong date `'.$date_part.'` field value `'.$part.'` not in (0...9)!',0);
                }
                $check_numbers=&$numbers;
            }
         */
        for($i=0;$i<strlen($date);$i++){
            $part=substr($date, $i,1);
            $this->Log->log(2," part - ".$part);
            if(!in_array(intval($part,10),$numbers)){
                $this->ErrorHandler->setError('Wrong date `'.$date_part.'` field value `'.$part.'` not in (0...9)!',0);
            }
        }
        /*
         * CHECK INTEGER DATE VALUE
         */
        $date_int=intval($date);
        if($date_int<1){
             $this->ErrorHandler->setError('Wrong date `'.$date_part.'` value `'.strval($date_int).'`!',0);
        }
        return true;
    }
    public function checkDokTypePost($k,$v)
    {
        if(!$this->validDok) {return '';}
        if(preg_match('/^(dok-).*/i',$k))
        //if(substr($k, 0,7)==='orgDok-')
        {
            if($v!=='')
            {
                $this->Log->log(1,"[".__METHOD__."] FOUND NOT EMPTY DOCUMENT => ".$v);
                $this->inpArrayDok[$k]=$v;
            }
            UNSET($this->inpArray[$k]);
        }
    }
    public function myTrim(&$value,$trim=true)
    {
        if($trim)
        {
            $value=trim($value);
        } 
    }
    public function getCbox()
    {
        $this->Log->log(0,"[".__METHOD__."]");
        $box=array();
        $this->Log->logMultidimensional(2,$this->response['data'],__LINE__."::".__METHOD__." response[data]");
        foreach($this->response['data'] as $k => $v)
        {
            if(preg_match('/^(cbox-).*/i',$k))
            //if(strpos($k,'cbox-')!==false) 
            {   
                /*
                 * CUT cbox-
                 */
                $k=mb_substr($k, 5);
                array_push($box,self::parseCbox($k));
            }           
        }
        $this->Log->logMultidimensional(2,$box,__LINE__."::".__METHOD__." cbox");
        return $box;
    }
    public function getCboxFromInput($inpArray){
        $this->response['data']=$inpArray;
        return self::getCbox();
    }
    public function mergeArray(&$mainArray,$additionalArray){
        foreach($additionalArray as $k => $v){
            $mainArray[$k]=$v;
        }
    }
    private function parseCbox(&$v)
    {
        $this->Log->log(2,"[".__METHOD__."]");
        //echo "FOUND\n";
        $tmp1=explode('-',$v);
        $tmp3=array();
        foreach($tmp1 as $v)
        {
            $this->Log->log(2,"[".__METHOD__."] v => ".$v);
            $tmp2=explode(':',$v);
            if(!array_key_exists(1, $tmp2))
            {
                /*
                 * IF NOT EXIST ADD EMPTY
                 */
                $tmp2[1]='';
            }
            $tmp3[$tmp2[0]]=trim($tmp2[1]);
        }
        return $tmp3;
    }
    public function setDafaultValue($f,$a,$d)
    {
        /*
         * f => field to check
         * a => array 
         * d => default value
         */
        if (array_key_exists($f,$a))
        {
            return ($a[$f]);
        }
        else
        {
            return ($d);
        } 
    }
    public function getArrayKeyValue($idx,$a)
    {
        /*
         * RETURN ARRAY OF DEFINED K IN ARRAY
         * ONE LEVEL
         */
        $this->Log->logMultidimensional(2,$a,__LINE__."::".__METHOD__);
        $tmp=array();
        foreach($a as $k => $v)
        {
            if(!array_key_exists($idx, $v))
            {
                $this->ErrorHandler->setError(' IDX '.$idx.' NOT FOUND IN ARRAY!',1);
            }
            else
            {
                array_push($tmp,$v[$idx]);
            }
        }
        $this->Log->logMultidimensional(2,$tmp,__LINE__."::".__METHOD__);
        return $tmp;
    }
    public function checkValueLength($value,$label,$min,$max){
        if(strlen($value)<$min){
            return ("W ".$label." nie wprowadzono minimalnej ilości znaków");
        }
        if(strlen($value)>$max){
            return ("W ".$label." przekroczono dopuszczalną ilość znaków");
        }
        return '';
    }
    public function getMysqlDate($date,$delimiter)
    {
        $this->Log->log(2,"[".__METHOD__."]");
        /* DEFAULT 0000-00-00 */
        $tmp=explode($delimiter,$date);
        $this->Log->logMulti(0,$tmp,__METHOD__);
        $Day='';
        $DayLength=0;
        $Year='';
        $YearLength=0;
        $c=count($tmp);
        if($c!==3){
            Throw New Exception('WRONG DATE! THERE SHOULD BE THREE CELLS ('.$c.')',0);
        }
        /*
        if(mb_strlen($tmp[0])===mb_strlen($tmp[2])){
            Throw New Exception('WRONG DATE! LENGTH OF DATE YEAR CELL EQUAL DATE DAY CELL',0);
        }
         *
         */
        if(mb_strlen($tmp[1])!==2){
            Throw New Exception ('WRONG DATE! LENGTH OF DATE CELL MONTH != 2',0);
        }
        
        $DayLength=strlen($tmp[0]);
        $YearLength=strlen($tmp[2]);
        
        if($YearLength!==2 && $YearLength!==4){
            Throw New Exception ('WRONG DATE! WRONG YEAR LENGTH ('.$YearLength.')',0);
        }
        if($DayLength!==2 && $DayLength!==1 && $DayLength!==4){
            Throw New Exception ('WRONG DATE! WRONG DAY LENGTH ('.$DayLength.')',0);
        }
        $Day=$tmp[0];
        $Year=$tmp[2];
        if($DayLength===1){
            $Day='0'.$Day;
        }
        if($YearLength===2){
            //$Year=substr(date('Y'),0,2).$Year;
            $Year='00'.$Year;
        }
        $this->Log->log(1,"[".__METHOD__."] DATE => ".$Year.'-'.$tmp[1].'-'.$Day);
        return ($Year.'-'.$tmp[1].'-'.$Day);
    }
    private function response(){
        $this->response['status']=$this->ErrorHandler->getStatus();
        $this->response['info']=$this->ErrorHandler->getError();
        return ($this->response);
    }
    public function getYearFromData($date,$delimiter='-'){
        $tmp=explode($delimiter,$date);
        return $tmp[0];
    }
    public function getData(){
        $this->Log->log(0,"[".__METHOD__."]");
        return ($this->response['data']);
    }
    public function getInfo(){
        $this->Log->log(0,"[".__METHOD__."]");
        return ($this->response['info']);
    }
    public function getStatus(){
        $this->Log->log(0,"[".__METHOD__."]");
        return ($this->response['status']);
    }
    public function getDatePickerDate(string $date_mysql=''):string{
        /*
         * explode by space
         */
        $tmp_datetime=self::getDatePart(' ',2,$date_mysql,'MySQL datetime');
        /*
         * 0 - date
         * 1 - time
         * explode by -
         */
        $tmp_date=self::getDatePart('-',3,$tmp_datetime[0],'MySQL date');
        self::checkDateField('DAY',$tmp_date[2],2);
        self::checkDateField('MONTH',$tmp_date[1],2);
        self::checkDateField('YEAR',$tmp_date[0],4);
        return $tmp_date[2].'.'.$tmp_date[1].'.'.$tmp_date[0];
    }
    private function getDatePart(string $delimiter='', int $length=0, string $date_part='', string $part='MySQL datetime'):array{
        $date = explode($delimiter,$date_part);
        if(count($date)!=$length){
            Throw New Exception('Wrong '.$part.' format `'.$date.'`!',1);
        }
        return $date;
    }
}