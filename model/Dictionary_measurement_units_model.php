<?php

class Dictionary_measurement_units_model extends Database_model {
    public function __construct(){
        parent::__construct();
        /*
         * $this->Main - link to database object
         */
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function getRemaining(string $name=''):array{
        return $this->Main->squery("SELECT `id` as \"ID\",`name` as \"Nazwa\",`default_unit`,`delete_status` FROM `dictionary_measurement_units` WHERE `id`>0 AND `delete_status`='0' AND `name`!=:name ORDER BY `id` ASC ",[':name'=>[$name,'STR']],'FETCH_ASSOC','fetchAll');
    }
    public function getAll():array{
        return $this->Main->squery("SELECT `id`,`name`,`default_unit`,`delete_status` FROM `dictionary_measurement_units` WHERE `id`>0 AND `delete_status`='0' ORDER BY `id` ASC ");
    }
    public function getUpperCase(){
        return $this->Main->squery("SELECT `name` as `NAZWA`,`default_unit` as `DEF` FROM `dictionary_measurement_units` WHERE `id`>0 AND `delete_status`='0' ORDER BY `id` ASC ");
    }
}