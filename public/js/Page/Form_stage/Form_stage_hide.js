class Form_stage_hide extends Form_stage_modal_prototype{
    
    constructor(router,app_url,Form_stage_list){
        super(router,app_url,Form_stage_list);
        console.log('Form_stage_hide.construct()');
    }
    hide(response){
        console.log("Form_stage_hide.hide()");//\r\n",response
        super.setTitle('Ukrycie etapu formularza','bg-secondary');
        super.setButton('Ukryj','btn-secondary');
        super.setTask('hideFormStage');
        super.setResponse(response);
        super.setData();
        super.setModalProperties();
        /*
         * SHOW MODAL
         */
        super.showModal();
    }
}