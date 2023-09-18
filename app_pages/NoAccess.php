<?php

class NoAccess extends Page{
    private $perm='';
    private $view=[
        'Main/PageLink.php',
        'vNoAccess.php',
        'Main/Footer.php'
        ];
    private $js=[
        'Main/headerView.js'
        ];
    private $css=[];

    private $meta=[];
    public function __construct($idPage=0,array $pagePerm){
        $this->Log=Logger::init();
        parent::__construct();
        $this->Log->log(0,"[".__METHOD__."]");
        $this->perm=self::setPerm($idPage,$pagePerm);
        self::checkPerm();
        if($this->err){
            self::setPage();
            parent::load();
            exit();
        }
    }
    public function setPage(){
	$this->Log->log(0,"[".__METHOD__."]");
	parent::setJs($this->js);
        parent::setCSS($this->css);
        parent::setView($this->view);
        parent::setMeta($this->meta);
        parent::setMainPerm($this->perm);
    }
    private function checkPerm(){
        $this->Log->log(0,"[".__METHOD__."]");
        if(!in_array($this->perm,$_SESSION['perm'])){
           $this->Log->log(0,"Permission - ".$this->perm." not in user SESSION permissions.");
           $this->err=true;
        }
    }
    private function setPerm($idPage=0,$pagePerm){
        //echo "<pre>";
        //print_r($pagePerm);
        //echo "</pre>";
        $idPage=trim($idPage);
        //$pagePerm=[];
        //echo "ID PAGE => ".$idPage."<br/>";
        //echo "ID PAGE => ".$pagePerm[$idPage]."<br/>";
        if($idPage===''){
            $this->Log->log(0,"[".__METHOD__."] EMPTY ID PAGE, RETURN DEFAULT");
            return array_shift($pagePerm);
        }
        if(!array_key_exists($idPage,$pagePerm)){
            $this->Log->log(0,"[".__METHOD__."] ID PAGE KEY NOT EXIST IN PAGE PERM ARRAY => ".$idPage.", SET DEFAULT");
            return array_shift($pagePerm);
        }
        $this->Log->log(0,"[".__METHOD__."] ID PAGE EXIST IN PAGE PERM ARRAY => ".$idPage);
        return $pagePerm[$idPage];
    }
}
