<?php

 final class Form_creator_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
        //$this->Model->{'Department_user'}=new \Department_user_model();
        $this->Model->{'Form_stage'}=new \Form_stage_model();
       // $this->Model->{'Parametry'}=new \Parametry_model();
       // $this->Controller->{'Glossary'}=new \Glossary_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getFormCreator(){
        $this->Log->log(0,"[".__METHOD__."]");
        //return '';
        parent::returnJson(
                [
                    'stage'=>$this->Model->{'Form_stage'}->getList()
                ]
        );
    }
}
