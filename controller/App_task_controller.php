<?php
final class App_task_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'App_task'}=new \App_task_model();
        $this->Model->{'Slo'}=new \Slo_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getAllWithPositions():object{

    }
    public function getPositions(int $id_glossary=0):object{
        
    }
}
