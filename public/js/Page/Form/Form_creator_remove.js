class Form_creator_remove extends Form_creator_modal_prototype{
    
    constructor(router,app_url,Form_stage_list){
        super(router,app_url,Form_stage_list);
        super.init(); 
        console.log('Form_creator_remove.construct()');
    }
    remove(response){
        console.log("Form_creator_remove.remove()");//\r\n",response
        super.setTitle('Usunięcie formularza','bg-danger');
        super.setButton('Usuń','btn-danger');
        super.setTask('removeForm');
        super.setResponse(response);
        super.setData();
        super.setModalProperties();
        /*
         * SHOW MODAL
         */
        super.showModal();
    }
}