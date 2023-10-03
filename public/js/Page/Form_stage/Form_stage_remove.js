class Form_stage_remove extends Form_stage_modal_prototype{
    
    constructor(router,app_url,Form_stage_list){
        super(router,app_url,Form_stage_list);
        console.log('Form_stage_remove.construct()');
    }
    remove(response){
        console.log("Form_stage_remove.remove()");//\r\n",response
        super.setTitle('Usunięcie etapu formularza','bg-danger');
        super.setButton('Usuń','btn-danger');
        super.setTask('removeFormStage');
        super.setResponse(response);
        super.setData();
        super.setModalProperties();
        /*
         * SHOW MODAL
         */
        super.showModal();
    }
}