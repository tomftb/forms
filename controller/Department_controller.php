<?php

 final class Department_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Model->{'Department_user'}=new \Department_user_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function getUserDepartments(){
        $this->Log->log(0,"[".__METHOD__."]");
        (object)$departments = new stdClass();
        foreach($this->Model->{'Department_user'}->getUserDepartments($_SESSION['userid']) as $department){
            $departments->{$department->{'id'}} = $department->{'name'};
        }
        return $departments;
    }
}
