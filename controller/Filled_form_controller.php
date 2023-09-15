<?php

/**
 * Description of Forms_controller
 *
 * @author tomborc
 */
 final  class Filled_form_controller extends Base_controller {


    public function __construct(){
        parent::__construct();
        $this->Model->{'Uprawnienia'}=new \Uprawnienia_model();
        $this->Model->{'Form'}=new \Form_model();
        $this->Model->{'Form_row'}=new \Form_row_model();
        $this->Model->{'Form_col'}=new \Form_col_model();
        $this->Model->{'Filled_form'}=new \Filled_form_model();
        $this->Model->{'Filled_form_field'}=new \Filled_form_field_model();
        $this->Model->{'Filled_form_field_question'}=new \Filled_form_field_question_model();
    }
    public function __call($m,$a){
        Throw New \Exception(__METHOD__.'() Method `'.$m.'` not exists in this class `'.__CLASS__.'`!\nMethod call with arguments:\n'.serialize($a));
    }
    public function loadFilledFormDefault(){
        $this->Log->log(0,__METHOD__."");
        
        parent::returnJson([
            'permissions'=>$_SESSION['perm']
            ,'form'=>$this->Model->{'Form'}->getAll()
            ]);
    }
    public function getFilledForms(){
        $this->Log->log(0,__METHOD__."");
        (int) $id=filter_input(INPUT_GET,'id',FILTER_VALIDATE_INT);
        //(array) $filled_form=$this->Model->{'Filled_form'}->getByIdForm($id);
        //(array) $filled_form_col=$this->Model->{'Filled_form_field'}->getByIdForm($id);
        //(array) $form_column=$this->Model->{'Form_col'}->getLabelByFormId($id,'1');
        (array) $form_name_column=$this->Model->{'Form_col'}->getNameByFormId($id,'1');

        //print_r($form_name_column);

        parent::returnJson([
            'form'=>$this->Model->{'Form'}->getById($id)
            ,'col'=>$this->Model->{'Form_col'}->getLabelByFormId($id,'1')
            //,'list'=>$filled_form
            //,'filled_list'=>self::getFilledFormField($id,$form_column)
            ,'list'=>self::getList($id,$form_name_column)
            ]);
    }
    private function getList(string|int $id=0, array $form_name_column=[]):array{
        (array) $filled_form_col=[];
        foreach($this->Model->{'Filled_form'}->getByIdForm($id) as $lp => $filled_form){
            //$filled_form_col[] = array_merge($filled_form,$this->Model->{'Filled_form_field'}->getNotNullByIdForm($filled_form['i']));
            $filled_form_col[$lp]=self::getListPosition($filled_form['i'],$form_name_column);
        }
        return $filled_form_col;
    }
    private function getListPosition(string|int $id_form=0,array $form_name_column=[]):array{
        (array) $position = [];
        foreach($form_name_column as $column){
                //echo $column['i'];
                //$filled_form_col[$lp] = $this->Model->{'Filled_form_field'}->getByIdFormAndIdColumn($filled_form['i'],$form_column['i']);
                foreach($this->Model->{'Filled_form_field'}->getByIdFilledFormNameFormField($id_form,$column['v']) as $filled_column){//
                   
                    //echo ($filled_column['v'])."\r\n";
                   
                    $this->Log->logMulti(0,$filled_column['v']);
                    array_push($position,$filled_column['v']);
                }
               
            }
        return $position;
    }
}
