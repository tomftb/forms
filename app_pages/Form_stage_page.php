<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of ProjectItems
 *
 * @author tborczynski
 */
final class Form_stage_page extends Page{
    private $mainPerm='LOG_INTO_FORM_STAGE';
    private $view=[
        'Main/PageLink.php',
        'Form_stage_view.php',
        'Main/Table.html',
        'Main/AdaptedModal.html',
        'Main/Footer.php'
        ];
    private $js=[
        'Main/Utilities.js',
        'Main/Html.js',
        'Main/Modal.js',
        'Main/ErrorStack.js',
        'Main/Xhr.js',
        'Main/Table.js',
        'Main/Glossary.js',
        'Main/headerView.js',
        'Utilities/Department.js',
        'Utilities/Style.js',
        'Utilities/RomanList.js',
        'Utilities/AlphabeticalList.js',
        'Utilities/TabStop.js',
        'Utilities/ToolFields.js',
        'Utilities/Tool.js',
        'Main/StageData/StageDataRefill.js',
        'Main/StageData/StageDataUpdate.js',
        'Main/StageData/StageData.js',
        'Utilities/DocPreviewTabStop.js',
        'Utilities/DocPreviewParagraph.js',
        'Utilities/DocPreviewPage.js',
        'Utilities/DocPreview.js',
        'Utilities/Parse.js',
        'Page/ProjectStage/ProjectStageToolVariable.js',
        'Page/ProjectStage/ProjectStageToolFile.js',
        'Page/ProjectStage/ProjectStageTool.js',
        'Page/ProjectStage/ProjectStageProperty.js',
        'Page/ProjectStage/Row.js',
        'Page/ProjectStage/SubSection.js',
        'Page/ProjectStage/Section.js',
        'Page/ProjectStage/ProjectStageCreateHead.js',
        'Page/ProjectStage/ProjectStageCreate.js',
        'Page/ProjectStage/ProjectStageCreateTable.js',
        'Page/ProjectStage/ProjectStageCreateImage.js',
        'Page/ProjectStage/ProjectStageTable.js',
        'Page/ProjectStage/ProjectStage.js',
        
        'Page/Form_stage/Form_stage_show.js',
        'Page/Form_stage/Form_stage_edit.js',
        'Page/Form_stage/Form_stage_remove.js',
        'Page/Form_stage/Form_stage_hide.js',
        'Page/Form_stage/Form_stage_list.js',
        'Page/Form_stage/Form_stage_section.js',
        'Page/Form_stage/Form_stage_preview.js',
        'Page/Form_stage/Form_stage_save.js',
        'Page/Form_stage/Form_stage_create_action.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_input_prototype.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_department.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_title.js',

        'Page/Form_stage/Form_stage_create_row/Form_stage_create_input.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_input_select.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_input_radio.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_input_checkbox.js',
        'Page/Form_stage/Form_stage_create_row/Form_stage_create_text.js',
        //'Page/Form_stage/Form_stage_create_row.js',
        'Page/Form_stage/Form_stage_create_subsection.js',
        'Page/Form_stage/Form_stage_create_section.js',
        'Page/Form_stage/Form_stage_create.js',
        'Page/Form_stage/Form_stage.js',
        
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