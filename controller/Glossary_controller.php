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
    public function getAllWithPositions():object{
        (object) $data = new stdClass();
        foreach($this->Model->{'Glossary'}->getIdName() as $glossary){
            $data->{$glossary->id} = new stdClass();
            $data->{$glossary->id}->{'name'} = $glossary->name;
            $data->{$glossary->id}->{'positions'}=new stdClass();
            $data->{$glossary->id}->{'positions'}=self::getPositions($glossary->id);
            //$glossary->{'position'} = $this->Model->{'Glossary_position'}->getIdNameByIdGlossary($glossary->{'id'});
        }
        return $data;
    }
    public function getPositions(int $id_glossary=0):object{
        (object) $positions = new stdClass();
         foreach($this->Model->{'Glossary_position'}->getIdNameByIdGlossary($id_glossary) as $glossary){
            $positions->{$glossary->id} = new stdClass();
            $positions->{$glossary->id}->{'name'} = $glossary->name;
             
         }
         return $positions;
    }
}
