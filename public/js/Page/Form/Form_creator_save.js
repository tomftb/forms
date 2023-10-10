class Form_creator_save {
    /*
     * MODAL LINK ex. ADAPTED
     */
    link = new Object();
    Html = new Object();
    Parse = new Object();
    Xhr = new Object();
    router = '';
    response= new Object();
    ErrorStack = new Object();
    /*
     * FOR RELOAD DATA
     */
    Filled_form_table = new Object();
    /*
     * FOR RETRIVE DATA
     */
    chosen_list = new Object();
    /*
     * ANONYMOUS FUNCTION
     */
    getData;
    /*
     * ANONYMOUS FUNCTION
     */
    getSetError;
    /*
     * ANONYMOUS FUNCTION
     */
    getSetLoad;
    /*
     * ANONYMOUS FUNCTION
     */
    getSetSuccess;
    /*
     * ANONYMOUS FUNCTION
     */
    updateData;
    /*
     * ANONYMOUS FUNCTION
     */
    checkData;
    /*
     * SAVE BUTTON
     */
    save_button = new Object();
    /*
     * DATA TO SEND
     */
    data_to_send = new Object();

    constructor(link,response,ErrorStack,Filled_form_table,getData,router,getSetError,getSetLoad,app_url,getSetSuccess,updateData,checkData){
        console.log('Form_creator_save.constructor()');
        this.Html = new Html();
        this.Xhr = new Xhr2();
        this.Parse = new Parse();
        this.link = link;
        this.router = router;
        this.response = response;
        this.ErrorStack = ErrorStack;
        this.Filled_form_table = Filled_form_table;
        this.getData=getData;
        this.getSetError = getSetError;
        this.getSetLoad = getSetLoad;
        this.getSetSuccess = getSetSuccess;
        this.updateData = updateData;
        this.checkData = checkData;
        getSetLoad(this.Xhr,app_url);
        this.createButton();
    }
    getButton(){
        return this.save_button;
    }
    createButton(){
        var self = this;
        this.save_button = this.Html.getButton('Zapisz',['btn','btn-success']);
        this.save_button.onclick=function(){
            try{
                console.log('Form_creator_save.createButton() onclick()');
                //console.log(self.getData);
                //console.log(self.getData());
                
                self.checkData();
                
                //return true;
                
                var fd = new FormData();
                    fd.append('data',JSON.stringify(self.getData()));
                    self.Xhr.setOnError({'o':self,m:'setError'});
                    /*
                     * RUN XHR
                     * o,m,u,d
                     */
                    self.Xhr.post(self,'checkResponse',self.router+'saveForm',fd);
            }
            catch(e){
                console.error("Form_creator_save.createButton() onclick() catch()",e);
                self.getSetError(e);
            }
                
        };
    }
    setError(e){
        //console.log(e);
        this.getSetError(e);
    }
    setSuccess(){
        console.log('Form_creator_save.setSuccess()');
        this.getSetSuccess('Zapis się powiódł');
    }
    checkResponse(response){
        console.log("Form_creator_save.checkResponse()\r\n");
        console.log(response);
        try{
            var r = this.Parse.getSimpleJson(response);
            //console.log(r);
            //console.log(this.updateData);
            this.updateData(r);
            this.getSetSuccess('Zapis się powiódł');
        }
        catch(e){
            console.error("Form_creator_save.checkResponse() catch()\r\n",e);
            //console.log(this.getSetError);
            this.getSetError(e);
        }
    }
}