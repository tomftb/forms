<?php
final class Slo_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Slo'}=new \Slo_model();

    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getByName(string $name=''):object{
        (object) $Slo = new StdClass();
        foreach($this->Model->{'Slo'}->getByName($name) as $position){
            $this->Log->logMulti(0,$position);
            $Slo->{$position['id']} = new stdClass();
            $Slo->{$position['id']} = $position['nazwa'];
        }
        return $Slo;
    }
}
