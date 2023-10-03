<?php

class App_task_model extends Database_model {
    public function __construct(){
        parent::__construct();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getByName(string $name='fsDelete'):array{
        return $this->Main->squery("SELECT "
                ."`id`"
                .",`name`"
                ." FROM " 
                ."`app_task` "
                ." WHERE "
                . "`name`=:name "
                ,[
                    ':iname'=>[$name,'STR']
                ]
                ,'FETCH_OBJ'
                ,'fetchAll'
        );
    }
    public function insert(){
        
    }
    public function update(){
        
    }
}