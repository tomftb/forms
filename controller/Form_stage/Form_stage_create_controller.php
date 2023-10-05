<?php

 final class Form_stage_create_controller extends Base_controller {

    private ?string $set = 'setData';// setData//setError
    private ?object $command;
    private ?int $error_lvl=0;
    private ?string $msg = 'Nie wprowadzono danych';
    private ?object $Utilities;
    private ?int $stage_id=0;
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities = new Utilities();
        $this->command = new stdClass();
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Model->{'Form_stage_section'}=new \Form_stage_section_model();
        $this->Model->{'Form_stage_subsection'}=new \Form_stage_subsection_model();
        $this->Model->{'Form_stage_row'}=new \Form_stage_row_model();
        
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function saveFormStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        (array) $post = json_decode(filter_input(INPUT_POST,'data'));
        if(json_last_error()){
            throw new \exception(json_last_error_msg(),0);
        }
        self::create($post);
        $response = self::get();
        $response->id_db = 0;
        parent::returnJson($response);
    }
    private function create(object $data){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->data = $data;
        $this->Log->logMulti(0,$data);
        $this->Utilities->propertyExists($data,'stage');
        /*
         * CHECK AND SET TASK:
         * insert
         * update
         */
        foreach($data->stage as $k => &$s){
            $this->command->{$k} = new stdClass();
            self::stage($this->command->{$k},$s);
        }
        /*
         * COMMAND
         */
        $this->{$this->set}();
    }
    private function setCommand(object &$command, int $id=0,string $sufix = 'Stage'):void{//'Stage'
        $this->Log->log(0,"[".__METHOD__."] SET TASK FOR - ".$sufix);        
        if($id===0){
            /* 
             * INSERT
             */
            $this->Log->log(0,"INSERT");
            $command->{'run'} = 'insert'.$sufix;
        }
        else{
            /*
             * UPDATE
             */
            $this->Log->log(0,"UPDATE");
            $command->{'run'} = 'update'.$sufix;
        }
    }
    private function stage(object &$command,object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$stage);
        /*
         * property:
         * id
         * section
         */
        $this->Utilities->propertyExists($stage,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'section','['.__METHOD__.'] Property `section` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'department_id','['.__METHOD__.'] Property `department_id` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'department_name','['.__METHOD__.'] Property `department_name` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'title','['.__METHOD__.'] Property `title` doesn\'t exists in object!');
        $this->Log->logMulti(0,$stage->id_db);
        self::setId($stage->id_db);
        $command->{'run'} = '';
        $command->{'section'} = new stdClass();
        self::setCommand($command,$stage->id_db,'Stage');
        foreach($stage->section as $k => &$s){
            $command->{'section'}->{$k} = new stdClass();
            self::section($command->{'section'}->{$k},$s);
        }
    }
    private function section(object &$command,object &$section){
        //$this->Log->logMulti(0,$section);
        /*
         * property:
         * id
         * subsection
         */
        $this->Utilities->propertyExists($section,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($section,'subsection','Dodaj kolumnę',0);
        self::setId($section->id_db);
        $command->{'run'} = '';
        $command->{'subsection'} = new stdClass();
        self::setCommand($command,$section->id_db,'Section');
        foreach($section->subsection as $k => &$s){
            $command->{'subsection'}->{$k} = new stdClass();
            self::subsection($command->{'subsection'}->{$k},$s);
        }
    }
    private function subsection(object &$command,object $subsection){
        //$this->Log->logMulti(0,$subsection);
        $this->Utilities->propertyExists($subsection,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($subsection,'row','Dodaj dane do kolumny',0);
        self::setId($subsection->id_db);
        $command->{'run'} = '';
        $command->{'row'} = new stdClass();
        //self::setTask($subsection->id_db,$this->task['subsection'],'Subsection');
        self::setCommand($command,$subsection->id_db,'Subsection');
        foreach($subsection->row as $k => &$r){
            $command->{'row'}->{$k} = new stdClass();
            self::row($command->{'row'}->{$k},$r);
        }
    }
    private function row(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'type','['.__METHOD__.'] Property `type` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row,'property','['.__METHOD__.'] Property `property` not exists in row object!');
        $this->Utilities->propertyExists($row,'style','['.__METHOD__.'] Property `style` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row,'value','['.__METHOD__.'] Property `value` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row object!');
        self::setId($row->id_db);
        $command->{'run'} = '';
        $command->{'type'} = $row->type;
        $command->{'rowchild'} = new stdClass();
        $command->{'rowchild'}->{'run'} = 'noRowChild';
        //self::setTask($row->id_db,$this->task['row'],'Row');
        self::setCommand($command,$row->id_db,'Row');
        /*
         * SET:
         * text
         * input
         * select
         * checkbox
         * radio
         */
        self::{"set_".$row->type}($command->{'rowchild'},$row);
        $this->set='setData';
    }
    private function set_text(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_input(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_select(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'glossary','['.__METHOD__.'] Property `glossary` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row->glossary,'id_glossary','['.__METHOD__.'] Property `id_glossary` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'id_glossary_position','['.__METHOD__.'] Property `id_glossary_position` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'position_name','['.__METHOD__.'] Property `position_name` doesn\'t exists in row->glossary object!');
    }
    private function set_radio(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'child','['.__METHOD__.'] Property `child` doesn\'t exists in row->property object!');
        $this->Utilities->propertyExists($row->child,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'value','['.__METHOD__.'] Property `value` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'type','['.__METHOD__.'] Property `type` doesn\'t exists in row->child object!');
        self::setId($row->child->id_db);
        self::setCommand($command,$row->child->id_db,'RowChild');
    }
    private function set_checkbox(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row->property);
        $this->Utilities->propertyExists($row,'child','['.__METHOD__.'] Property `child` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row->child,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'value','['.__METHOD__.'] Property `value` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'type','['.__METHOD__.'] Property `type` doesn\'t exists in row->child object!');
        self::setId($row->child->id_db);
        self::setCommand($command,$row->child->id_db,'RowChild');
    }
    private function setData():void{
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            //$this->inpArray['id'] = random_int(1000000000, 1099511627776);
            $this->Model->{'Form_stage'}->beginTransaction(); //PHP 5.1 and new
            /*
             * SET: STAGE, SECTION, SUBSECTION, ROW
             */
            self::setStage($this->command);
            /* Must BEFORE COMMIT, OTHERWISE LAST ID = 0 */
            $this->Model->{'Form_stage'}->commit();  //PHP 5 and new
        }
	catch (\PDOException $e){
            $this->Model->{'Form_stage'}->rollback(); 
            throw New \Exception("DATABASE ERROR: ".$e->getMessage(),1); 
	}
        //$this->{$this->task['stage']}();
    }
    private function setError():void{
        $this->Log->log(0,"[".__METHOD__."]");
        Throw New \Exception ($this->msg,$this->error_lvl);
    }
    private function setId(mixed &$id=0):void{
        $this->Log->log(0,"[".__METHOD__."]");        
        $type = gettype($id);
        $this->Log->log(0,"TYPE - ".$type);
        $this->Log->log(0,"ID DATA:");
        $this->Log->logMulti(0,$id);
        if($type==='string'){
            $this->Log->log(0,"CONVERT TYPE - ".$type." TO INTEGER 10");
            $id = intval($id,10);
            $type = 'integer';
        }
        if($type!=='integer'){
            Throw New \Exception ('['.__METHOD__.'] Wrong ID data type - '.$type,0);
        }
    }
    private function setStage(object $command){
        $this->Log->log(0,"[".__METHOD__."]");        
        foreach($this->data->stage as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s);
            $this->Log->log(0,"[".__METHOD__."] ID DB STAGE - ".$s->id_db);
            self::setSection($command->{$k}->{'section'},$s->section,$s->id_db);
        }
    }
    private function setSection(object $command,object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
         /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_stage_section'}->setNewVersion($id_parent);
        foreach($section as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SECTION - ".$s->id_db);
            self::setSubsection($command->{$k}->{'subsection'},$s->subsection,$s->id_db);
        }
    }
    private function setSubsection(object $command,object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_stage_subsection'}->setNewVersion($id_parent);
        foreach($subsection as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SUBSECTION - ".$s->id_db);
            self::setRow($command->{$k}->{'row'},$s->row,$s->id_db);
        }
    }
    private function setRow(object $command,object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_stage_row'}->setNewVersion($id_parent);
        foreach($row as $k => &$r){
            $this->Log->logMulti(0,$r);
            self::{$command->{$k}->{'run'}}($r,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB ROW - ".$r->id_db);
            self::setRowChild($command->{$k}->{'rowchild'},$r,$id_parent);
        }
    }
    private function setRowChild(object $command,object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
        self::{$command->{'run'}}($row,$id_parent);
    }
    private function insertStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_stage'}->insert($stage);
        $stage->id_db = $this->Model->{'Form_stage'}->lastInsertId();
        $this->stage_id = $stage->id_db;
        //self::setCreateUser();
    }
    private function updateStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * UPDATE WITH DELETE_STATUS = 0
         */
        $this->Model->{'Form_stage'}->update($stage);
        $this->stage_id = $stage->id_db;
    }
    private function insertSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage_section'}->insert($section,$id_parent);
        $section->id_db = $this->Model->{'Form_stage_section'}->lastInsertId();
    }
    private function updateSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage_section'}->update($section);
    }
    private function insertSubsection(object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_subsection'}->insert($subsection,$id_parent);
        $subsection->id_db = $this->Model->{'Form_stage_subsection'}->lastInsertId();
    }
    private function updateSubsection(object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_subsection'}->update($subsection);
    }
    private function insertRow(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_row'}->insert($row,$id_parent);
        $row->id_db = $this->Model->{'Form_stage_row'}->lastInsertId();
        self::insertRowProperty($row);
        self::insertRowStyle($row);
        self::{'insertRow_'.$row->type}($row);  
    }
    private function updateRow(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_row'}->update($row);
        self::insertRowProperty($row);
        self::insertRowStyle($row);
        self::{'updateRow_'.$row->type}($row);  
    }
    private function insertRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_stage_row'}->insertChild($row->{'child'},$id_parent,$row->id_db);
        $row->{'child'}->id_db = $this->Model->{'Form_stage_row'}->lastInsertId();
    }
    private function updateRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Log->logMulti(0,$row->{'child'});
        $this->Model->{'Form_stage_row'}->updateChild($row->{'child'});
    }
    private function noRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
    }
    private function insertRowProperty(object $row):void{
        $this->Model->{'Form_stage_row'}->deleteProperty($row->id_db);
        foreach($row->property as $name => $value){
            $this->Model->{'Form_stage_row'}->insertProperty($row->id_db,$name,$value);
        }
    }
    private function insertRowStyle(object $row):void{
        $this->Model->{'Form_stage_row'}->deleteStyle($row->id_db);
        foreach($row->style as $name => $value){
            $this->Model->{'Form_stage_row'}->insertStyle($row->id_db,$name,$value);
        }
    }
    private function insertRowGlossary(object $row):void{
        $this->Model->{'Form_stage_row'}->deleteGlossary($row->id_db);
        $this->Model->{'Form_stage_row'}->insertGlossary($row->glossary,$row->id_db);
    }
    //private function setCreateUser(){
     //   $this->data->user->create_date = date("Y-m-d H:i:s");
    //    $this->data->user->create_user_email = $_SESSION['mail'];
    //    $this->data->user->create_user_login = $_SESSION['username'];
   // }
    private function setUser(){
        $this->data->user = $this->Model->{'Form_stage'}->getStageUserById($this->stage_id);
    }
    private function get(){
        $this->Log->log(0,"[".__METHOD__."]");   
        /*
         * TO FIX - GET FROM DATABASE
         */
        //$this->stage_id = $stage->id_db;
        self::setUser();
        return $this->data;
    }//        
    private function insertRow_text(object $row){
        
    }
    private function updateRow_text(object $row){
        
    }
    private function insertRow_input(object $row){
        
    }
    private function updateRow_input(object $row){
        
    }
    private function insertRow_select(object $row){
        self::insertRowGlossary($row);
    }
    private function updateRow_select(object $row){
        self::insertRowGlossary($row);
    }
    private function insertRow_checkbox(object $row){
        
    }
    private function updateRow_checkbox(object $row){
        
    }
    private function insertRow_radio(object $row){
        
    }
    private function updateRow_radio(object $row){
        
    }
}