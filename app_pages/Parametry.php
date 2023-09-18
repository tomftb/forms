<?php

final class Parametry extends Page{
    private $mainPerm='LOG_INTO_PARM';
    private $view=[
        'Main/PageLink.php',
        'vParametry.php',
        'Main/Table.html',
        'Main/Footer.php'
        ];
    private $js=[
        'Main/Ajax.js',
        'Main/headerView.js',
        'Page/parametry.js'
        ];

	
    public function __construct(){
        parent::__construct();	
        self::setPage();
        parent::load();
    }
    public function setPage(){
		$this->Log->log(0,__METHOD__);
		parent::setJs($this->js);
        parent::setView($this->view);
        parent::setMainPerm($this->mainPerm);
    }
    public function __destruct(){}

}
