<?php
/**
 * Description of ManageProjectConstsDatabase
 *
 * @author tborczynski
 * 
 * MANAGE PROJECT CONSTS DATABASE QUERY
 */
abstract class ManageProjectConstantDatabase {
    private $dbLink;
    protected $Log;
    protected $inpArray=array();
    protected $newData=array();
    private $date='';
    protected $Items;
    
    protected $error='';
    
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->dbLink=LoadDb::load();
        $this->dbUtilities=new DatabaseUtilities();
        $this->date=date("Y-m-d H:i:s");
        $this->RA=filter_input(INPUT_SERVER,'REMOTE_ADDR');
        //$this->Items=$Items;
        $this->Items=NEW ManageProjectItems();
    }
    public function __destruct(){}
    protected function getConstants(){
        return $this->dbLink->squery("SELECT * FROM `slo_project_stage_const` s WHERE s.`delete_status`='0' ORDER BY s.`id` ASC");
    }
    protected function checkConstantUnique($k='',$v='',$column='name',$id=0){
        $this->Log->log(0,"[".__METHOD__."]\r\n KEY => ".$k."\r\n VALUE => ".$v);
         /*
          * PARAMTER MUST BY INSERTED WITHOUT CHAR => ' "
          */
         $parm=[
            ':parm'=>[$v,'STR'],
            ':id'=>[$id,'INT']
        ];
        if(intval($this->dbLink->squery("SELECT count(*) as `c` FROM `slo_project_stage_const` WHERE `".$column."`=:parm AND `id`!=:id ORDER BY `id` ASC",$parm)[0]['c'],10)>0){
            $this->error.="[".$k."] Wprowadzona wartość istnieje już w bazie danych.<br/>";
        }
    }
    protected function dbManageConstant($data=[]){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$data);
        //print_r($data);
        //print_r($_SESSION);
        $parm=[
            ':n'=>[$data['nazwa'],'STR'],
            ':w'=>[$data['wartosc'],'STR']
        ];
        if($data['id']>0){
            $parm[':id']=[$data['id'],'INT'];
            $this->dbLink->query(
                "UPDATE `slo_project_stage_const` SET `name`=:n,`value`=:w,".$this->dbUtilities->getAlterSql()." WHERE `id`=:id;"
                ,array_merge($parm,$this->dbUtilities->getAlterParm())
                );
                $this->Items->unsetBlock($data['id'],'slo_project_stage_const','buffer_user_id',$_SESSION['userid']);
        }
        else{
            $this->dbLink->query(
                "INSERT INTO `slo_project_stage_const` (`name`,`value`,".$this->dbUtilities->getCreateSql()[0].",".$this->dbUtilities->getCreateAlterSql()[0].") VALUES (:n,:w,".$this->dbUtilities->getCreateSql()[1].",".$this->dbUtilities->getCreateAlterSql()[1].");"
                ,array_merge($parm, $this->dbUtilities->getCreateParm(),$this->dbUtilities->getAlterParm())
                );
        }
        
    }
    protected function getConstantsLike($sql='',$parm=[]){
        /* */
        $this->Log->log(0,$sql);
        $this->Log->logMulti(0,$parm);
        $data=[];
        foreach($this->dbLink->squery($sql,$parm) as $v){
            array_push($data,[$v['i'],$v['n'],html_entity_decode($v['v']),'bl'=>$v['bl']]);
        }
        return $data;
    }
    protected function getConstantData(int $id=0){
        $this->Log->log(0,"[".__METHOD__."] ID RECORD => ".$id);
        foreach($this->dbLink->squery("SELECT s.`id` as 'i',s.`name` as 'n',s.`value` as 'v',s.`create_user_full_name` as 'cu',s.`create_user_login` as 'cul',s.`create_date` as 'cd',s.`mod_user_login` as 'mu',s.`mod_date` as 'md',s.`buffer_user_id` as 'bu',s.`delete_status` as 'wu',b.`login` as 'bl' FROM `slo_project_stage_const` as s LEFT JOIN `uzytkownik` as b ON s.`buffer_user_id`=b.`id` WHERE s.`id`=:id AND s.`delete_status`='0' LIMIT 0,1",[':id'=>[$id,'INT']]) as $const){
            return $const;
        }
        Throw new \Exception('Const '.$id.' does not exist anymore!', 0);
    }
    protected function getConstantWithoutRecord($idRecord=0){
        $this->Log->log(0,"[".__METHOD__."] ID RECORD => ".$idRecord);
        return $this->dbLink->squery("SELECT * FROM `slo_project_stage_const` s WHERE s.`delete_status`='0' AND s.id!=:id ORDER BY s.`id` ASC",[':id'=>[$idRecord,'INT']]);
    }
    protected function hideConstant(string $status='1'){
        self::updateState($status,'hide');
    }
    protected function deleteConstant($status='1'){
        self::updateState($status,'delete');
    }
    private function updateState(string $value='1', string $column='hide'){
        $parm=[
            ':id'=>[$this->newData['id'],'INT'],
            ':status'=>[$value,'STR'],
            ':reason'=>[$this->newData['reason'],'STR']
        ];
        $this->dbLink->setQuery("UPDATE `slo_project_stage_const` SET `".$column."_status`=:status,`".$column."_reason`=:reason,".$this->dbUtilities->getAlterSql()." WHERE `id`=:id",array_merge($parm,$this->dbUtilities->getAlterParm()));
        $this->dbLink->runTransaction();
    }
}
