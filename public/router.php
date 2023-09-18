<?php
/*
 * FASCADA PATTERN
 */
session_start();
define('APP_ROOT',substr(filter_input(INPUT_SERVER,"DOCUMENT_ROOT"),0,-6));
require(APP_ROOT.'.cfg/consts.php');
require(APP_ROOT.".cfg/config.php");
require(APP_ROOT."class/AutoLoad.php");

final class router
{
    private $Log;
    private $ErrorHandler;
   
    public function __construct(PermManager $PermManager,TaskManager_controller $TaskManager,UrlManager_controller $UrlManager,ErrorHandler $ErrorHandler,Logger $Logger){
        $this->Log=$Logger;
        $this->ErrorHandler=$ErrorHandler;
        $this->Log->log(0,"[".__METHOD__."]");

        try{
            $UrlManager->setUrlData();
            $PermManager->checkPermission($UrlManager->getUrlPerm());
            $TaskManager->loadMethod($UrlManager->getUrlTask());
        }
        catch(Throwable $t){
            //$this->Log->log(0,$t->getMessage()."\r\nFILE:".$t->getFile()."\r\nLINE:".$t->getLine());
            $this->Log->log(0,"ERROR IN:\r\nFILE:".$t->getFile()."\r\nLINE:".$t->getLine());
            $this->ErrorHandler->setError($t->getMessage(),$t->getCode());
        }
        finally {
            $this->Log->log(0,"[".__METHOD__."] finally");
        } 
    }   
    /*
     * DESTRUCT RETURN DATA
     */
    public function __destruct(){
        if($this->ErrorHandler->getError()){
            $this->Log->log(2,"[".__METHOD__."] ERROR EXIST: ".$this->ErrorHandler->getError());
            echo json_encode(['status'=>1,'type'=>'POST','data'=>[],'info'=>$this->ErrorHandler->getError()]);
        }
        else{
            $this->Log->log(2,"[".__METHOD__."] NO ERROR");
        }
    }
}
/*
 * FASCADE Object:
 * PERM MANAGER Subsystem 
 * MODUL MANAGER Subsystem 
 * URL MANAGER Subsystem 
 * ERROR Subsystem
 * LOGGER Subsystem
 */
NEW \Router(New \PermManager(),New \TaskManager_controller(),New \UrlManager_controller(),New \ErrorHandler(),\Logger::init(__FILE__));
