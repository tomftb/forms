<?php
final class Form_stage_show_controller extends Base_controller {
    
    private ?int $id_db=0;
    private ?object $create_user;
    private ?array $stage_data;
    
    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Controller->{'Form_stage_get'}=new \Form_stage_get_controller();
        $this->Controller->{'Form_stage_controller'}=new \Form_stage_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    private function setCreateUser(){
        $this->create_user = new stdClass();
        $this->create_user->{'create_user_login'} = $this->stage_data[0]->{'create_user_login'};
        $this->create_user->{'create_user_email'} = $this->stage_data[0]->{'create_user_email'};
        $this->create_user->{'create_date'} = $this->stage_data[0]->{'create_date'};
    }
    public function getFormStageShowData(){
        $this->Log->log(0,"[".__METHOD__."]");
        //$this->Log->log(0,$_GET);
        $this->id_db = filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->Controller->{'Form_stage_controller'}->exists($this->id_db);
        self::setData();
        parent::returnJson(
                [
                    'id_db'=>$this->id_db
                    ,'user'=>$this->create_user
                    ,'stage'=>$this->stage_data
                    ,'parameters'=>$this->Controller->{'Form_stage_controller'}->getParameters()   
                ]
        );
    }
    private function setData(){
        $this->Log->log(0,"[".__METHOD__."]");
        $this->stage_data=$this->Controller->{'Form_stage_get'}->get($this->id_db);
        self::setCreateUser();
    }    
}