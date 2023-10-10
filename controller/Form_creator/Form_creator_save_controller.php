<?php

 final class Form_creator_save_controller extends Base_controller {
    private ?string $set = 'setError';// setChosenData//setError
    private ?object $Utilities;
    private ?object $command;
    private ?int $error_lvl=0;
    private ?string $msg = 'Nie wskazano żadnego bloku danych';
    private $data;
    
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities = new Utilities();
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Model->{'Form'}=new \Form_model();
        $this->Model->{'Form_chosen_stage'}=new \Form_chosen_stage_model();
        $this->Model->{'Form_chosen_stage_section'}=new \Form_chosen_stage_section_model();
        $this->Model->{'Form_chosen_stage_subsection'}=new \Form_chosen_stage_subsection_model();
        $this->Model->{'Form_chosen_stage_row'}=new \Form_chosen_stage_row_model();
        $this->Controller->{'Department'}=new \Department_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function saveForm(){
        $this->Log->log(0,"[".__METHOD__."]");
        
        $this->data = json_decode(filter_input(INPUT_POST,'data'));
        if(json_last_error()){
            throw new \exception("[".__METHOD__."] json error - ".json_last_error_msg(),1);
        }
         /*
         * CHECK AND SET TASK:
         * insert
         * update
         */
        self::chosenForm();
        /*
         * COMMAND
         */
        $this->{$this->set}();
        /*
         * GET FORM DATA
         */
        $form =  $this->Model->{'Form'}->getById($this->data->id_db);
        //var_dump($form);
        $this->data->{'create_user_login'}=$form['cul'];
        $this->data->{'create_user_email'}=$form['cue'];
        $this->data->{'create_date'}=$form['cd'];
        $this->data->{'mod_user_email'}=$form['mue'];
        $this->data->{'mod_user_login'}=$form['mul'];
        $this->data->{'mod_date'}=$form['md'];
        parent::returnJson(
                $this->data
        );
    }
    private function setCommand(object &$command, int $id=0,string $sufix = 'ChosenStage'):void{//'Stage'
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
    private function chosenForm(){
        $this->Utilities->propertyExists($this->data,'stage','Property `stage` not exists in `post` object!');
        $this->Utilities->propertyExists($this->data,'department_id','Property `department_id` not exists in `post` object!');
        $this->Utilities->propertyExists($this->data,'department_name','Property `department_name` not exists in `post` object!');
        $this->Utilities->propertyExists($this->data,'title','Property `title` not exists in `post` object!');
        $this->Utilities->propertyExists($this->data,'id_db','Property `id_db` not exists in `post` object!');
        $this->Utilities->isValueEmpty($this->data->title,'Wprowadź tytuł',0);
        $this->Log->logMulti(0,$this->data);
        self::setId($this->data->id_db);
        $this->command = new stdClass();
        $this->command->{'form'} = new stdClass();
        $this->command->{'stage'} = new stdClass();
        self::setCommand($this->command->{'form'} ,$this->data->id_db,'ChosenForm');
        foreach($this->data->stage as $k => &$s){
            $this->command->{'stage'}->{$k} = new stdClass();
            self::chosenStage($this->command->{'stage'}->{$k},$s);
        }
    }
    private function chosenStage(object &$command,object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$stage);
        /*
         * property:
         * id
         * section
         */
        $this->Utilities->propertyExists($stage,'id','['.__METHOD__.'] Property `id` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'section','['.__METHOD__.'] Property `section` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'department_id','['.__METHOD__.'] Property `department_id` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'department_name','['.__METHOD__.'] Property `department_name` doesn\'t exists in object!');
        $this->Utilities->propertyExists($stage,'title','['.__METHOD__.'] Property `title` doesn\'t exists in object!');
        $this->Log->logMulti(0,$stage->id_db);
        self::setId($stage->id_db);
        $command->{'run'} = '';
        $command->{'section'} = new stdClass();
        self::setCommand($command,$stage->id_db,'ChosenStage');
        foreach($stage->section as $k => &$s){
            $command->{'section'}->{$k} = new stdClass();
            self::chosenSection($command->{'section'}->{$k},$s);
        }
    }
    private function chosenSection(object &$command,object &$section){
        //$this->Log->logMulti(0,$section);
        /*
         * property:
         * id
         * subsection
         */
        $this->Utilities->propertyExists($section,'id','['.__METHOD__.'] Property `id` doesn\'t exists in object!');
        $this->Utilities->propertyExists($section,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($section,'subsection','Dodaj kolumnę',0);
        self::setId($section->id_db);
        $command->{'run'} = '';
        $command->{'subsection'} = new stdClass();
        self::setCommand($command,$section->id_db,'ChosenSection');
        foreach($section->subsection as $k => &$s){
            $command->{'subsection'}->{$k} = new stdClass();
            self::chosenSubsection($command->{'subsection'}->{$k},$s);
        }
    }
    private function chosenSubsection(object &$command,object $subsection){
        //$this->Log->logMulti(0,$subsection);
        $this->Utilities->propertyExists($subsection,'id','['.__METHOD__.'] Property `id` doesn\'t exists in object!');
        $this->Utilities->propertyExists($subsection,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($subsection,'row','Dodaj dane do kolumny',0);
        self::setId($subsection->id_db);
        $command->{'run'} = '';
        $command->{'row'} = new stdClass();
        //self::setTask($subsection->id_db,$this->task['subsection'],'Subsection');
        self::setCommand($command,$subsection->id_db,'ChosenSubsection');
        foreach($subsection->row as $k => &$r){
            $command->{'row'}->{$k} = new stdClass();
            self::chosenRow($command->{'row'}->{$k},$r);
        }
    }
    private function chosenRow(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'id','['.__METHOD__.'] Property `id` doesn\'t exists in row object!');
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
        $command->{'rowchild'}->{'run'} = 'noChosenRowChild';
        //self::setTask($row->id_db,$this->task['row'],'Row');
        self::setCommand($command,$row->id_db,'ChosenRow');
        /*
         * SET:
         * text
         * input
         * select
         * checkbox
         * radio
         */
        self::{"setChosen_".$row->type}($command->{'rowchild'},$row);
        $this->set='setChosenData';
    }
    private function setChosen_text(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function setChosen_input(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function setChosen_select(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'glossary','['.__METHOD__.'] Property `glossary` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row->glossary,'id_glossary','['.__METHOD__.'] Property `id_glossary` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'id_glossary_position','['.__METHOD__.'] Property `id_glossary_position` doesn\'t exists in row->glossary object!');
        $this->Utilities->propertyExists($row->glossary,'position_name','['.__METHOD__.'] Property `position_name` doesn\'t exists in row->glossary object!');
    }
    private function setChosen_radio(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'child','['.__METHOD__.'] Property `child` doesn\'t exists in row->property object!');
        $this->Utilities->propertyExists($row->child,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'value','['.__METHOD__.'] Property `value` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'type','['.__METHOD__.'] Property `type` doesn\'t exists in row->child object!');
        self::setId($row->child->id_db);
        self::setCommand($command,$row->child->id_db,'ChosenRowChild');
    }
    private function setChosen_checkbox(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row->property);
        $this->Utilities->propertyExists($row,'child','['.__METHOD__.'] Property `child` doesn\'t exists in row object!');
        $this->Utilities->propertyExists($row->child,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'value','['.__METHOD__.'] Property `value` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'name','['.__METHOD__.'] Property `name` doesn\'t exists in row->child object!');
        $this->Utilities->propertyExists($row->child,'type','['.__METHOD__.'] Property `type` doesn\'t exists in row->child object!');
        self::setId($row->child->id_db);
        self::setCommand($command,$row->child->id_db,'ChosenRowChild');
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
    private function setError():void{
        $this->Log->log(0,"[".__METHOD__."]");
        Throw New \Exception ($this->msg,$this->error_lvl);
    }
    private function setChosenData():void{
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            //$this->inpArray['id'] = random_int(1000000000, 1099511627776);
            $this->Model->{'Form'}->beginTransaction(); //PHP 5.1 and new
            self::{$this->command->{'form'}->{'run'}}($this->data);
            /*
             * SET: STAGE, SECTION, SUBSECTION, ROW
             */
            self::setChosenStage($this->command->{'stage'},$this->data->id_db);
            /* Must BEFORE COMMIT, OTHERWISE LAST ID = 0 */
            $this->Model->{'Form'}->commit();  //PHP 5 and new
        }
	catch (\PDOException $e){
            $this->Model->{'Form'}->rollback(); 
            //$this->Log->logMulti(0,$e->getTrace());
            throw New \Exception("DATABASE ERROR: ".$e->getMessage(),1); 
	}
        //$this->{$this->task['stage']}();
    }
    private function setChosenStage(object $command,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."] id form - ".$id_parent);   
        foreach($this->data->stage as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB STAGE - ".$s->id_db);
            //print_r($s->section);
            self::setChosenSection($command->{$k}->{'section'},$s->section,$s->id_db);
        }
    }
    private function setChosenSection(object $command,object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."] id_parent - ".$id_parent);
         /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_chosen_stage_section'}->setNewVersion($id_parent);
        foreach($section as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SECTION - ".$s->id_db);
            self::setChosenSubsection($command->{$k}->{'subsection'},$s->subsection,$s->id_db);
        }
    }
    private function setChosenSubsection(object $command,object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_chosen_stage_subsection'}->setNewVersion($id_parent);
        foreach($subsection as $k => &$s){
            $this->Log->logMulti(0,$s);
            self::{$command->{$k}->{'run'}}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SUBSECTION - ".$s->id_db);
            self::setChosenRow($command->{$k}->{'row'},$s->row,$s->id_db);
        }
    }
    private function setChosenRow(object $command,object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."] id_parent - ".$id_parent);
        /*
         * SET DEFAULT DELETE_STATUS = 1
         */
        $this->Model->{'Form_chosen_stage_row'}->setNewVersion($id_parent);
        foreach($row as $k => &$r){
            $this->Log->logMulti(0,$r);
            self::{$command->{$k}->{'run'}}($r,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB ROW - ".$r->id_db);
            self::setChosenRowChild($command->{$k}->{'rowchild'},$r,$id_parent);
        }
    }
    private function setChosenRowChild(object $command,object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
        self::{$command->{'run'}}($row,$id_parent);
    }
    private function insertChosenForm(object &$form){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form'}->insert($form);
        $form->id_db = $this->Model->{'Form'}->lastInsertId();
    }
    private function updateChosenForm(object &$form){
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * UPDATE WITH DELETE_STATUS = 0
         */
        $this->Model->{'Form'}->update($form);
    }
    private function insertChosenStage(object &$stage,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_chosen_stage'}->insert($stage,$id_parent);
        $stage->id_db = $this->Model->{'Form_chosen_stage'}->lastInsertId();
    }
    private function updateChosenStage(object &$stage,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * UPDATE WITH DELETE_STATUS = 0
         */
        $this->Model->{'Form_chosen_stage'}->update($stage,$id_parent);
    }
    private function insertChosenSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."] id_parent - ".$id_parent);
        $this->Log->logMulti(2,$section);
        $this->Model->{'Form_chosen_stage_section'}->insert($section,$id_parent);
        $section->id_db = $this->Model->{'Form_chosen_stage_section'}->lastInsertId();
    }
    private function updateChosenSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_chosen_stage_section'}->update($section);
    }
    private function insertChosenSubsection(object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$subsection);
        $this->Model->{'Form_chosen_stage_subsection'}->insert($subsection,$id_parent);
        $subsection->id_db = $this->Model->{'Form_chosen_stage_subsection'}->lastInsertId();
    }
    private function updateChosenSubsection(object &$subsection,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_chosen_stage_subsection'}->update($subsection);
    }
    private function insertChosenRow(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."] id parent - ".$id_parent);  
        $this->Log->logMulti(0,$row);
        $this->Model->{'Form_chosen_stage_row'}->insert($row,$id_parent);
        $row->id_db = $this->Model->{'Form_chosen_stage_row'}->lastInsertId();
        self::insertChosenRowProperty($row);
        self::insertChosenRowStyle($row);
        self::{'insertChosenRow_'.$row->type}($row);  
    }
    private function updateChosenRow(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_chosen_stage_row'}->update($row);
        self::insertChosenRowProperty($row);
        self::insertChosenRowStyle($row);
        self::{'updateChosenRow_'.$row->type}($row);  
    }
    private function insertChosenRowProperty(object $row):void{
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_chosen_stage_row'}->deleteProperty($row->id_db);
        foreach($row->property as $name => $value){
            $this->Model->{'Form_chosen_stage_row'}->insertProperty($row->id_db,$name,$value);
        }
    }
    private function insertChosenRowStyle(object $row):void{
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_chosen_stage_row'}->deleteStyle($row->id_db);
        foreach($row->style as $name => $value){
            $this->Model->{'Form_chosen_stage_row'}->insertStyle($row->id_db,$name,$value);
        }
    }
    private function insertChosenRowGlossary(object $row):void{
        $this->Log->log(0,"[".__METHOD__."] row->id_db - ".$row->id_db); 
        $this->Log->logMulti(0,$row->glossary); 
        $this->Model->{'Form_chosen_stage_row'}->deleteGlossary($row->id_db);
        $this->Model->{'Form_chosen_stage_row'}->insertGlossary($row->glossary,$row->id_db);
    }
    private function noChosenRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
    }
    private function insertChosenRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_chosen_stage_row'}->insertChild($row->{'child'},$id_parent,$row->id_db);
        $row->{'child'}->id_db = $this->Model->{'Form_chosen_stage_row'}->lastInsertId();
    }
    private function updateChosenRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Log->logMulti(0,$row->{'child'});
        $this->Model->{'Form_chosen_stage_row'}->updateChild($row->{'child'});
    }
    private function insertChosenRow_text(object $row){
        
    }
    private function updateChosenRow_text(object $row){
        
    }
    private function insertChosenRow_input(object $row){
        
    }
    private function updateChosenRow_input(object $row){
        
    }
    private function insertChosenRow_select(object $row){
        $this->Log->log(0,"[".__METHOD__."]");   
        self::insertChosenRowGlossary($row);
    }
    private function updateChosenRow_select(object $row){
        $this->Log->log(0,"[".__METHOD__."]");   
        self::insertChosenRowGlossary($row);
    }
    private function insertChosenRow_checkbox(object $row){
        
    }
    private function updateChosenRow_checkbox(object $row){
        
    }
    private function insertChosenRow_radio(object $row){
        
    }
    private function updateChosenRow_radio(object $row){
        
    }
}