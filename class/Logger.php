<?php
/*
 * SINGLETON
 */
final class Logger{
    private static $logLink;
    private static $filename='';
    private static $logName='';
    private static $dir=LOG_DIR;
    private static $lvl=0;
    
    private function __construct($from){
        self::check_LOG_DIR();
        self::setLogName();
        self::open(); 
	self::log(0,'Logger construct => '.$from,__METHOD__);
    }
    public static function init($from=''){
	/* CHECK AND INITIALISE Logger (Singleton) CLASS */
	if(!isset(self::$logLink)){
            /* INITIALISED NEW OBJECT */
            self::$logLink=new Logger($from);
	}
	else{
            // ALREADY INITIALISED
            /* self::log(0,'Logger already initialised => init from => '.$from,__METHOD__); */
	}
	return self::$logLink;
    }
    public function log($l=0,$d='',$m=''){
        /*
         * l -> lvl of log
         * d -> data to write
         */
        $type=gettype($d);
        //fwrite(self::$filename, "[".date("Y.m.d H:i:s")."] TYPE ".$type.PHP_EOL);
        if($type==='array' || $type==='object'){
            self::logMultidimensional($l,$d,$m);
        }
        else if(LOG_LVL>=$l){
            fwrite(self::$filename, "[".date("Y.m.d H:i:s")."] ".$d.PHP_EOL);
        }
        else{}
    }
    private function open(){     
	self::$filename = fopen(self::$logName, "a") or die(__METHOD__."Unable to open file!");
    }
    public static function getLogLvl(){
        /* PHP .config CONST */
        return LOG_LVL;
        //return $this->log;
    }
    protected function setLogName(){
	self::setDir();
        self::$logName=self::$dir."log-".date("Y-m-d").".php";
        //echo $this->logName;
    }
    public function logMulti($l,$data,$m=''){
        self::logMultidimensional($l,$data,$m);
    }
    public function logMultidimensional($l,$data,$m){
        /*
         * $l -> level of log
         * $data -> data to write
         * $m -> called method
         */
        if(is_array($data)){  
            self::log($l, "[${m}][".self::$lvl."][A]");

            self::logMultidimensionaA($l,$data,$m);
        }
        else if(is_object($data)){
            self::log($l, "[${m}][".self::$lvl."][O]");

            self::logMultidimensional($l,get_object_vars($data),$m);
        }
        else if(is_resource($data)){
            self::log($l, "[${m}][".self::$lvl."][R]");
        }
        else{
            self::log($l, "[${m}][".self::$lvl."][V] ".$data);
        }
    }
    private function logMultidimensionaA($l,$data,$m){
        self::$lvl++;
        foreach($data as $k => $v){
            self::log($l, "[${m}][".self::$lvl."][K] ".$k);
            self::logMultidimensional($l,$v,$m);
        }
        self::$lvl--;
    }
    private function setDir(){
        if(!file_exists(self::$dir)){
            if(!is_dir(self::$dir)){
		mkdir(self::$dir);
            }
        }
    }
    public static function check_LOG_DIR():void{
        if(!defined("LOG_DIR")){
            Throw New \Exception('Declare LOG_DIR constant!',1);
        }
    }
    private function __clone() { 
	throw new \Exception("Cannot clone a singleton.");
    }
    public function __wakeup(){
        throw new \Exception("Cannot unserialize a singleton.");
    }
    public function __destruct(){
	fclose(self::$filename);
    }
}