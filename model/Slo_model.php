<?php

class Slo_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),0);
    }
    public function getByName(string $name=''):array{
        return $this->Main->squery('SELECT `s`.`id`,`s`.`nazwa` FROM `slo` as `s`, `app_task` as `a` WHERE `s`.`id_app_task`=`a`.`id` AND `a`.`name`=:name and `s`.`delete_status`=\'0\' ORDER BY `id` ASC',[':name'=>[$name,'STR']]);
    }
}