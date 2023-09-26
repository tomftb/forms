<?php
/**
 * Description of Forms_stage_controller
 *
 * @author tomborc
 */
 final class Form_stage_create_controller extends Base_controller {

    private ?string $set = 'setData';// setData//setError
    private ?object $command;
    /*
            [
        'stage'=>[
            0=>'Stage'//Stage
        ]
        ,'section'=>[
            0=>'Section'//Section
        ]
        ,'subsection'=>[
            0=>'Subsection'//Subsection
        ]
        ,'row'=>[
            0=>'Row'//Row
        ]
        ,'row_child'=>[
            0=>'Row'//Row
        ]
    ];*/
    private ?int $error_lvl=0;

    private ?string $msg = 'Nie wprowadzono danych';
    
    private ?object $Utilities;
    
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
    public function create(object $data){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->data = $data;
        //$this->Log->logMulti(0,$data);
        $this->Utilities->propertyExists($data,'stage');
        /*
         * CHECK AND SET TASK:
         * insert
         * update
         */

        foreach($data->stage as $k => &$s){
            //print_r($data->stage->{$k});
            $this->command->{$k} = new stdClass();
            self::stage($this->command->{$k},$s);
        }
        /*
         * COMMAND
         */
         
        //print_r($this->command);
        //die();
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
        //$this->Log->logMulti(0,$stage);
        /*
         * property:
         * id
         * section
         */
        $this->Utilities->propertyExists($stage,'id_db','['.__METHOD__.']Property `id_db` not exists in object!');
        $this->Utilities->propertyExists($stage,'section','['.__METHOD__.']Property `section` not exists in object!');
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
        $this->Utilities->propertyExists($section,'id_db','['.__METHOD__.'] Property `id_db` not exists in object!');
        $this->Utilities->propertyExists($section,'subsection','Dodaj kolumnę',0);
        self::setId($section->id_db);
        $command->{'run'} = '';
        $command->{'subsection'} = new stdClass();
        //self::setTask($section->id_db,$this->task['section'],'Section');
        self::setCommand($command,$section->id_db,'Section');
        foreach($section->subsection as $k => &$s){
            $command->{'subsection'}->{$k} = new stdClass();
            self::subsection($command->{'subsection'}->{$k},$s);
        }
    }
    private function subsection(object &$command,object $subsection){
        //$this->Log->logMulti(0,$subsection);
        $this->Utilities->propertyExists($subsection,'id_db','['.__METHOD__.'] Property `id_db` not exists in object!');
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
        $this->Utilities->propertyExists($row,'type','['.__METHOD__.'] Property `type` not exists in row object!');
        $this->Utilities->propertyExists($row,'id_db','['.__METHOD__.'] Property `id_db` not exists in row object!');
        $this->Utilities->propertyExists($row,'property','['.__METHOD__.'] Property `property` not exists in row object!');
        $this->Utilities->propertyExists($row,'style','['.__METHOD__.'] Property `style` not exists in row object!');
        $this->Utilities->propertyExists($row,'value','['.__METHOD__.'] Property `value` not exists in row object!');
        $this->Utilities->propertyExists($row,'name','['.__METHOD__.'] Property `name` not exists in row object!');
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
    }
    private function set_radio(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row->property,'label','['.__METHOD__.'] Property `label` not exists in row->property object!');
        $this->Utilities->propertyExists($row->property->label,'id_db','['.__METHOD__.'] Property `id_db` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'value','['.__METHOD__.'] Property `value` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'name','['.__METHOD__.'] Property `name` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'type','['.__METHOD__.'] Property `type` not exists in row->property->label object!');
        self::setId($row->property->label->id_db);
        self::setCommand($command,$row->property->label->id_db,'RowChild');
    }
    private function set_checkbox(object &$command,object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row->property);
        $this->Utilities->propertyExists($row->property,'label','['.__METHOD__.'] Property `label` not exists in row->property object!');
        $this->Utilities->propertyExists($row->property->label,'id_db','['.__METHOD__.'] Property `od_db` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'value','['.__METHOD__.'] Property `value` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'name','['.__METHOD__.'] Property `name` not exists in row->property->label object!');
        $this->Utilities->propertyExists($row->property->label,'type','['.__METHOD__.'] Property `type` not exists in row->property->label object!');
        self::setId($row->property->label->id_db);
        self::setCommand($command,$row->property->label->id_db,'RowChild');
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
        //$this->Log->log(0,$command);
        //$this->Log->log(0,$row);
        
        //print_r($command);
        //print_r($row);
        self::{$command->{'run'}}($row,$id_parent);
        //die();
    }
    private function insertStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_stage'}->insert($stage);
        $stage->id_db = $this->Model->{'Form_stage'}->lastInsertId();
        self::setCreateUser();
    }
    private function updateStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");
        /*
         * UPDATE WITH DELETE_STATUS = 0
         */
        $this->Model->{'Form_stage'}->update($stage);
        //self::setCreateUser();
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
        //self::{'insertRow_'.$row->type}($row);  
    }
    private function updateRow(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_row'}->update($row);
        //self::{'updateRow_'.$row->type}($row);  
    }
    private function insertRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");      
        $this->Model->{'Form_stage_row'}->insertChild($row->{'property'}->{'label'},$id_parent,$row->id_db);
        $row->{'property'}->{'label'}->id_db = $this->Model->{'Form_stage_row'}->lastInsertId();
       // $row->id_db = $this->Model->{'Form_stage_row'}->lastInsertId();
        //self::{'insertRow_'.$row->type}($row);  
    }
    private function updateRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
        $this->Model->{'Form_stage_row'}->updateChild($row->{'property'}->{'label'});
       // $this->Model->{'Form_stage_row'}->update($row);
        //self::{'updateRow_'.$row->type}($row);  
    }
    private function noRowChild(object &$row,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");   
       // $this->Model->{'Form_stage_row'}->update($row);
        //self::{'updateRow_'.$row->type}($row);  
    }
    private function setCreateUser(){
        $this->data->user->create_date = date("Y-m-d H:i:s");
        $this->data->user->create_user_email = $_SESSION['mail'];
        $this->data->user->create_user_login = $_SESSION['username'];
    }
    public function get(){
        /*
         * TO FIX - GET FROM DATABASE
         */
        return $this->data;
    }
    //private function insertRow_text(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
    //}
   // private function insertRow_input(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
   // }
   // private function insertRow_select(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
    //}
   // private function insertRow_checkbox(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
     //   $this->Log->log(0,$row);  
     //   die();
   // }
   // private function insertRow_radio(object &$row){
   //     $this->Log->log(0,"[".__METHOD__."]");   
   // }
   // private function updateRow_text(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
   // }
   // private function updateRow_input(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
    //}
   // private function updateRow_select(object &$row){
   //     $this->Log->log(0,"[".__METHOD__."]");   
   // }
   // private function updateRow_checkbox(object &$row){
    //    $this->Log->log(0,"[".__METHOD__."]");   
    //    $this->Log->log(0,$row);  
    //    die();
   // }
   // private function updateRow_radio(object &$row){
   //     $this->Log->log(0,"[".__METHOD__."]");   
   // }
}