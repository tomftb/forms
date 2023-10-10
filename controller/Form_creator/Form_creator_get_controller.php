<?php

 final class Form_creator_get_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form'}=new \Form_model();
        $this->Model->{'Form_chosen_stage'}=new \Form_chosen_stage_model();
        $this->Model->{'Form_chosen_stage_section'}=new \Form_chosen_stage_section_model();
        $this->Model->{'Form_chosen_stage_subsection'}=new \Form_chosen_stage_subsection_model();
        $this->Model->{'Form_chosen_stage_row'}=new \Form_chosen_stage_row_model();
        $this->Model->{'Form_chosen_stage_row_property'}=new \Form_chosen_stage_row_property_model();
        $this->Model->{'Form_chosen_stage_row_style'}=new \Form_chosen_stage_row_style_model();
        $this->Model->{'Form_chosen_stage_row_glossary'} = new \Form_chosen_stage_row_glossary_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function get(string|int $id=0):object{
        $this->Log->log(0,"[".__METHOD__."] id - ".$id);
        $form = new stdClass();
        //$this->Log->logMulti(0,$this->Model->{'Form'}->getById($id));
        foreach( $this->Model->{'Form'}->getById_2($id) as $k => $v){
            //$this->Log->logMulti(0,$v);
            $form=$v;
            $form->{'id_db'}=$form->{'id'};
            UNSET($form->{'id'});
            $form->{'title'}=$form->{'name'};
            UNSET($form->{'name'});
            $form->{'stage'}=new stdClass();
            $form->{'stage'}=self::getStage($form->{'id_db'});
            /*
             * ONLY ONE FORM
             */
            break;
        }
        return $form;
        //Throw New Exception ('Formularz o id `'.$id.'` został usunięty.',0); 
    }
    private function getStage(string|int $id_parent=0):object{
        $this->Log->log(0,"[".__METHOD__."] id_parent - ".$id_parent);
        $stage = new stdClass();
        $tmp_k='';
        foreach($this->Model->{'Form_chosen_stage'}->getListByIdParent($id_parent) as $k => $v){
            /*
             * r - ready
             */
            $this->Log->logMulti(0,$v);
            $tmp_k='r'.strval($k);
            $stage->{$tmp_k}=new stdClass();
            $stage->{$tmp_k} = $v;
            $stage->{$tmp_k}->{'id_db'}= intval($v->{'id'},10);
            //UNSET($stage->{'id'});
            $stage->{$tmp_k}->{'id'}=$v->{'id_form_stage'};
            UNSET($stage->{$tmp_k}->{'id_form_stage'});
            $stage->{$tmp_k}->{'section'}=new stdClass();
            $stage->{$tmp_k}->{'section'}=self::getSection($stage->{$tmp_k}->{'id_db'});
        }
        return $stage;
    }
    private function getSection(string|int $id_parent=0):object{
        $this->Log->log(0,"[".__METHOD__."] id_parent - ".$id_parent);
        (object) $section = new stdClass();
        (string) $tmp_k='';
        foreach($this->Model->{'Form_chosen_stage_section'}->getListByIdParent($id_parent) as $k => $v){
            $this->Log->logMulti(0,$v);
            $tmp_k=strval($k);
            $section->{$tmp_k}=new stdClass();
            $section->{$tmp_k} = $v;
            $section->{$tmp_k}->{'id_db'}= intval($v->{'id'},10);
            $section->{$tmp_k}->{'id'}=$v->{'id_form_stage_section'};
            UNSET($section->{$tmp_k}->{'id_form_stage_section'});
            $section->{$tmp_k}->{'subsection'}=new stdClass();
            $section->{$tmp_k}->{'subsection'}=self::getSubsection($section->{$tmp_k}->{'id_db'});
        }
        return $section;
    }
    private function getSubsection(string|int $id_parent=0):object{
        (object) $subsection = new stdClass();
        (string) $tmp_k='';
        foreach($this->Model->{'Form_chosen_stage_subsection'}->getListByIdParent($id_parent) as $k => $v){
            $this->Log->logMulti(0,$v);
            $tmp_k=strval($k);
            $subsection->{$tmp_k}=new stdClass();
            $subsection->{$tmp_k} = $v;
            $subsection->{$tmp_k}->{'id_db'}= intval($v->{'id'},10);
            $subsection->{$tmp_k}->{'id'}=$v->{'id_form_stage_subsection'};
            UNSET($subsection->{$tmp_k}->{'id_form_stage_subsection'});
            $subsection->{$tmp_k}->{'row'}=new stdClass();
            $subsection->{$tmp_k}->{'row'}=self::getRow($subsection->{$tmp_k}->{'id_db'});
        }
        return $subsection;
    }
    private function getRow(string|int $id_parent=0):object{
        (object) $row = new stdClass();
        (string) $tmp_k='';
         foreach($this->Model->{'Form_chosen_stage_row'}->getListByIdParent($id_parent) as $k => $v){
            $this->Log->logMulti(0,$v);
            $tmp_k=strval($k);
            $row->{$tmp_k}=new stdClass();
            $row->{$tmp_k} = $v;
            $row->{$tmp_k}->{'id_db'}= intval($v->{'id'},10);
            $row->{$tmp_k}->{'id'}=$v->{'id_form_stage_row'};
            UNSET($row->{$tmp_k}->{'id_form_stage_row'});
            $row->{$tmp_k}->{'property'}=new stdClass();
            $row->{$tmp_k}->{'property'}=self::getRowProperty($row->{$tmp_k}->{'id_db'});
            $row->{$tmp_k}->{'style'}=new stdClass();
            $row->{$tmp_k}->{'style'}=self::getRowStyle($row->{$tmp_k}->{'id_db'});
            self::{'getRow_'.$row->{$tmp_k}->{'type'}}($row->{$tmp_k});
            //$subsection->{$tmp_k}->{'row'}=new stdClass();
            //$subsection->{$tmp_k}->{'row'}=self::getRow($subsection->{$tmp_k}->{'id_db'});
        }
        return $row;
    }
    private function getRowProperty(string|int $id_parent=0):object{
        (object) $property = new stdClass();
        (string) $tmp_k='';
        foreach($this->Model->{'Form_chosen_stage_row_property'}->getListByIdParent($id_parent) as $k => $v){
            $this->Log->logMulti(0,$v);
            $tmp_k=strval($k);
            $row->{$tmp_k}=new stdClass();
            $row->{$tmp_k} = $v;
        }
        return $property;
    }
    private function getRowStyle(string|int $id_parent=0):object{
        (object) $style = new stdClass();
        (string) $tmp_k='';
         foreach($this->Model->{'Form_chosen_stage_row_style'}->getListByIdParent($id_parent) as $k => $v){
            $this->Log->logMulti(0,$v);
            $tmp_k=strval($k);
            $row->{$tmp_k}=new stdClass();
            $row->{$tmp_k} = $v;
        }
        return $style;
    }
    private function getRowChild(){
        
    }
    private function getRow_text(object &$row){}
    private function getRow_select(object &$row):void{
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Model->{'Form_chosen_stage_row_glossary'}
        (object) $row->{'glossary'} = new stdClass();
        $found = function(string|int $id_row=0){
            
        };
        $not_found = function(string|int $id_row=0){
            Throw new \Exception(__METHOD__.' form_chosen_stage_row_glossary with id_row - `'.$id_row.'` not exists in database!',1);
        };
        $check = &$not_found;

        foreach($this->Model->{'Form_chosen_stage_row_glossary'}->getListByIdParent($row->{'id_db'}) as $v){
            $this->Log->logMulti(0,$v);
            $row->{'glossary'}=$v;
            /*
             * ONLY FIRST
             */
            $check=&$found;
            break;
        }
        $check($row->{'id_db'});
    }
    private function getRow_input(object &$row){}
    private function getRow_radio(object &$row):void{
        $this->Log->log(0,"[".__METHOD__."]");
        (object) $row->{'child'} = new stdClass();
        $found = function(string|int $id_row=0){
            
        };
        $not_found = function(string|int $id_row=0){
            Throw new \Exception(__METHOD__.' form_chosen_stage_row with id - `'.$id_row.'` not exists in database!',1);
        };
        $check = &$not_found;
        foreach($this->Model->{'Form_chosen_stage_row'}->getChildByIdParent($row->{'id_db'}) as $v){
            $this->Log->logMulti(0,$v);
            $row->{'child'}=$v;
            /*
             * ONLY FIRST
             */
             $check=&$found;
            break;
        } 
        $check($row->{'id_db'});
    }
    private function getRow_checkbox(object &$row):void{
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Log->logMulti(0,$row);
        (object) $row->{'child'} = new stdClass();
        $found = function(string|int $id_row=0){
            
        };
        $not_found = function(string|int $id_row=0){
            Throw new \Exception(__METHOD__.' form_chosen_stage_row with id - `'.$id_row.'` not exists in database!',1);
        };
        $check = &$not_found;
        foreach($this->Model->{'Form_chosen_stage_row'}->getChildByIdParent($row->{'id_db'}) as  $v){
            $this->Log->logMulti(0,$v);
            $row->{'child'}=$v;
            /*
             * ONLY FIRST
             */
            $check=&$found;
            break;
        } 
        $check($row->{'id_db'});
    }
}