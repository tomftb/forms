<?php
/**
 * Description of Forms_stage_controller
 *
 * @author tomborc
 */
 final class Form_stage_create_controller extends Base_controller {

    private ?string $throw = 'setData';// setData//setError
    private ?array $task = [
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
    ];
    private ?int $error_lvl=0;

    private ?string $msg = 'Nie wprowadzono danych';
    
    private ?object $Utilities;
    
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Utilities = new Utilities();
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
        foreach($data->stage as &$s){
            self::stage($s);
        }
        /*
         * COMMAND
         */
        $this->{$this->throw}();
        
    }
    private function stage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->logMulti(0,$stage);
        /*
         * property:
         * id
         * section
         */
        $this->Utilities->propertyExists($stage,'id','['.__METHOD__.']Property `id` not exists in object!');
        $this->Utilities->propertyExists($stage,'section','['.__METHOD__.']Property `section` not exists in object!');
        $this->Log->logMulti(0,$stage->id);
        self::setId($stage->id);
        self::setTask($stage->id,$this->task['stage'],'Stage');
        foreach($stage->section as &$s){
            self::section($s);
        }
    }
    private function section(object &$section){
        //$this->Log->logMulti(0,$section);
        /*
         * property:
         * id
         * subsection
         */
        $this->Utilities->propertyExists($section,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($section,'subsection','Dodaj kolumnę',0);
        self::setId($section->id);
        self::setTask($section->id,$this->task['section'],'Section');
        foreach($section->subsection as &$s){
            self::subsection($s);
        }
    }
    private function subsection(object $subsection){
        //$this->Log->logMulti(0,$subsection);
        $this->Utilities->propertyExists($subsection,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($subsection,'row','Dodaj dane do kolumny',0);
        self::setId($subsection->id);
        self::setTask($subsection->id,$this->task['subsection'],'Subsection');
        foreach($subsection->row as &$r){
            self::row($r);
        }
    }
    private function row(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'type','['.__METHOD__.'] Property `type` not exists in object!');
        $this->Utilities->propertyExists($row,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($row,'property','['.__METHOD__.'] Property `property` not exists in object!');
        $this->Utilities->propertyExists($row,'style','['.__METHOD__.'] Property `style` not exists in object!');
        $this->Utilities->propertyExists($row,'value','['.__METHOD__.'] Property `value` not exists in object!');
        $this->Utilities->propertyExists($row,'name','['.__METHOD__.'] Property `name` not exists in object!');
        self::setId($row->id);
        self::setTask($row->id,$this->task['row'],'Row');
        /*
         * SET:
         * text
         * input
         * select
         * checkbox
         * radio
         */
        self::{"set_".$row->type}($row);
        $this->throw='setData';
    }
    private function set_text(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_input(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_select(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_radio(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function set_checkbox(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
    }
    private function setData():void{
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            //$this->inpArray['id'] = random_int(1000000000, 1099511627776);
            $this->Model->{'Form_stage'}->beginTransaction(); //PHP 5.1 and new
            /*
             * SET: STAGE, SECTION, SUBSECTION, ROW
             */
            self::setStage();
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
    private function setTask(int $id=0, array &$task = [], string $sufix = 'Stage'):void{//'Stage'
        $this->Log->log(0,"[".__METHOD__."] SET TASK FOR - ".$sufix);        
        if($id===0){
            /* 
             * INSERT
             */
            $this->Log->log(0,"INSERT");
            $task[$id] = 'insert'.$sufix;
        }
        else{
            /*
             * UPDATE
             */
            $this->Log->log(0,"UPDATE");
            $task[$id] = 'update'.$sufix;
        }
    }
    private function setStage(){
        $this->Log->log(0,"[".__METHOD__."]");        
        foreach($this->data->stage as &$s){
            $this->Log->logMulti(0,$s);
            self::{$this->task['stage'][$s->id]}($s);
            $this->Log->log(0,"[".__METHOD__."] ID DB STAGE - ".$s->id);
            self::setSection($s->id,$s->section);
        }
    }
    private function setSection(int $id_parent=0,object &$section){
        
        foreach($section as &$s){
            $this->Log->logMulti(0,$s);
            self::{$this->task['section'][$s->id]}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SECTION - ".$s->id);
            self::setSubsection($s->id,$s->subsection);
        }
    }
    private function setSubsection(int $id_parent=0,object &$subsection){
        
        foreach($subsection as &$s){
            $this->Log->logMulti(0,$s);
            self::{$this->task['subsection'][$s->id]}($s,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB SUBSECTION - ".$s->id);
            self::setRow($s->id,$s->row);
        }
    }
    private function setRow(int $id_parent=0,object &$row){
        
        foreach($row as &$r){
            $this->Log->logMulti(0,$r);
            self::{$this->task['row'][$r->id]}($r,$id_parent);
            $this->Log->log(0,"[".__METHOD__."] ID DB ROW - ".$r->id);

        }
    }
    private function insertStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage'}->insert($stage);
        $stage->id = $this->Model->{'Form_stage'}->lastInsertId();
        self::setCreateUser();
    }
    private function updateStage(object &$stage){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage'}->update($stage);
        //self::setCreateUser();
    }
    private function insertSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage_section'}->insert($section,$id_parent);
        $section->id = $this->Model->{'Form_stage_section'}->lastInsertId();
    }
    private function updateSection(object &$section,int $id_parent=0){
        $this->Log->log(0,"[".__METHOD__."]");        
        $this->Model->{'Form_stage_section'}->update($section);
        
    }
    private function insertSubsection(object &$subsection,int $id_parent=0){
        $this->Model->{'Form_stage_subsection'}->insert($subsection,$id_parent);
        $subsection->id = $this->Model->{'Form_stage_subsection'}->lastInsertId();
    }
    private function updateSubsection(object &$subsection,int $id_parent=0){
        $this->Model->{'Form_stage_subsection'}->update($subsection);
    }
    private function insertRow(object &$row,int $id_parent=0){
        $this->Model->{'Form_stage_row'}->insert($row,$id_parent);
        $row->id = $this->Model->{'Form_stage_row'}->lastInsertId();
    }
    private function updateRow(object &$row,int $id_parent=0){
        $this->Model->{'Form_stage_row'}->update($row);
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
}