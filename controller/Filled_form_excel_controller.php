<?php

        require APP_ROOT.'vendor/autoload.php';

        //namespace PhpOffice\PhpSpreadsheet;
        
    use PhpOffice\PhpSpreadsheet\Spreadsheet;
    use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

/**
 * Description of Filled_form_excel_controller
 *
 * @author tomborc
 */
class Filled_form_excel_controller extends Base_controller {
    private ?object $spreadsheet;
    private ?object $activeWorksheet;
    private ?object $writer;
    private ?int $id=0;
    private ?array $alpha = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
    private ?int $alphaMultiply=0;
    private const max=676;
    public function __construct(){
        parent::__construct();
        //$this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
        //$this->Model->{'Form'}=new \Form_model();
        //$this->Model->{'Form_row'}=new \Form_row_model();
        $this->Model->{'Form_col'}=new \Form_col_model();
        //$this->Controller->{'Filled_form'}=new \Filled_form_controller();
        $this->Model->{'Filled_form'}=new \Filled_form_model();
        $this->Model->{'Filled_form_field'}=new \Filled_form_field_model();
        //$this->Model->{'Filled_form_field_question'}=new \Filled_form_field_question_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a),1);
    }
    public function getFilledFormExcel(){
        $this->Log->log(0,__METHOD__."");
        (int) $this->id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        $this->Log->log(0,"id - ".$this->id);
        
        

        $this->spreadsheet = new Spreadsheet();
        $this->activeWorksheet = $this->spreadsheet->getActiveSheet();
        self::setExcelHead($this->Model->{'Form_col'}->getAllLabelByFormId($this->id,'1'));
        self::setExcelBody($this->Model->{'Form_col'}->getAllNameByFormId($this->id,'1'));
        
        $this->writer = new Xlsx($this->spreadsheet);
        (string) $fileName=uniqid('zestawienie_').'.xlsx';
        $this->writer->save(UPLOAD_FILLED_FORM_EXCEL_DIR.$fileName);

        parent::returnJson(['value'=>$fileName,'function'=>'downloadFilledFormExcelList']);
    }
    public function downloadFilledFormExcelList(){
        $this->Log->log(0,"[".__METHOD__."]");
        FileDownload::getFile(UPLOAD_FILLED_FORM_EXCEL_DIR,filter_input(INPUT_GET,"file"));
    }
    private function setExcelHead(array $form_column=[]){
         $this->Log->log(0,"[".__METHOD__."]");
        /*
         * SETUP COLUMN NAME
         */
        (int) $i=0;
        $max=0;
        //$range=range(0,676);
        $tmpAlpha=$this->alpha;
        foreach($form_column as  $column){
        //foreach($range as  $column){
            //$this->Log->log(0,__METHOD__." lp - ".$i);
            //$this->Log->log(0,__METHOD__." COL - ".$tmpAlpha[$i]."1");
            self::multiplyColumn($i,$tmpAlpha);
            $this->activeWorksheet->setCellValue($tmpAlpha[$i].'1', $column['v']);
            //$this->activeWorksheet->setCellValue($tmpAlpha[$i].'1', $column);
            $i++;
            $max++;
        }
        $this->alphaMultiply=0;
    }
    private function setExcelBody(array $form_column=[]){
        $this->Log->log(0,__METHOD__." id form - ".$this->id);
        (int) $i=0;
        $max=0;
        (int) $row=2;
        $tmpAlpha=$this->alpha;
        //$this->Model->{'Filled_form_field'}->getByIdFormAndIdColumn($filled_form['i'],$column['i'])
        foreach($this->Model->{'Filled_form'}->getByIdForm($this->id) as $filled_form){
            $this->Log->log(0,__METHOD__."\r\nid_filled_form - ".$filled_form['i']."\r\nrow - ".$row);
            self::setExcelBodyPosition($row,$i,$max,$tmpAlpha,$filled_form['i'],$form_column);
            $row++;
            $i=0;
            $max=0;
            $tmpAlpha=$this->alpha;
            $this->alphaMultiply=0;
        }
       // die();
    }
    private function setExcelBodyPosition(int &$row=2,int &$i=0,int &$max=0,array &$tmpAlpha=[],string|int $id_form=0,array $form_column=[]){
        $this->Log->log(0,__METHOD__."\r\nid_filled_form - ".$id_form);
        foreach($form_column as $column){
            $this->Log->log(0,"i - ".$i);
            $this->Log->log(0,"max - ".$max);
            $this->Log->log(0,"alphaMultiply - ".$this->alphaMultiply);
            self::multiplyColumn($i,$tmpAlpha);
            foreach($this->Model->{'Filled_form_field'}->getByIdFilledFormNameFormField($id_form,$column['v']) as $filled_column){//    
                $this->Log->log(0,"column - ".$tmpAlpha[$i].$row);
                $this->activeWorksheet->setCellValue($tmpAlpha[$i].$row, $filled_column['v']);
            }
            $i++;
            $max++;
        }
    }
    private function multiplyColumn(int &$i=0,array &$tmpAlpha=[], int $max=0):bool{
        if($max>self::max){
            Throw New \Exception('reached max `'.self::max.'` EXCEL columns!');
        }
        if($i<26){
            return false;
        }
        if($this->alphaMultiply>25){
            $this->alphaMultiply=0;
        }
        $tmpAlpha=$this->alpha;
        foreach($tmpAlpha as &$v){
            $v=$this->alpha[$this->alphaMultiply].$v;
        }
        $this->alphaMultiply++;
        $i=0;
        return true;
    }
}
