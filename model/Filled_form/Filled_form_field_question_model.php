<?php
/**
 * Description of Filled_form_field_question
 *
 * @author tomborc
 */
class Filled_form_field_question_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
}
