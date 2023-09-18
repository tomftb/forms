<?php
final class Form extends Page{
    private $mainPerm='LOG_INTO_FORM';
    private $view=[
        'Main/PageLink.php',
        'Form_view.php',
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
        'Page/ProjectConstantTable.js',
        'Page/ProjectConstantCreate.js',
        'Page/ProjectConstant.js',
        'Page/ProjectVariable/ProjectVariableTable.js',
        'Page/ProjectVariable/ProjectVariableCreate.js',
        'Page/ProjectVariable/ProjectVariable.js',
        //'Page/Forms/Forms.js',
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