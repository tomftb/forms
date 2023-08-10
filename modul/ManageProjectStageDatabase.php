<?php
/**
 * Description of ManageProjectStageDatabase
 *
 * @author tborczynski
 * 
 * MANAGE PROJECT STAGE DATABASE QUERY
 */
class ManageProjectStageDatabase {
    private ?object $Model;
    private $dbLink;
    protected $DatabaseUtilities;
    protected $Log;
    protected $data=array();
    protected $error='';
    protected $stage;
    
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);
        $this->dbLink=LoadDb::load();
        $this->DatabaseUtilities=new DatabaseUtilities();
        $this->Model=new \stdClass();
        $this->Model->{'Slo_project_stage'}=new \Slo_project_stage_model();
    }
    public function __destruct(){}
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    protected function getStageGlossaryText(){
        $this->Log->log(0,"[".__METHOD__."]");
        return [
            'color'=>$this->DatabaseUtilities->getColor(),
            'fontFamily'=>$this->DatabaseUtilities->getFontFamily(),
            'decoration'=>$this->DatabaseUtilities->getStyle(0),
            'textAlign'=>$this->DatabaseUtilities->getStyle(1),
            'measurement'=>$this->DatabaseUtilities->getStyle(2),
            'department'=>$this->DatabaseUtilities->getUserDepartment($_SESSION['userid']),
            'lineSpacing'=>$this->DatabaseUtilities->getSloList('l'),
            'indentationSpecial'=>$this->DatabaseUtilities->getSloList('s'),
            'listMeasurement'=>$this->DatabaseUtilities->getSloList('m'),
            'leadingSign'=>$this->DatabaseUtilities->getSloList('ls'),
            'tabstopAlign'=>$this->DatabaseUtilities->getSloList('a')
        ];
    }
    protected function getStageGlossaryList(){
        $this->Log->log(0,"[".__METHOD__."]");
        return [
            'listType'=>$this->DatabaseUtilities->getListType()
        ];
    }
    protected function getStageGlossaryImage(){
        $this->Log->log(0,"[".__METHOD__."]");
        return [
            'wrapping'=>$this->DatabaseUtilities->getSloList('w'),
            'order'=>$this->DatabaseUtilities->getSloList('o')
        ];
    }
    protected function getStageParameters($parm='STAGE_%'){
        return $this->DatabaseUtilities->getParam($parm);
    }
    protected function getStages(string $where='',array $parm=[]):array{
        $this->Log->log(0,"[".__METHOD__."]");
        (array) $data=[];
        foreach($this->Model->{'Slo_project_stage'}->getStages($where,$parm) as $v){
            //array_push($data,array($v['i'],$v['n'],html_entity_decode($v['t']),html_entity_decode($v['v']),'bl'=>$v['bl']));
            array_push($data,['i'=>$v['i'],'t'=>html_entity_decode($v['t']),'bl'=>$v['bl']]);
        }
        return $data;
    }
    public function getStageImageProperty(&$data,$table,$id=0){
        $this->Log->log(0,"[".__METHOD__."] ID PARENT -> ".$id);
        foreach($this->Model->{'Slo_project_stage_model'}->getChildId($table,[':id'=>[$id,'INT']]) as $k => $v){
            $data->{$k}=new stdClass();
            $data->{$k}->data=new stdClass();
            $data->{$k}->data->id=intval($v->id,10);
            $data->{$k}->data->tmp='n'; // FOR run function getTmpStageImage or getStageImage
            self::assignAllProperty($data->{$k},$table,$v->id);
            /* FIX tmp_id */
            //$data->{$k}->property->tmpid=$k;
        }
    }
    public function assignAllProperty(&$Data,$tablePrefix='',$id=0){
        $this->Log->log(2,"[".__METHOD__."] tablePrefix : ".$tablePrefix."\r\nID: ".$id);
        self::assignProperty($Data,$tablePrefix,'property',$id);
        self::assignProperty($Data,$tablePrefix,'style',$id);
    }
    private function assignProperty(&$data,$tablePrefix = '',$key='property',$id = 0){
        $this->Log->log(2,"[".__METHOD__."] tablePrefix : ".$tablePrefix."\r\nPROPERTY: ".$key."\r\nID: ".$id);
        $data->{$key}=new stdClass();
        foreach($this->dbLink->squery("SELECT `property`,`value` FROM `${tablePrefix}_${key}` WHERE `id_parent`=:id;",[':id'=>[$id,'INT']],'FETCH_OBJ','fetchAll') as $v){
            $data->{$key}->{$v->property} = $v->value;
        }
    }
    public function assignTabStopProperty(&$data,$id=0,$table='slo_project_stage_subsection_row_p_tabstop'){
        $data->tabstop=new stdClass();
        foreach($this->dbLink->squery("SELECT `lp`,`position`,`measurement`,`measurementName`,`alignment`,`alignmentName`,`leadingSign`,`leadingSignName` FROM `".$table."` WHERE `id_parent`=:id ORDER BY `lp` asc;",[':id'=>[$id,'INT']],'FETCH_OBJ','fetchAll') as $v){
            //$data->{$key}->{$v->property} = $v->value;
            $data->tabstop->{$v->lp} = (object) array(
                    'position'=>floatval($v->position),
                    'measurement'=>$v->measurement,
                    'measurementName'=>$v->measurementName,
                    'alignment'=>$v->alignment,
                    'alignmentName'=>$v->alignmentName,
                    'leadingSign'=>$v->leadingSign,
                    'leadingSignName'=>$v->leadingSignName
                );
        }
    }
    
    public function assignVariableProperty(&$data,$id=0,$table='slo_project_stage_subsection_row_p_variable'){
        $data->variable=$this->dbLink->squery("SELECT `id_variable`,`name`,`value`, (CASE WHEN `type`='v' THEN 'zmienna' WHEN `type`='t' THEN 'tekst' ELSE 'error_type' END) as 'type' FROM `".$table."` WHERE `id_parent`=:id ORDER BY `id` ASC;",[':id'=>[$id,'INT']],'FETCH_OBJ','fetchAll');        
    }
    private function checkStageExists($id=0){
        $data=$this->dbLink->squery("SELECT count(*) as c FROM `slo_project_stage` s WHERE s.id=:id",[':id'=>[$id,'INT']],'FETCH_OBJ','fetch'); 
        if(intval($data->c,10)!==1){
            Throw New Exception('Count of `slo_project_stage` id='.$id.' ('.$data->c.') !==1 ',1);
        }
    }
    protected function getStageFullData($id=0){
        $this->Log->log(0,"[".__METHOD__."] ID => ".$id);
        self::checkStageExists($id);
        /* GET STAGE */
        $this->stage = new stdClass();
        $this->stage->data=$this->Model->{'Slo_project_stage'}->getStageFullData([':id'=>[$id,'INT']]);
        /* FIX STRING TO INT */
        $this->stage->data->id=intval($this->stage->data->id,10);
        /* SET STAGE STYLE AND PROPERTY */
        self::assignAllProperty($this->stage,'slo_project_stage',$this->stage->data->id);
        /* SET STAGE SECTION */
        self::getStageSection($this->stage,$id);
        return $this->stage;
    }
    private function getStageSection(&$data,$id=0){
        $this->Log->log(2,"[".__METHOD__."] ID => ".$id);
        $data->section=new stdClass();
        /* GET SECTION*/
        foreach($this->Model->{'Slo_project_stage'}->getSection([':id'=>[$id,'INT']]) as $k => $v){
            $data->section->{$k} = (object) array(
                    'data'=>new stdClass(),
                    'subsection'=>new stdClass()
                );
            $data->section->{$k}->data->id=intval($v->id,10);
            self::assignAllProperty($data->section->{$k},'slo_project_stage_section',$data->section->{$k}->data->id);
            self::getStageSubsection($data->section->{$k}->subsection,$data->section->{$k}->data->id);
        }
    }
    private function getStageSubsection(&$data,$id=0){
        $this->Log->log(2,"[".__METHOD__."] ID => ".$id);
        /* GET SUBSECTION */
        foreach($this->Model->{'Slo_project_stage'}->getSubsection([':id'=>[$id,'INT']]) as $k => $v){
            $data->{$k} = (object) array(
                    'data'=>new stdClass(),
                    'subsectionrow'=>new stdClass()
                );
            $data->{$k}->data->id=intval($v->id,10);
            self::assignAllProperty($data->{$k},'slo_project_stage_subsection',$data->{$k}->data->id);
            self::getStageSubsectionRow($data->{$k}->subsectionrow,$data->{$k}->data->id);
        }
    }
    private function getStageSubsectionRow(&$data,$id=0){
        $this->Log->log(2,"[".__METHOD__."] ID => ".$id);
        foreach($this->Model->{'Slo_project_stage'}->getSubsectionRow([':id'=>[$id,'INT']]) as $k => $v){
             $data->{$k}= (object) array(
                    'data'=>new stdClass(),
                    'image'=>new stdClass(),
                    'list'=>new stdClass(),
                    'paragraph'=>new stdClass(),
                    'table'=>new stdClass(),
                );
            $data->{$k}->data->id=intval($v->id,10);
            self::assignAllProperty($data->{$k},'slo_project_stage_subsection_row',$data->{$k}->data->id);
            self::getStageImageProperty($data->{$k}->image,'slo_project_stage_subsection_row_i',$data->{$k}->data->id);
            self::assignAllProperty($data->{$k}->list,'slo_project_stage_subsection_row_l',$data->{$k}->data->id);
            self::assignAllProperty($data->{$k}->paragraph,'slo_project_stage_subsection_row_p',$data->{$k}->data->id);
            self::assignAllProperty($data->{$k}->table,'slo_project_stage_subsection_row_t',$data->{$k}->data->id);
            /* SET TAB STOP */
            self::assignTabStopProperty($data->{$k}->paragraph,$data->{$k}->data->id,'slo_project_stage_subsection_row_p_tabstop');
            /* SET VARIABLE */
            self::assignVariableProperty($data->{$k}->paragraph,$data->{$k}->data->id,'slo_project_stage_subsection_row_p_variable');
        }
    }
    
    private function getStyleProperty($id = 0){
        $style=[];
        foreach($this->dbLink->squery("SELECT `property`,`value` FROM `slo_project_stage_subsection_row_style` WHERE `id_parent`=".$id.";") as $v){
            $style[$v['property']]=$v['value'];
        }
       return $style;
    }
    protected function getStage($id=0){
        $this->Log->log(0,"[".__METHOD__."] ID => ".$id);
        /* GET STAGE */ 
        foreach($this->Model->{'Slo_project_stage'}->getStageEqual([':id'=>[$id,'INT']]) as $stage){
            return $stage;
        }
        Throw New Exception ("[".__METHOD__.'] Stage not found - '.$id,1);
    }
    protected function hideStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Slo_project_stage'}->hideStage(self::getChangeStageParm());
    }
    protected function deleteStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Slo_project_stage'}->deleteStage(self::getChangeStageParm());
    }
    private function deleteSection($id = 0){  
        $parm=[
            ':id'=>[$id,'INT'],
            ':delete_date'=>[$this->DatabaseUtilities->getDate(),'STR']
        ];
        $this->dbLink->query("UPDATE `slo_project_stage_section` SET `delete_status`='1',`delete_reason`='Removed by edit',`delete_date`=:delete_date,".$this->DatabaseUtilities->getAlterSql()." WHERE `id_parent`=:id AND `delete_status`='0'",
                array_merge($parm,$this->DatabaseUtilities->getAlterParm()));
    }
    private function getChangeStageParm(){
        return [
            ':id'=>[$this->data['id'],'INT'],
            ':status'=>['1','STR'],
            ':reason'=>[$this->data['reason'],'STR']
        ];
    }
    protected function manageStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        /* START TRANSACTION - must by outside of try catch */
        $this->dbLink->beginTransaction(); //PHP 5.1 and new
        try{
            /* CHECK DEPARTMENT EXIST */
            $this->DatabaseUtilities->exist('department',"id=".$this->data->data->departmentId);
            //self::runQuery();
            $this->data->data->id=intval($this->data->data->id,10);
            $id=self::setStage();
            $this->dbLink->commit();  //PHP 5 and new
            return $id;
        }
        catch (\PDOException $e){
            //$this->Log->log(0,$e);
            $this->dbLink->rollback(); 
            $this->Log->log(0,__METHOD__." DB ERROR:");
            $this->Log->logMulti(0,$e);
            Throw New Exception("[".__METHOD__."] DATABASE ERROR: ".$e->getMessage(),1);
        }
        finally{
            //$this->queryList=[];
            //return $id;
        }
    }
    private function setStage(){
        $this->Log->log(0,"[".__METHOD__."]\r\nID DB - ".$this->data->data->id);  
        $id=$this->data->data->id;
        /* ADD/UPDATE STAGE */
        if($this->data->data->id===0){
            $this->Log->log(0,"INSERT STAGE"); 
            /* SET NEW ID */
            $id = random_int(1000000000, 1099511627776);
            /* SQL INSERT STAGE */
            $parm=self::sqlStageParm();
            $parm[':part']=[$this->data->data->part,'STR'];
            $parm[':id']=[$id,'INT'];
            $this->Model->{'Slo_project_stage'}->insertStage($parm);
            
            /* 
            /* SQL INSERT STAGE SECTION */
            foreach($this->data->section as $v){
               self::insertSection($id,$v);
            }
        }
        else{
            /* ADD TO JS NEW PAGE!!!!*/
            $this->Log->log(0,"UPDATE STAGE"); 
            /* SQL UPDATE STAGE */
            self::updateStage();
            /* SQL UPDATE (DELETE) STAGE SECTION delete_status, update section wil set selete_status=0 */
            self::deleteSection($this->data->data->id);
            /* SQL UPDATE STAGE SECTION */
            foreach($this->data->section as $v){
                self::manageSection($v);
            }
        }
        $this->Log->log(0,"[".__METHOD__."] UPDATE ATTRBUTES");  
        self::deleteAttributes($id,'slo_project_stage');  
        self::insertAttributes($id,$this->data,'slo_project_stage');  
        return $id;
    }
    private function updateStage(){
        $this->Log->log(0,"[".__METHOD__."]");  
         /* SQL INSERT STAGE */
        $this->dbLink->query2(
                "UPDATE `slo_project_stage` SET "
                . "`departmentId`=:departmentId"
                . ",`departmentName`=:departmentName"
                . ",`title`=:title"
                . ",`type`=:type"
                . ",`new_page`=:new_page"
                . ",".$this->DatabaseUtilities->getAlterSql().""
                . " WHERE"
                . "`id`=:id;"
                ,array_merge(self::sqlStageParm(),[':id'=>[$this->data->data->id,'INT']],$this->DatabaseUtilities->getAlterParm())
        );
    }
    private function sqlStageParm() : array{
        return [
                ':departmentId'=>[$this->data->data->departmentId,'INT'],
                ':departmentName'=>[$this->data->data->departmentName,'STR'],
                ':title'=>[$this->data->data->title,'STR'],
                ':type'=>['tx','STR'],
                ':new_page'=>[$this->data->data->valuenewline,'STR'],
        ];
    }
    private function insertSection($idStage=0,$section=[]){
        $this->Log->log(0,"[".__METHOD__."]\r\nINSERT SECTION\r\nID DB STAGE - ".$idStage);
        /* INSERT SECTION */
        $id = random_int(1000000000, 1099511627776);
        $this->Model->{'Slo_project_stage'}->insertSection([':id'=>[$id,'INT'],':id_parent'=>[$idStage,'INT']]);
         /* INSERT SUBSECTION [COLUMNS] */
        self::insertAttributes($id,$section,'slo_project_stage_section');    
        foreach($section->subsection as $v){
            self::insertSubsection($id,$v); 
        }
    }
    private function updateSection($v = []){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Slo_project_stage'}->updateDeleteWithReason('slo_project_stage_section',[':id'=>[$v->data->id,'INT'],':reason'=>['','STR'],':status'=>['0','STR']]);
        self::deleteAttributes($v->data->id,'slo_project_stage_section');  
        self::insertAttributes($v->data->id,$v,'slo_project_stage_section');      
        /* SQL UPDATE (DELETE) STAGE SECTION ROW delete_status, update subsection row wil set delete_status=0 */
        $this->Model->{'Slo_project_stage'}->updateDeleteWithReason('slo_project_stage_subsection',[':id'=>[$v->data->id,'INT'],':reason'=>['Removed by edit','STR'],':status'=>['1','STR']]);
        /* MANAGE SUBSETION */
        self::manageSubSection($v->data->id,$v->subsection);
    }
    private function manageSection($v=[]){
        $this->Log->log(0,"[".__METHOD__."]");   
        /* 
         * v - SECTION
         */
        if(is_null($v)){
            /* SECTION REMOVED */
            return false;
        }
        /*
         * v -> data
         * v -> style
         * v -> property
         * v -> subsection
         */
        $v->data->id = intval($v->data->id,10);
        if($v->data->id>0){
            /* SQL UPDATE SECTION */
            self::updateSection($v);
        }
        else{
            /* SQL INSERT STAGE SECTION */
            self::insertSection($this->data->data->id,$v);
        }
    }
    private function insertSubsection($idParent=0,$v=[]){
        $this->Log->log(0,"[".__METHOD__."]\r\n ID DB SECTION - ".$idParent);
        /*
         * v -> data
         * v -> style
         * v -> property
         * v -> subsectionrow
        */
        $id=random_int(1000000000, 1099511627776);
        $this->Model->{'Slo_project_stage'}->insertSubsection([':id'=>[$id,'INT'],':id_parent'=>[$idParent,'INT']]);
        /* INSERT SUBSECTION ROW [COLUMNS] */

        self::insertAttributes($id,$v,'slo_project_stage_subsection');        
        foreach($v->subsectionrow as $v){
            $IdRow=self::insertSubsectionRow($id,$v); 
            self::deleteAttributes($IdRow,'slo_project_stage_subsection_row');  
            self::insertAttributes($IdRow,$v,'slo_project_stage_subsection_row');
        }
    }
    private function insertSubsectionRow($idParent=0,$data=[]){
        $this->Log->log(0,"[".__METHOD__."]\r\n ID DB SUBSECTION - ".$idParent);
        /* INSERT SUBSECTION ROWA DATA */
        $id=random_int(1000000000, 1099511627776);
        $this->Model->{'Slo_project_stage'}->insertSubsectionRow([':id'=>[$id,'INT'],':id_parent'=>[$idParent,'INT']]);
        /*
         * INSERT paragraph
         */
        $this->Log->log(0,"paragraph");
        self::insertAttributes($id,$data->paragraph,'slo_project_stage_subsection_row_p');
        /* INSERT SUBSECTION ROW TABSTOP */
        self::insertExtendedTabStop($id,$data->paragraph->tabstop);
        self::insertExtendedVariable($id,$data->paragraph->variable,'slo_project_stage_subsection_row_p_variable');
        /*
         * INSERT list
         */
        $this->Log->log(0,"list");
        self::insertAttributes($id,$data->list,'slo_project_stage_subsection_row_l');
        /*
         * INSERT table
         */
        $this->Log->log(0,"table");
        self::insertAttributes($id,$data->table,'slo_project_stage_subsection_row_t');
        /*
         * INSERT image
         */
        $this->Log->log(0,"image");
        /* REMOVE OLD */
         ////$parm[':id']=[$id,'INT'];
        //$this->dbLink->query2("DELETE FROM `".$table."_style` WHERE `id_parent`=:id;",$parm);
        /* ADD NEW */
        foreach($data->image as $v){
            self::insertExtendedSubsectionRowImage($id,$v,'slo_project_stage_subsection_row_i');
        }
        return $id;
    }
    public function insertExtendedSubsectionRowImage($idParent,$v,$table){
        $this->Log->log(0,"[".__METHOD__."]");
        $run = function($idParent,$table,$t,$v){
            /*
             * t - $this
             */
            $id=random_int(1000000000, 1099511627776);
            $t->Model->{'Slo_project_stage'}->insertSubsectionRowImage([':id'=>[$id,'INT'],':id_parent'=>[$idParent,'INT']]);
            /* INSERT IMAGE STYLE AND PROPERTIES */
            $t->insertAttributes($id,$v,$table);
            /* MOVE FILE from tmp_uplad to upload */
            File::moveFile(TMP_UPLOAD_DIR.$v->property->uri,UPLOAD_DIR,$v->property->uri);
        };
        self::insertSubsectionRowImage($idParent,$v,$table,$run);
    }
    public function insertSimpleSubsectionRowImage($IdRow,$v,$table){
        $this->Log->log(0,"[".__METHOD__."]");
        $run = function($IdRow,$table,$t,$v){
            $id=random_int(1000000000, 1099511627776);
            //$t->dbLink->query2("INSERT INTO `".$table."` (`id_parent`) VALUES (:id);",[':id'=>[$IdRow,'INT']]); 
            $t->Model->{'Slo_project_stage'}->insertSubsectionRowImage([':id'=>[$id,'INT'],':id_parent'=>[$idParent,'INT']]);
              /* INSERT IMAGE STYLE AND PROPERTIES */
            $t->insertSimpleAttributes($id,$v,$table);
             /* MOVE FILE from tmp_uplad to upload IF CHANGED !!!! */
            //File::moveFile(TMP_UPLOAD_DIR.$v->property->uri,UPLOAD_DIR,$v->property->uri);
        };
        self::insertSubsectionRowImage($IdRow,$v,$table,$run);
    }
    private function insertSubsectionRowImage($IdRow=0,$v,$table,$run){
        /* INSERT IMAGE */
        $run($IdRow,$table,$this,$v);
      
    }
    public function insertAttributes($id=0,$data=[],$table='slo_project_stage_subsection_row_p'){
        $this->Log->log(2,"[".__METHOD__."]\r\nID - ".$id."\r\nTABLE: ".$table);
        (array) $parm[':id_parent']=[$id,'INT'];
        self::checkProperty($data,'style',$table);
        self::checkProperty($data,'property',$table);
        self::insertAttributesProperty($parm,$data->style,$table.'_style');
        self::insertAttributesProperty($parm,$data->property,$table.'_property'); 
    }
    public function deleteAttributes($id=0,$table='slo_project_stage_section'){
        $this->Log->log(0,"[".__METHOD__."]\r\nID - ".$id."\rTABLES:\r\n`".$table."_style`\r\n`".$table."_property`");
        $this->Model->{'Slo_project_stage'}->delete($table."_style",[':id'=>[$id,'INT']]);
        $this->Model->{'Slo_project_stage'}->delete($table."_property",[':id'=>[$id,'INT']]);
    }
    private function insertAttributesProperty($parm=[],$data=[],$table='slo_project_stage_subsection_row_p_style'){
        $this->Log->log(2,"[".__METHOD__."]\r\nTABLE: ".$table);
        foreach($data as $k => $v){
            $parm[':property']=[$k,'STR']; 
            $parm[':value']=[$v,'STR']; 
            $this->Model->{'Slo_project_stage'}->insertProperty($table,$parm);
        }
    }
    public function insertSimpleAttributes($id=0,$data,$table=''){
        $this->Log->log(2,"[".__METHOD__."]\r\nID - ".$id."\r\nTABLE: ".$table);
        $parm[':id']=[$id,'INT'];
        self::checkProperty($data,'style',$table);
        self::checkProperty($data,'property',$table);
        self::inserSimpletAttributesProperty($parm,$data->style,$table.'_style');
        self::inserSimpletAttributesProperty($parm,$data->property,$table.'_property'); 
    }
    private function inserSimpletAttributesProperty($parm=[],$data=[],$table='slo_project_stage_subsection_row_p_style'){
        foreach($data as $k => $v){
            $parm[':property']=[$k,'STR']; 
            $parm[':value']=[$v,'STR']; 
            $this->dbLink->query2("INSERT INTO `".$table."` (`id_parent`,`property`,`value`) VALUES (:id,:property,:value);",$parm);
        }
    }
    public function insertSimpleTabStop($id=0,$data=[]){
        $this->Log->log(2,"[".__METHOD__."]");
        $run = function($parm,$t){
            $t->Model->{'Slo_project_stage'}->insertTabStop($parm);
        };
         self::insertTabStop($id,$data,$run);
    }
    public function insertExtendedTabStop($id=0,$data){
         $this->Log->log(0,"[".__METHOD__."] TabStop:");
         $this->Log->log(0,$data);
        //var_dump($data);
        $run = function($parm,$t){
            $t->Model->{'Slo_project_stage'}->insertTabStop($parm);
            
        };
        self::insertTabStop($id,$data,$run);
    }
    private function insertTabStop($id=0,$data=[],$run){
        $this->Log->log(0,"[".__METHOD__."]\r\n ID DB SUBSECTION ROW - ".$id);
        $parm=[];
        
        foreach($data as $k => $v){
            $this->Log->log(0,$k);
            $this->Log->log(0,$v);
                $parm=[
                    ':id_parent'=>[$id,'INT'],
                    ':lp'=>[$k,'INT'],
                    ':position'=>[$v->position,'STR'],/* PDO NOT ACCEPT FLOAT */
                    ':measurement'=>[$v->measurement,'STR'],
                    ':measurementName'=>[$v->measurementName,'STR'],
                    ':alignment'=>[$v->alignment,'STR'],
                    ':alignmentName'=>[$v->alignmentName,'STR'],
                    ':leadingSign'=>[$v->leadingSign,'STR'],
                    ':leadingSignName'=>[$v->leadingSignName,'STR']
                ];
                $run($parm,$this);
        }
    }
    public function insertSimpleVariable($id=0,$data=[]){
         $run = function($parm,$t){
            $t->Model->{'Slo_project_stage'}->insertVariable($parm);
        };
        self::insertVariable($id,$data,$run);
    }
    public function insertExtendedVariable($id=0,$data=[]){
         $run = function($parm,$t){
            $t->Model->{'Slo_project_stage'}->insertVariable($parm);
        };
        self::insertVariable($id,$data,$run);
    }
    private function insertVariable($id=0,$data=[],$run){
        $this->Log->log(2,"[".__METHOD__."]\r\n ID DB SUBSECTION ROW - ".$id);
        foreach($data as $v){
                $parm=[
                    ':id'=>[$id,'INT'],
                    ':id_variable'=>[$v->id_variable,'INT'],/* PDO NOT ACCEPT FLOAT */
                    ':name'=>[$v->name,'STR'],
                    ':value'=>[$v->value,'STR'],
                    ':type'=>[self::parseVariableType($v->type),'STR'] /* TO DO IN FUTURE v - variable, t - text */
                ];
                $run($parm,$this);
        }
    }
    private function parseVariableType($v=''){
        switch ($v){
            case 'zmienna':
                return 'v';
            case 'tekst':
                return 't';
            default :
                Throw New Exception ('Wrong variable type!',0);
        }
    }
    private function manageSubSection($idSection,$subsection=[]){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->log(0,"ID SECTION - ".$idSection);
        foreach($subsection as $v){
            /*
            * v -> data
            * v -> style
            * v -> property
            * v -> subsectionrow
            */
            //$this->Log->log(0,"[".__METHOD__."] TYPE - ".gettype($v));
            if(is_null($v)){
                /* SUBSECTION ROW REMOVED */
                continue;
            }
            $this->Log->log(0,$v->data);
            $v->data->id = intval($v->data->id,10);
            $this->Log->log(0,'ID SUBSECTION - '.$v->data->id);
            
            if($v->data->id>0){
                /* SQL UPDATE SUB SECTION */
                self::updateSubSection($v);
            }
            else{
                /* INSERT SUBSECTION [COLUMNS] */
                self::insertSubsection($idSection,$v);
            } 
        }
         /* LOOP FOR DELETE */
    }
    private function updateSubSection($v = []){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Slo_project_stage'}->updateDeleteWithReason('slo_project_stage_subsection',[':id'=>[$v->data->id,'INT'],':reason'=>['','STR'],':status'=>['0','STR']]);
        self::deleteAttributes($v->data->id,'slo_project_stage_subsection');
        self::insertAttributes($v->data->id,$v,'slo_project_stage_subsection');
        /* SQL UPDATE (DELETE) STAGE SECTION ROW delete_status, update subsection row wil set delete_status=0 */
        $this->Log->log(0,"[".__METHOD__."] deleteSubsectionRow");
        $this->Model->{'Slo_project_stage'}->updateDeleteWithReason('slo_project_stage_subsection_row',[':id'=>[$v->data->id,'INT'],':reason'=>['Removed by edit','STR'],':status'=>['1','STR']]);
        /* */
        self::manageSubSectionRow($v->data->id,$v->subsectionrow);
    }
    private function manageSubSectionRow($idSubSection=0,$subSectionRow=[]){
        $this->Log->log(0,"[".__METHOD__."]");        
        foreach($subSectionRow as $v){
            /*
            * v -> data
            * v -> style
            * v -> property
            * v -> subsectionrow 
            */
            //$this->Log->log(0,"[".__METHOD__."] TYPE - ".gettype($v));
            if(is_null($v)){
                /* SUBSECTION ROW REMOVED */
                continue;
            }
            $v->data->id = intval($v->data->id,10);
            $this->Log->log(0,'ID SUBSECTION ROW - '.$v->data->id);
            $lastRow=$v->data->id;
            //$this->Log->log(0,$v);
            if($v->data->id>0){
                /* SQL UPDATE SUB SECTION */
                self::updateSubSectionRow($v);  
            }
            else{
                /* INSERT SUBSECTION [COLUMNS] */
                $lastRow=self::insertSubsectionRow($idSubSection,$v);  
            }
            self::deleteAttributes($lastRow,'slo_project_stage_subsection_row');  
            self::insertAttributes($lastRow,$v,'slo_project_stage_subsection_row');
        }
        /* LOOP FOR DELETE */
    }
    private function updateSubSectionRow($v = []){
        $this->Log->log(0,"[".__METHOD__."]");       
        $parm=[':id'=>[$v->data->id,'INT'] ];
        $this->dbLink->query2(
                "UPDATE `slo_project_stage_subsection_row` SET "
                ."`delete_reason`=''"
                .",`delete_status`='0'"
                . ",".$this->DatabaseUtilities->getAlterSql().""
                . " WHERE"
                . "`id`=:id;"
                ,array_merge($parm,$this->DatabaseUtilities->getAlterParm()));
        /* DELETE AND INSTERT - STYLE AND PROPERTY TEXT,LIST,TABLE,LIST, IT PREVENT FOR CHANGES ON FRONT-END WHEN NEW STYLES OR PROPERTY APPEARS */    
        /*
         * INSERT paragraph
         */
        self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_p');
        self::insertAttributes($v->data->id,$v->paragraph,'slo_project_stage_subsection_row_p');
        /* INSERT SUBSECTION ROW TABSTOP */
        $this->dbLink->query2("DELETE FROM `slo_project_stage_subsection_row_p_tabstop` WHERE `id_parent`=:id;",$parm);
        self::insertExtendedTabStop($v->data->id,$v->paragraph->tabstop);
        /* INSERT SUBSECTION ROW VARIABLE */
        $this->dbLink->query2("DELETE FROM `slo_project_stage_subsection_row_p_variable` WHERE `id_parent`=:id;",$parm);
        self::insertExtendedVariable($v->data->id,$v->paragraph->variable,'slo_project_stage_subsection_row_p_variable');
        /*
         * INSERT list
         */
        self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_l');
        self::insertAttributes($v->data->id,$v->list,'slo_project_stage_subsection_row_l');
        /*
         * INSERT table
         */
        self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_t');
        self::insertAttributes($v->data->id,$v->table,'slo_project_stage_subsection_row_t');
        /*
         * INSERT image
         */
        
        //
        
        /* SET delete_status to OLD IMAGE */
        array_walk($v->image,['self','updateSubSectionRowImage'],$v->data->id);
    }
    private function updateSubSectionRowImage($v,$key=0,$IdRow=0){
        $this->Log->log(0,"[".__METHOD__."]\rID: ".$v->data->id);  
        $this->Log->log(0,"[".__METHOD__."]\rTMP:".$v->data->tmp);  
        if($v->data->id>0 && $v->data->tmp==='y'){
            $this->Log->log(0,"UPDATE IMAGE");      
            /* OLD FILE STAY FOR BACK FUNCTION IN FUTUTRE -> TO DO */
            self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_i');
            /* INSERT NEW ATTRBIUTES */
            self::insertAttributes($v->data->id,$v,'slo_project_stage_subsection_row_i');
            /* MOVE FILE */
            File::moveFile(TMP_UPLOAD_DIR.$v->property->uri,UPLOAD_DIR,$v->property->uri);
        }
        else if($v->data->id>0 && $v->data->tmp==='n'){
            $this->Log->log(0,"UPDATE ONLY IMAGE ATTRIBUTES");  
            self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_i');
            self::insertAttributes($v->data->id,$v,'slo_project_stage_subsection_row_i');
        }
        else if($v->data->id>0 && $v->data->tmp==='d'){
            $this->Log->log(0,"REMOVE IMAGE");  
            //self::updateImageWskU($IdRow,);
            self::updateImageWskU($v->data->id);
            //self::deleteAttributes($v->data->id,'slo_project_stage_subsection_row_i');
            //self::insertAttributes($v->data->id,$v,'slo_project_stage_subsection_row_i');
        }
        else if($v->data->id===0 && $v->data->tmp==='y'){
            $this->Log->log(0,"INSERT IMAGE");
            self::insertExtendedSubsectionRowImage($IdRow,$v,'slo_project_stage_subsection_row_i');
        }
        else{
           throw New Exception ('Wrong CASE: ID - '.$v->data->id.' tmp - '.$v->data->tmp,1);
        }
    }
    private function updateImageWskU($imageId=0){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->log(0,$imageId);
        
           $this->dbLink->query2(
                "UPDATE `slo_project_stage_subsection_row_i` SET "
                ."`delete_reason`='REMOVED BY USER'"
                .",`delete_status`='1'"
                . ",".$this->DatabaseUtilities->getAlterSql().""
                . " WHERE"
                . "`id`=:id;"
                ,array_merge([':id'=>[$imageId,'INT']],$this->DatabaseUtilities->getAlterParm()));
        return true;
    }
    public function updateSimpleWskU($id=0,$table=''){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->log(0,$id);
        $this->Log->log(0,$table);
        $this->dbLink->query2(
                "UPDATE `".$table."` SET `delete_status`='1' WHERE `id`=:id;"
                ,[':id'=>[$id,'INT']]);
    }
    private function checkProperty($data,$property='',$table=''){
         $this->Log->log(2,"[".__METHOD__."]\r\nPROPERTY - `".$property."`\r\nTABLE - `".$table."`");
         if(!property_exists($data, $property)){
            $this->Log->log(0,$data);
            Throw New Exception('Property `'.$property.'` not exist for table - `'.$table."`",1);
        }
    }
}