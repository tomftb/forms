<?php
final class Form_stage_get_controller extends Base_controller {
    private ?array $stage_data;
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Model->{'Form_stage_section'}=new \Form_stage_section_model();
        $this->Model->{'Form_stage_subsection'}=new \Form_stage_subsection_model();
        $this->Model->{'Form_stage_row'}=new \Form_stage_row_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function get(string|int $id_db=0){
        try{
            $this->id_db = $id_db;
            self::setStage();
            return $this->stage_data;
        }
        catch(\Exception $e){
            Throw New \Exception($e->getMessage(),1);
        }
    }
    public function getAll(){
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            $this->stage_data = $this->Model->{'Form_stage'}->getAvailableList();
            foreach($this->stage_data as &$stage){
                self::setSection($stage);
            }
            return $this->stage_data;
        }
        catch(\Exception $e){
            Throw New \Exception($e->getMessage(),1);
        }
    }
    public function getAllNoId(){
        $this->Log->log(0,"[".__METHOD__."]");
        try{
            $this->stage_data = $this->Model->{'Form_stage'}->getAvailableListNoIdDb();
            foreach($this->stage_data as &$stage){
                self::setSectionNoIdDb($stage);
            }
            return $this->stage_data;
        }
        catch(\Exception $e){
            Throw New \Exception($e->getMessage(),1);
        }
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
        foreach($this->Model->{'Form_stage_section'}->getByIdParent($stage->{'id_db'}) as $k => $section){
            $stage->{'section'}->{$k}=new stdClass();
            $stage->{'section'}->{$k} = $section;
            self::setSubsection($section);
        }
    }
    private function setSectionNoIdDb(object &$stage):void{
        $this->Log->log(0,"[".__METHOD__."]");
        $stage->{'section'} = new stdClass();
        foreach($this->Model->{'Form_stage_section'}->getNoIdDbByIdParent($stage->{'id'}) as $k => $section){
            $stage->{'section'}->{$k}=new stdClass();
            $stage->{'section'}->{$k} = $section;
            self::setSubsectionNoIdDb($section);
        }
    }
    private function setSubsection(object &$section){
        $this->Log->log(0,"[".__METHOD__."]");
        $section->{'subsection'} = new stdClass();
        foreach($this->Model->{'Form_stage_subsection'}->getByIdParent($section->{'id_db'}) as $k => $subsection){
            $section->{'subsection'}->{$k} = new stdClass();
            $section->{'subsection'}->{$k}=$subsection;
            self::setRow($subsection);
        }
    }
    private function setSubsectionNoIdDb(object &$section){
        $this->Log->log(0,"[".__METHOD__."]");
        $section->{'subsection'} = new stdClass();
        foreach($this->Model->{'Form_stage_subsection'}->getNoIdDbByIdParent($section->{'id'}) as $k => $subsection){
            $section->{'subsection'}->{$k} = new stdClass();
            $section->{'subsection'}->{$k}=$subsection;
            self::setRowNoIdDb($subsection);
        }
    }
    private function setRow(object &$subsection){
        $this->Log->log(0,"[".__METHOD__."]");
        $subsection->{'row'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getByIdParent($subsection->{'id_db'}) as $k => $row){
            $subsection->{'row'}->{$k}=new stdClass();
            $subsection->{'row'}->{$k}=$row;
            $subsection->{'row'}->{$k}->{'property'} = new stdClass();
            $subsection->{'row'}->{$k}->{'style'} = new stdClass();
            
            self::{'setRow_'.$row->{'type'}}($subsection->{'row'}->{$k});
        }
       
    }
    private function setRowNoIdDb(object &$subsection){
        $this->Log->log(0,"[".__METHOD__."]");
        $subsection->{'row'} = new stdClass();
        $this->Log->logMulti(0,$subsection->{'row'});
        foreach($this->Model->{'Form_stage_row'}->getNoIdDbByIdParent($subsection->{'id'}) as $k => $row){
            $subsection->{'row'}->{$k}=new stdClass();
            $subsection->{'row'}->{$k}=$row;
            $subsection->{'row'}->{$k}->{'property'} = new stdClass();
            $subsection->{'row'}->{$k}->{'style'} = new stdClass();
            self::{'setRowNoIdDb_'.$row->{'type'}}($subsection->{'row'}->{$k});
        }
       
    }
    private function setRow_text(object &$row){
        
    }
    private function setRowNoIdDb_text(object &$row){
        
    }
    private function setRow_input(object &$row){
        
    }
    private function setRowNoIdDb_input(object &$row){
        
    }
    private function setRow_select(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'glossary'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getGlossaryByIdRow($row->id_db) as $k => $glossary){
            $row->{'glossary'}->{$k} = new stdClass();
            $row->{'glossary'}->{$k}= $glossary;
        }
    }
    private function setRowNoIdDb_select(object &$row){
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'glossary'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getGlossaryByIdRow($row->id) as $k => $glossary){
            $row->{'glossary'}->{$k} = new stdClass();
            $row->{'glossary'}->{$k}= $glossary;
        }
    }
    private function setRow_checkbox(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->log(0,$row);
        $row->{'child'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getChild($row->id_db) as $k => $child){
             $row->{'child'}->{$k} = new stdClass();
             $row->{'child'}->{$k} = $child;
        }
    }
    private function setRowNoIdDb_checkbox(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'child'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getChild($row->id) as $k => $child){
             $row->{'child'}->{$k} = new stdClass();
             $row->{'child'}->{$k} = $child;
        }
    }
    private function setRow_radio(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        $row->{'child'}=new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getChild($row->id_db) as $k => $child){
             $row->{'child'}->{$k} = new stdClass();
             $row->{'child'}->{$k} = $child;
        }
    }
    private function setRowNoIdDb_radio(object &$row){
        /*
         * GET AND SET CHILD
         */
        $this->Log->log(0,"[".__METHOD__."]");
        $row->{'child'} = new stdClass();
        foreach($this->Model->{'Form_stage_row'}->getChild($row->id) as $k => $child){
             $row->{'child'}->{$k} = new stdClass();
             $row->{'child'}->{$k} = $child;
        }
    }
    private function getRowchild(){
        
    }
}