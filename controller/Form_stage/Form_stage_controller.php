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
        $this->Model->{'Department_user'}=new \Department_user_model();
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
        parent::returnJson(
                [
                    'user'=>$_SESSION,
                    'department'=>$this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid']),
                    'list'=>[]
                ]
        );
    }
    public function getFormStageList(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$type=htmlentities(nl2br(filter_input(INPUT_GET,'type')), ENT_QUOTES,'UTF-8',FALSE);
        //$this->Log->log(0,"[".__METHOD__."]\r\nTYPE - ".$type);
        //echo '';
        parent::returnJson([]);
    
    }
    public function getFormStageCreate(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$type=htmlentities(nl2br(filter_input(INPUT_GET,'type')), ENT_QUOTES,'UTF-8',FALSE);
        //$this->Log->log(0,"[".__METHOD__."]\r\nTYPE - ".$type);
        //echo '';
        parent::returnJson(
                [
                    'department'=>$this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid'])
                ]
        );
    }
    public function saveFormStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        (array) $post = filter_input(INPUT_POST,'data');
        $this->Log->logMulti(0,$post);
        Throw New \Exception('ssss',0);
        parent::returnJson([]);
    }
}
