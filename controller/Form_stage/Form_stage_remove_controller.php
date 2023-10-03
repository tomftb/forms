<?php
final class Form_stage_remove_controller extends Base_controller  {//
    
    private $Stage ;
    private ?object $Utilities;
    
    public function __construct(){
        parent::__construct();
        $this->Utilities = new Utilities();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form_stage'} = new \Form_stage_model();
        $this->Controller->{'Form_stage'} = new \Form_stage_controller();
        $this->Controller->{'Slo'} = new \Slo_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);        
    }
    public function getFormStageRemoveData(){
        $this->Log->log(0,"[".__METHOD__."]");
        (int) $id_db = filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->Stage = $this->Model->{'Form_stage'}->get($id_db);
        parent::returnJson(
                [
                    'id_db'=>$id_db
                    ,'stage'=>$this->Stage
                    ,'user'=>$this->Controller->{'Form_stage'}->getStageUser($this->Stage[0])
                    ,'glossary'=>$this->Controller->{'Slo'}->getByName('fsDelete')
                ]
        );
    }
    public function removeFormStage(){
        $this->Log->log(0,"[".__METHOD__."]");
        $data = json_decode(filter_input(INPUT_POST,'data'));
        $this->Utilities->propertyExists($data,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($data,'reason','['.__METHOD__.'] Property `reason` doesn\'t exists in object!');
        $this->Log->logMulti(0,$data);
        $this->Model->{'Form_stage'}->remove($data);
        parent::returnJson([]);
    }
    public function removeSection(){
        
    }
    public function removeStage(){
        
    }
    public function removeRow(){
        
    }
    
}