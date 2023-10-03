class Form_stage_modal_prototype extends Modal{
    
    Html = new Object();
    Xhr = new Object();
    ErrorStack = new Object();
    Parse = new Object();
    Utilities = new Object();
    
    router='';
    app_url='';
    response = new Object();
    glossary = new Object();
    input = new Object();
    
    title={
      'label':'Usunięcie etapu formularza'
      ,'classlist':'bg-danger'
    };
    button={
        'label':'Usuń'
        ,'classlist':['btn','btn-danger']
    };
    
    task = 'removeFormStage';
    
    FormData = {
                'id_db':'N/A'
                ,'user':{
                        'create_user_login':'N/A'
                        ,'create_user_email':'N/A'
                        ,'create_date':'N/A'
                        ,'mod_user_login':'N/A'
                        ,'mod_user_email':'N/A'
                        ,'mod_date':'N/A'
                }
                ,'stage':{
                        0:{}
                }
    };
    
    constructor(router,app_url,Form_stage_list){
        super();
        console.log('Form_stage_modal_prototype.construct()');
        this.Html = new Html();
        this.Xhr=new Xhr2();
        this.ErrorStack=new ErrorStack();
        this.Parse=new Parse();
        this.Utilities = new Utilities();
        this.router=router;  
        this.app_url=app_url;  
        this.setLoad(this.Xhr,app_url);
        this.Form_stage_list=Form_stage_list;  
    }
    setTitle(title,classlist){
        this. title={
            'label':title
            ,'classlist':classlist
        };
    }
    setButton(title,mainclass){
        this.button={
            'label':title
            ,'classlist':['btn',mainclass]
        };
    }
    setTask(task){
        this.task=task;
    }
    setResponse(response){
        try{
            console.log('Form_stage_modal_prototype.setResponse()');
            //console.log(response);
             /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            console.log(this.response);
            this.Utilities.propertyExists(this.response,'id_db','Object `this.response` doesn\'t have `id_db` property!');
            this.Utilities.propertyExists(this.response,'stage','Object `this.response` doesn\'t have `stage` property!');
            this.Utilities.propertyExists(this.response,'user','Object `this.response` doesn\'t have `user` property!');
            this.Utilities.propertyExists(this.response,'glossary','Object `this.response` doesn\'t have `glossary` property!');
        }
        catch(e){
            console.log("Form_stage_modal_prototype.setResponse() parse catch()\r\n",response);
            console.error(e);
            throw "Application error occurred! Contact with Administrator!";
        }
    }
    setData(){
        try{
            console.log('Form_stage_modal_prototype.setData()');
            /*
             * SET FormData
             */
            this.FormData={
                'id_db':this.response.id_db
                ,'user':{
                    'create_user_login':this.response.stage[0].create_user_login
                    ,'create_user_email':this.response.stage[0].create_user_email
                    ,'create_date':this.response.stage[0].create_date
                    ,'mod_user_login':this.response.stage[0].mod_user_login
                    ,'mod_user_email':this.response.stage[0].mod_user_email
                    ,'mod_date':this.response.stage[0].mod_date
                }
                ,'stage':{
                    0:this.response.stage[0]
                }
            };
            /*
             * SET glossary
             */
            this.glossary = this.response.glossary;
        }
        catch(e){
            console.error("Form_stage_modal_prototype.setFormData() parse catch()\r\n",e);
            throw "Application error occurred! Contact with Administrator!";
        }
    }
    setModalProperties(){
        try{
            console.log('Form_stage_modal_prototype.setModalProperties()');
        /*
         * SETUP MODAL
         */
            super.clearData();
            super.setExitKeys();
            super.setHead(this.title.label,this.title.classlist);
            this.setModalTitle();
            this.setModalReason();
            super.setCloseModal();
            this.setModalAction();
            super.setInfo("Form Stage ID: "+(this.FormData.id_db).toString()+", Create user: "+this.FormData.user.create_user_login+" (e-mail: "+this.FormData.user.create_user_email+"), Create date: "+this.FormData.user.create_date+", Modification user: "+this.FormData.user.mod_user_login+" (e-mail: "+this.FormData.user.mod_user_email+"), Version: "+this.FormData.user.mod_date); 
        }
        catch(e){
            console.error("Form_stage_show.setModalProperties() modal catch()\r\n",e);
            throw 'Application error occurred! Contact with Administrator!';
        }
    }
    setModalTitle(){
       console.log('Form_stage_modal_prototype.setModalTitle()'); 
        var row=this.Html.getRow();
            row.setAttribute('id','main');
        var col=this.Html.getCol(12);
        var p = document.createElement('h1');
            p.classList.add('text-center');
            p.append(document.createTextNode(this.FormData.stage[0].title));
        var h6 = document.createElement('h6');
            h6.classList.add('text-left','text-muted');
            h6.append(document.createTextNode('Tytuł'));    
            
            col.append(h6);
            col.append(p);
            row.append(col);
            /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);  
    }
    setModalReason(){
       console.log('Form_stage_modal_prototype.setModalReason()'); 
        var row=this.Html.getRow();
            row.setAttribute('id','main');
        var col=this.Html.getCol(12);
       
        var self = this;
        var div = document.createElement('div');
            div.classList.add('form-group', 'mb-1');
        var label = document.createElement('label');
            label.classList.add('text-muted');
            label.append(document.createTextNode('Wskaż powód:'));
        var select = document.createElement('select');
            select.classList.add('form-control');
            select.setAttribute('id', 'reason');
            select.setAttribute('name', 'reason');
            select.onchange = function () {
                try {
                    console.log('Form_stage_modal_prototype.setModalReason() onchange()');
                    console.log(this.value);
                }
                catch (e) {
                    console.log('Form_stage_modal_prototype.setModalReason() onchange() catch()'); 
                    console.error(e); 
                    self.setError('Application error occurred! Contact with Administrator!');
                }
            };
            for(const prop in this.glossary) {
                var option = document.createElement('option');
                    option.value = this.glossary[prop];
                    option.append(document.createTextNode(this.glossary[prop]));
                    select.append(option);
            }
            div.append(label);
            div.append(select);
            col.append(div);
       
            row.append(col);
            this.input = select;
             /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);  
    }
    setModalAction(){
        console.log('Form_stage_modal_prototype.setModalAction()'); 
        console.log(this.link);
        this.setCloseButton();
        this.setActionButton();
    }
    setCloseButton(){
        var self=this;
        var button = this.Html.getButton('Wyjdź',['btn','btn-dark']);
            button.onclick=function(){
                try {
                    if (confirm('Wyjść?') === true) {
                        window.onbeforeunload = null;
                        $(self.link['main']).modal('hide');
                        self.Form_stage_list.reload(self.Form_stage_list);
                    }
                }
                catch (e) {
                    console.log('Form_stage_modal_prototype.setCloseButton() onclick() catch()');
                    console.error(e);
                    self.setError('Application error occurred! Contact with Administrator!');
                }
               
            };
        this.link.button.append(button);
    }
    setActionButton(){
        console.log('Form_stage_modal_prototype.setRemoveButton()'); 
        var self = this;
        var button = this.Html.getButton(this.button.label,this.button.classlist);
            button.onclick=function(){
                try {
                    console.log('Form_stage_modal_prototype.setRemoveButton() onclick()');
                    console.log(self.input.value);
                    var fd = new FormData();
                        fd.append('data',JSON.stringify(
                                    {
                                        'reason':self.input.value
                                        ,'id_db':self.FormData.id_db
                                    }
                                )
                        );
                        self.Xhr.setOnError({'o':self,m:'setError'});
                        self.Xhr.run({
                                t:'POST'
                                ,u:self.router+self.task
                                ,c:true
                                ,d:fd
                                ,o:self
                                ,m:'close'
                    });
                }
                catch (e) {
                    console.log('Form_stage_modal_prototype.setRemoveButton() onclick() catch()');
                    console.error(e);
                    self.setError('Application error occurred! Contact with Administrator!');
                }
            };
        this.link.button.append(button);
    }
    close(response){
        try{
            console.log('Form_stage_modal_prototype.close()'); 
            console.log(response); 
             /*
             * PARSE RESPONSE
             */
            var r = this.Parse.getSimpleJson(response);
            console.log(r);
            this.Form_stage_list.reload(this.Form_stage_list);
        }
        catch(e){
            console.log("Form_stage_modal_prototype.close() parse catch()\r\n",response);
            console.error(e);
            this.setError(e);
            return false;
        }
        try{
            $(this.link['main']).modal('hide');
        }
        catch(e){
            console.log("Form_stage_modal_prototype.close() parse catch()\r\n",response);
            console.error(e);
            this.setError(e);
        }
    }
}