class Form_creator_buttons {
    link = new Object();
    Html = new Object();
    response = new Object();
    ErrorStack = new Object();
    Filled_form_table = new Object();
    Form_creator_save = new Object ();
    Form_stage_preview = new Object();
    /*
     * ANONYMOUS FUNCTION
     */
    getData;
    getSetError;
    
    constructor(link,response,ErrorStack,Filled_form_table,getData,router,getSetError,getSetLoad,app_url,getSetSuccess,updateData,checkData){
        console.log('Form_creator_buttons.constructor()');
        //console.log(getData);

        this.Html = new Html();
        this.link = link;
        this.router = router;
        this.response = response;
        this.ErrorStack = ErrorStack;
        this.getData = getData;
        this.getSetError = getSetError;
        this.Filled_form_table = Filled_form_table;
        this.Form_creator_save = new Form_creator_save(link,response,ErrorStack,Filled_form_table,getData,router,getSetError,getSetLoad,app_url,getSetSuccess,updateData,checkData);
        this.Form_stage_preview=new Form_stage_preview();
        this.Form_stage_preview.setGlossary(response.glossary);
    }
    reset(){
        /*
         * CLEAR chosen data row
         */
    }
    set(){

        this.setClose();
        this.setPreview();
        this.setSave();       
    }
    setSave(){
        console.log('Form_creator_buttons.setSave()');
        this.link.button.append(this.Form_creator_save.getButton());
    }
    setClose(){
        var self=this;
        var button = this.Html.getButton('Wyjdź',['btn','btn-dark']);
            button.onclick=function(){
                try{
                    if(self.ErrorStack.check()){
                        if (confirm('Opuścić okno bez zapisu?') === true) {
                            window.onbeforeunload = null;
                            $(self.link['main']).modal('hide');
                            self.Filled_form_table.reload(self.Filled_form_table);
                            return false;
                        }
                        else{ 
                            return false;
                        }
                    }
                    if (confirm('Wyjść?') === true) {
                         window.onbeforeunload = null;
                         $(self.link['main']).modal('hide');
                         self.Filled_form_table.reload(self.Filled_form_table);
                    }
                    else{ 
                    }
                }
                catch(e){
                    console.error('Form_creator_buttons.setClose() onclick() catch',e);
                    self.getSetError('Application error occurred! Contact with Administrator!');
                }
               
            };
        this.link.button.append(button);
    }
    setPreview(){    
        var self = this;
        var button = this.Html.getButton('Podgląd',['btn','btn-warning']);
            button.setAttribute('value','showPreview');
            button.onclick=function(){
                try{
                    //console.log('Form_stage_create_action.setPreviewButton() onclick()');
                    if(this.value==='showPreview'){
                        /*
                         * HIDE MAIN
                         */
                        self.link['dynamic'].classList.add('d-none');
                        /*
                         * SHOW PREVIEW
                         */
                        this.value='showDynamic';
                        self.link['preview'].classList.remove('d-none');
                        self.Html.removeChilds(this);
                        this.append(document.createTextNode('Edytuj'));
                        /*
                         * RUN PREVIEW
                         */
                         var data = self.getData();
                        self.Form_stage_preview.load(self.link['preview_chosen'],data.stage);
                    }
                    else{
                        /*
                         * SHOW MAIN
                         */
                        self.link['dynamic'].classList.remove('d-none');
                        /*
                         * HIDE PREVIEW
                         */
                        self.link['preview'].classList.add('d-none');
                        this.value='showPreview';
                        self.Html.removeChilds(this);
                        this.append(document.createTextNode('Podgląd'));
                    }
                }
                catch(e){
                    console.error('Form_creator_buttons.setPreview() onclick() catch',e);
                    self.getSetError('Application error occurred! Contact with Administrator!');
                    //self.setError(self,'onclick_preview','Application error occurred! Contact with Administrator!');
                    //self.checkErrors(self);
                }
            };
        this.link.button.append(button);
    }

}