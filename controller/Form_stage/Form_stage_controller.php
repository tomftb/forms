<?php
/**
 * Description of Forms_stage_controller
 *
 * @author tomborc
 */
 final class Form_stage_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function loadFormDefault(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(['permissions'=>$_SESSION['perm'],'forms'=>[]]);
    }
    public function getHideFormGlossary(){
        
    }
    public function getRemoveFormGlossary(){
        
    }
    public function getFormStageDefaults(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$type=htmlentities(nl2br(filter_input(INPUT_GET,'type')), ENT_QUOTES,'UTF-8',FALSE);
        //$this->Log->log(0,"[".__METHOD__."]\r\nTYPE - ".$type);
        //echo '';
        parent::returnJson(['permissions'=>$_SESSION['perm'],'list'=>[]]);
    
    }
}
