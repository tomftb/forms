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
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Controller->{'Form_stage_create'}=new \Form_stage_create_controller();
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
        parent::returnJson(
                [
                    'user'=>$_SESSION
                    ,'department'=>$this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid'])
                    ,'list'=>$this->Model->{'Form_stage'}->getList('0','0')
                ]
        );
    }
    public function getFormStageList(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson($this->Model->{'Form_stage'}->getList('0','0'));
    }
    public function getFormStageCreate(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(
                [
                    'department'=>$this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid'])
                ]
        );
    }
    public function saveFormStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        (array) $post = json_decode(filter_input(INPUT_POST,'data'));
        if(json_last_error()){
            throw new \exception(json_last_error_msg(),0);
        }
        $this->Controller->{'Form_stage_create'}->create($post);
        $response = $this->Controller->{'Form_stage_create'}->get();
        $response->id = 0;
        parent::returnJson($response);
    }
}
