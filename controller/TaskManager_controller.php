<?php
/*
 * Command Interface
 */
interface TaskInterface
{
    /* execute */
    public function run();
}
/*
 * Complex Command 
 */
class Task implements TaskInterface
{
    /**
     * @var Receiver
     */
    private $modul;

    /**
     * Context data, required for launching the receiver's methods.
     */
    private $task;
    /**
     * Complex commands can accept one or several receiver objects along with
     * any context data via the constructor.
     */
    public function __construct($modul, string $task){
        $this->modul = $modul;
        $this->task = $task;
    }
    /**
     * Commands can delegate to any methods of a receiver.
     */
    public function run(){
        /*
         * ComplexCommand: Complex stuff should be done by a receiver object.
         */
        $this->modul->{$this->task}();
        
        //$this->receiver->methodToRun(PARAM);
    }
}
class Invoker
{
    /**
     * @var Command
     */
    private $task;

    /**
     * Initialize commands.
     */
    public function setTask(Task $task){
        $this->task = $task;
    }
    /**
     * The Invoker does not depend on concrete command or receiver classes. The
     * Invoker passes a request to a receiver indirectly, by executing a
     * command.
     */
    public function runTask(){
        $this->task->run();
    }
}
final class TaskManager_controller{
    
    private $modul=[];
    private $Log;
    private ?array $methodFound=[];
    private ?int $methodFoundCounter=0;
    private ?string $method='';
    
    public function __construct(){
        $this->Log = Logger::init(__FILE__);
        self::loadModules();
    }
    public function loadModules(){
        $this->Log->log(0,"[".__METHOD__."]");
        array_push($this->modul,new ManageParameters());
        array_push($this->modul,new ManageProject());       
        array_push($this->modul,new ManagePermission());
        array_push($this->modul,new ManageRole());
        array_push($this->modul,new ManageUser());
        array_push($this->modul,new ManageEmployee());
        array_push($this->modul,new ManageProjectStage());
        array_push($this->modul,new ManageProjectReport());    
        array_push($this->modul,new ManageProjectTeam());  
        array_push($this->modul,new ManageCluster());
        array_push($this->modul,new ManageProjectConstant());
        array_push($this->modul,new ManageProjectVariable());
        array_push($this->modul,new \Form_controller());
        array_push($this->modul,new \Form_stage_controller());
        array_push($this->modul,new \Filled_form_controller());
        array_push($this->modul,new \Filled_form_excel_controller());
        array_push($this->modul,new \Form_stage_hide_controller());
        array_push($this->modul,new \Form_stage_remove_controller());
        array_push($this->modul,new \Form_stage_show_controller());
        array_push($this->modul,new \Form_stage_edit_controller());
        array_push($this->modul,new \Form_stage_create_controller());
        array_push($this->modul,new \Form_creator_controller());
        array_push($this->modul,new \Form_creator_save_controller());
        array_push($this->modul,new \Form_stage_get_controller());
        array_push($this->modul,new \Form_hide_controller());
        array_push($this->modul,new \Form_remove_controller());
    }
    public function loadMethod(mixed $method):void{
        $this->Log->log(0,"[".__METHOD__."]");
        self::setMethodName($method);
        self::findMethod();
        self::checkMethod();
        /*
         * RUN CLASS METHOD
         */
        $invoker = new \Invoker();
        /*
         * $this->modul[$methodFound[0]] =>  already new Obkect()
         */
        $invoker->setTask(New Task($this->modul[$this->methodFound[0]],$this->method));
        $invoker->runTask();
    }
    private function findMethod():void{
        foreach($this->modul as $id => $name){
            if(method_exists ( $name , $this->method )){
                array_push($this->methodFound,$id);
                $this->Log->log(0,"[".__METHOD__."] Method `". $this->method."` found in class `".get_class($name)."`");
                $this->methodFoundCounter++;
            }
        }
    }
    private function checkMethod(){
        if($this->methodFoundCounter===0){
            throw New \Exception("[".__METHOD__."] Task not exists `".$this->method."` add controller with method via loadModules()?",1);
        }
        if($this->methodFoundCounter>1){
            throw New \Exception("[".__METHOD__."] Task avaliable in more than one model `".$this->method."`",1);
        } 
    }
    private function setMethodName(mixed $method):void{
        if(gettype($method)!=='string'){
             throw New \Exception("[".__METHOD__."] Method name is not a string !",1);
        }
        $this->method=trim($method);
        if($this->method===''){
             throw New \Exception("[".__METHOD__."] Method name `".$this->method."` is empty string trim()!",1);
        }
    }
    public function __destruct(){}
}
