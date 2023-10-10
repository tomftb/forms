<?php

 final class Form_creator_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Controller->{'Department'}=new \Department_controller();
        $this->Controller->{'Form_stage_get'} = new  \Form_stage_get_controller();
        $this->Controller->{'Form_creator_get'} = new  \Form_creator_get_controller();
        $this->Controller->{'Glossary'}=new \Glossary_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getFormStagesList(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(
                [
                    'stage'=>$this->Controller->{'Form_stage_get'}->getAllNoId()
                    ,'department'=>$this->Controller->{'Department'}->getUserDepartments()
                    ,'glossary'=>$this->Controller->{'Glossary'}->getAllWithPositions()
                ]
        );
    }
    public function getFormDescription(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(
                [
                    'stage'=>$this->Controller->{'Form_stage_get'}->getAllNoId()
                    ,'department'=>$this->Controller->{'Department'}->getUserDepartments()
                    ,'glossary'=>$this->Controller->{'Glossary'}->getAllWithPositions()
                    ,'form'=>$this->Controller->{'Form_creator_get'}->get(filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT))
                ]
        );
    }
}