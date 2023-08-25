<?php
/**
 * Description of Base_controller
 *
 * @author tomborc
 */
abstract class Base_controller {
    protected ?object $Log;
    protected ?object $Error;
    protected ?object $Model;
    protected ?object $Controller;
    public function __construct(){
        $this->Log=Logger::init(__METHOD__);  
        $this->Log->log(0,"[".__METHOD__."]");
        $this->Error=New \ErrorHandler();
        $this->Model=new \stdClass();
        $this->Controller=new \stdClass();

    }
    public function __destruct(){
        
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function __serialize() {
        Throw New \Exception(__METHOD__.'() Can not __serialize() class `'.__CLASS__.'`!\'');
    }
    protected function returnJson(mixed $data=[],int $status=0,string $info=''){
         echo json_encode([
                'data'=>$data,
                'status'=>$status,
                'info'=>$info
            ]);
    }
}
