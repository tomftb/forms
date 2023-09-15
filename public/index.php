<?php 
session_start();

date_default_timezone_set('Europe/Warsaw');
/*
 * APPLICATION ROOT
 * CUT public string or ../ ??
 * NEED FOR VIEWS AS WELL !!
 */
define('APP_ROOT',substr(filter_input(INPUT_SERVER,"DOCUMENT_ROOT"),0,-6));



require(APP_ROOT.'.cfg/consts.php');
require(APP_ROOT.'.cfg/config.php');
require(APP_ROOT."class/AutoLoad.php");
try{
    /* 
    * STATIC ABSTRACT FACTORY
    */
    PageManager::load(filter_input(INPUT_GET,"id", FILTER_VALIDATE_INT));
}
catch(Throwable $t){
    echo $t->getMessage()."<br/>";
    echo $t->getCode()."<br/>";
}
finally {
         
} 


