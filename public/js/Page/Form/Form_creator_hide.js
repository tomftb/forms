class Form_creator_hide extends Form_creator_modal_prototype{
    
    constructor(router,app_url,Form_stage_list){
        super(router,app_url,Form_stage_list);
        super.init(); 
        console.log('Form_creator_hide.construct()');
    }
    hide(response){
        console.log("Form_creator_hide.hide()");//\r\n",response
        super.setTitle('Ukrycie formularza','bg-secondary');
        super.setButton('Ukryj','btn-secondary');
        super.setTask('hideForm');
        super.setResponse(response);
        super.setData();
        super.setModalProperties();
        /*
         * SHOW MODAL
         */
        super.showModal();
    }
}