<?php
/**
 * Description of Forms_controller
 *
 * @author tomborc
 */
 final class Form_controller extends Base_controller {

    public function __construct(){
        parent::__construct();
        $this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function loadFormDefault(){
        parent::returnJson(['permissions'=>$_SESSION['perm'],'forms'=>[]]);
    }
    public function getHideFormGlossary(){
        
    }
    public function getRemoveFormGlossary(){
        
    }
}
