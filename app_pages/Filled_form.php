<?php
final class Filled_form extends Page{

    private $mainPerm='LOG_INTO_FILLED_FORM';
    private $view=[
        'Main/PageLink.php',
        'Filled_form_view.php',
        'Main/Table.html',
        'Main/AdaptedModal.html',
        'Main/Footer.php'
        ];
    private $js=[
        'Main/Utilities.js'
        ,'Main/Html.js'
        ,'Main/Modal.js'
        ,'Main/ErrorStack.js'
        ,'Main/Xhr.js'
        ,'Main/Table.js'
        ,'Utilities/Parse.js'

        ,'Page/Form_stage/Form_stage_prototype.js'
        ,'Page/Form_stage/Form_stage_department.js'
        ,'Page/Form_stage/Form_stage_title.js'
        ,'Page/Form_stage/Form_stage_preview.js'
        ,'Page/Form/Form_creator_modal_prototype.js'
        ,'Page/Form/Form_creator_hide.js'
        ,'Page/Form/Form_creator_remove.js'
        ,'Page/Form/Form_creator_save.js'
        ,'Page/Form/Form_creator_buttons.js'
        ,'Page/Form/Form_creator_chosen_list.js'
        ,'Page/Form/Form_creator.js'
        ,'Page/Filled_form/Filled_form_show_filled.js'
        ,'Page/Filled_form/Filled_form_table.js'
        ,'Page/Filled_form/Filled_form.js'
        
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