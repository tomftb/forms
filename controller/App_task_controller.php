<?php
final class Glossary_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Glossary'}=new \Glossary_model();
        $this->Model->{'Glossary_position'}=new \Glossary_position_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getAllWithPositions(){
        $data = $this->Model->{'Glossary'}->getIdName();
        foreach($data as &$glossary){
            $glossary->{'position'}=new stdClass();
            $glossary->{'position'} = $this->Model->{'Glossary_position'}->getIdNameByIdGlossary($glossary->{'id'});
        }
        return $data;
    }
}
