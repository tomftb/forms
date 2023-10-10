<?php
final class Form_hide_controller extends Base_controller  {//

    private ?object $Utilities;
    
    public function __construct(){
        parent::__construct();
        $this->Utilities = new Utilities();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Form'} = new \Form_model();
        $this->Controller->{'Slo'} = new \Slo_controller();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);        
    }
    public function getHideFormGlossary(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::returnJson(
                [
                    'form'=>$this->Model->{'Form'}->getById(filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT))
                    ,'glossary'=>$this->Controller->{'Slo'}->getByName('fHide')
                ]
        );
    }
    public function hideForm(){
        $this->Log->log(0,"[".__METHOD__."]");
        $data = json_decode(filter_input(INPUT_POST,'data'));
        $this->Utilities->propertyExists($data,'id_db','['.__METHOD__.'] Property `id_db` doesn\'t exists in object!');
        $this->Utilities->propertyExists($data,'reason','['.__METHOD__.'] Property `reason` doesn\'t exists in object!');
        $this->Log->logMulti(0,$data);
        $this->Model->{'Form'}->remove($data);
        parent::returnJson([]);
    }    
}