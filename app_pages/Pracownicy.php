<?php

final class Pracownicy extends Page{
    private $mainPerm='LOG_INTO_EMPL';
    private $view=[
        'Main/PageLink.php',
        'vPracownicy.php',
        'Main/AdaptedModal.html',
        'Main/Footer.php'
        ];
    private $js=[
        'Main/Ajax.js',
        'Main/headerView.js',
        'Main/Table.js',
        'Page/pracownicy.js'
        ];
    public function __construct(){
        parent::__construct();	
        $this->Log->log(0,"[".__METHOD__."]");
        self::setPage();
        parent::load();
    }
    public function setPage(){
        $this->Log->log(0,"[".__METHOD__."]");
        parent::setJs($this->js);
        parent::setView($this->view);
        parent::setMainPerm($this->mainPerm);
    }
    public function __destruct(){}

}
