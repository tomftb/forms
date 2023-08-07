<?php

/**
 * Description of Db_model
 *
 * @author tomborc
 */
abstract class Database_model {
    protected ?object $Main;
    protected function __construct(){
        $this->Main=\LoadDb::load();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
}