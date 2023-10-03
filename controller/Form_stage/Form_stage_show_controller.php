<?php
final class Form_stage_show_controller extends Base_controller {
    
    private ?int $id_db=0;
    private ?object $create_user;
    private ?array $stage_data;
    
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Model->{'Form_stage_section'}=new \Form_stage_section_model();
        $this->Model->{'Form_stage_subsection'}=new \Form_stage_subsection_model();
        $this->Model->{'Form_stage_row'}=new \Form_stage_row_model();
        $this->Controller->{'Form_stage_controller'}=new \Form_stage_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    private function setCreateUser(){
        $this->create_user = new stdClass();
        $this->create_user->{'create_user_login'} = $this->stage_data[0]->{'create_user_login'};
        $this->create_user->{'create_user_email'} = $this->stage_data[0]->{'create_user_email'};
        $this->create_user->{'create_date'} = $this->stage_data[0]->{'create_date'};
    }
    public function getFormStageShowData(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->log(0,$_GET);
        $this->id_db = filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->Controller->{'Form_stage_controller'}->exists($this->id_db);
        self::setData();
        parent::returnJson(
                [
                    'id_db'=>$this->id_db
                    ,'user'=>$this->create_user
                    ,'stage'=>$this->stage_data
                    ,'parameters'=>$this->Controller->{'Form_stage_controller'}->getParameters()   
                ]
        );
    }
    private function setData(){
        $this->Log->log(0,"[".__METHOD__."]");
        self::setStage();
        self::setCreateUser();
    }    
    private function setStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->stage_data = $this->Model->{'Form_stage'}->get($this->id_db);
        foreach($this->stage_data as &$stage){
            self::setSection($stage);
        }
    }
    private function setSection(object &$stage):void{
        $this->Log->log(0,"[".__METHOD__."]");
        $stage->{'section'} = new stdClass();
        $stage->{'section'} = $this->Model->{'Form_stage_section'}->getByIdParent($stage->{'id_db'});
        foreach($stage->{'section'} as &$section){
            self::setSubsection($section);
        }
    }
    private function setSubsection(object &$section){
        $this->Log->log(0,"[".__METHOD__."]");
        $section->{'subsection'} = new stdClass();
        $section->{'subsection'} = $this->Model->{'Form_stage_subsection'}->getByIdParent($section->{'id_db'});
        foreach($section->{'subsection'} as &$subsection){
            self::setRow($subsection);
        }
    }
    private function setRow(object &$subsection){
        $this->Log->log(0,"[".__METHOD__."]");
        $subsection->{'row'} = new stdClass();
        $subsection->{'row'} = $this->Model->{'Form_stage_row'}->getByIdParent($subsection->{'id_db'});
        $this->Log->logMulti(0,$subsection->{'row'});
        foreach($subsection->{'row'} as &$row){
            $row->{'property'} = new stdClass();
            $row->{'style'} = new stdClass();
            self::{'setRow_'.$row->{'type'}}($row);
        }
       
    }
    private function setRow_text(object &$row){
        
    }
    private function setRow_input(object &$row){
        
    }
    private function setRow_select(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'glossary'} = new stdClass();
        $row->{'glossary'} = $this->Model->{'Form_stage_row'}->getGlossaryByIdRow($row->id_db);
    }
    private function setRow_checkbox(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'child'} = $this->Model->{'Form_stage_row'}->getChild($row->id_db);
    }
    private function setRow_radio(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'child'} = $this->Model->{'Form_stage_row'}->getChild($row->id_db);
    }
    private function getRowchild(){
        
    }
}