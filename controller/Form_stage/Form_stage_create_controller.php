<?php
/**
 * Description of Forms_stage_controller
 *
 * @author tomborc
 */
 final class Form_stage_create_controller extends Base_controller {

    private ?string $throw = 'setError';
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
        //$this->Log->logMulti(0,$data);
        $this->Utilities->propertyExists($data,'stage');
        foreach($data->stage as $s){
            self::stage($s);
        }
        
        $this->{$this->throw}();
    }
    private function stage(object $stage){
        //$this->Log->logMulti(0,$stage);
        /*
         * property:
         * id
         * section
         */
        $this->Utilities->propertyExists($stage,'id','['.__METHOD__.']Property `id` not exists in object!');
        $this->Utilities->propertyExists($stage,'section','['.__METHOD__.']Property `section` not exists in object!');

        foreach($stage->section as $s){
            self::section($s);
        }
    }
    private function section(object $section){
        //$this->Log->logMulti(0,$section);
        /*
         * property:
         * id
         * subsection
         */
        $this->Utilities->propertyExists($section,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($section,'subsection','Dodaj kolumnę',0);
        foreach($section->subsection as $s){
            self::subsection($s);
        }
    }
    private function subsection(object $subsection){
        //$this->Log->logMulti(0,$subsection);
        $this->Utilities->propertyExists($subsection,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($subsection,'row','Dodaj dane do kolumny',0);
        foreach($subsection->row as $r){
            self::row($r);
        }
    }
    private function row(object $row){
        $this->Log->logMulti(0,$row);
        $this->Utilities->propertyExists($row,'type','['.__METHOD__.'] Property `type` not exists in object!');
        $this->Utilities->propertyExists($row,'id','['.__METHOD__.'] Property `id` not exists in object!');
        $this->Utilities->propertyExists($row,'property','['.__METHOD__.'] Property `property` not exists in object!');
        $this->Utilities->propertyExists($row,'style','['.__METHOD__.'] Property `style` not exists in object!');
        $this->Utilities->propertyExists($row,'value','['.__METHOD__.'] Property `value` not exists in object!');
        /*
         * SET:
         * text
         * input
         * select
         * checkbox
         * radio
         */
        self::{"set_".$row->type}($row);
        $this->throw='setSuccess';
    }
    private function set_text(object $row){
        $this->Log->logMulti(0,$row);
    }
    private function set_input(object $row){
        $this->Log->logMulti(0,$row);
    }
    private function set_select(object $row){
        $this->Log->logMulti(0,$row);
    }
    private function set_radio(object $row){
        $this->Log->logMulti(0,$row);
    }
    private function set_checkbox(object $row){
        $this->Log->logMulti(0,$row);
    }
    private function setSuccess():void{
        
    }
    private function setError():void{
        Throw New \Exception ($this->msg,$this->error_lvl);
    }

}