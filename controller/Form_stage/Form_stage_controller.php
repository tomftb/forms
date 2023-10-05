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
        $this->Model->{'Form_stage'}=new \Form_stage_model();
        $this->Model->{'Parametry'}=new \Parametry_model();
        $this->Controller->{'Glossary'}=new \Glossary_controller();
        $this->Controller->{'Department'}=new \Department_controller();
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
                    ,'department'=>$this->Controller->{'Department'}->getUserDepartments()
                    ,'list'=>$this->Model->{'Form_stage'}->getList('0','0')
                    ,'glossary'=>$this->Controller->{'Glossary'}->getAllWithPositions()
                ]
        );
    }
    public function reloadFormStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson($this->Model->{'Form_stage'}->getList('0','0'));
    }
    public function getFormStageList(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson($this->Model->{'Form_stage'}->getList('0','0'));
    }
    public function getFormStageCreate(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(
                [
                    //'department'=>$this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid'])
                    'parameters'=>self::getParameters()       
                ]
        );
    }
    public function getParameters(){
        (object) $parameters = new stdClass();
        $throw='throwError';
        foreach($this->Model->{'Parametry'}->getFormStageCreate() as $parm){
            $parameters->{$parm['s']}=$parm['v'];
            $throw='throwNoError';
        }
        parent::{$throw}(__METHOD__.' No \'FORM_STAGE\' parameters in database!',1);
        return $parameters;
    }
    public function exists(int $id_db=0):void{
        $this->Model->{'Form_stage'}->exists($id_db);
    }
    public function getStageUser(object $Stage):object{
        (object) $User = new stdClass();
        $User->{'create_date'} = $Stage->create_date;
        $User->{'create_user_login'} = $Stage->create_user_login;
        $User->{'create_user_email'} = $Stage->create_user_email;
        $User->{'mod_user_login'} = $Stage->mod_user_login;
        $User->{'mod_user_email'} = $Stage->mod_user_email;
        $User->{'mod_date'} = $Stage->mod_date;
        return $User;
    }
}
