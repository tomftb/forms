class Form_creator extends Modal{
    app_url='';
    router='';
    ErrorStack = new Object();
    Utilities = new Object();
    Xhr = new Object();
    Parse = new Object();
    Html = new Object();
    upData = 'setModal';
    
    Filled_form_table = new Object();
    Form_stage_title = new Object();
    Form_creator_chosen_list = new Object();
    Form_stage_department = new Object();
    Form_creator_buttons = new Object();
    
    
    FormData = {
        'id_db':'N/A'
        ,'title':''
        ,'department_id':0
        ,'department_name':''
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
        }//END STAGE PROPERTY
    };
    
    constructor(app_url,router,Filled_form_table){
        super();
        this.app_url=app_url;
        this.router = router;
        this.ErrorStack = new ErrorStack();
        this.Filled_form_table=Filled_form_table;
        this.Form_creator_chosen_list=new Form_creator_chosen_list();
        this.Xhr = new Xhr2();
        this.Parse = new Parse();
        this.Html = new Html();
        this.Utilities = new Utilities();
    }
    details(response){
        console.log('Form_creator.details()');
        try{
            super.init();
            this.upData='setDetailsModal';
            
        }
        catch(e){
            this.Filled_form_table.setError("Application error occurred! Contact with Administrator!");
            return false;
        }
        this.setResponse(response);
        this[this.upData]();
    }
    creator(){
        console.log('Form_creator.creator()');
        /*
         * INIT MODAL
         */
        super.init();
        var self=this;
        console.log(self);  
        try{
            console.log('Form_stage.setAddStageButton().onclick()');  
            console.log(this.router);
            this.Filled_form_table.unsetError();
            this.upData='setModal';
            this.Xhr.setOnError2(this.Filled_form_table,'setError');//,'setError'
            this.Xhr.get(this,'up',this.router+'getFormStagesList');
        }
        catch (e){
            console.log('Form_creator.creator() catch()');
            console.error(e);
            this.Filled_form_table.setError("Application error occurred! Contact with Administrator!");
        }
    }
    up(response,self){
        console.log('Form_creator.up()');
        /*
         * self is reference to this object
         */
        this.setResponse(response);
        this[this.upData]();
    }
    getIdDb(){
        return this.FormData.id_db;
    }
    setResponse(response){
        try{
            console.log('Form_stage_create.setResponse()');
            console.log(response);
             /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            console.log(this.response);
        }
        catch(e){
            console.error("Form_stage_create.setResponse() parse catch()\r\n",e);
            this.Filled_form_table.setError(e);
            this.upData='errorExist';
        }
    }
    errorExist(){
        console.log('Form_creator.errorExist()');
    }
    setDetailsModal(){
        console.log('Form_creator.setDetailsModal()');
        try{
            //throw 'sss';
            this.FormData.id_db = parseInt(this.response.form.id_db,10);
            this.Form_creator_chosen_list.reset();
            this.Form_creator_chosen_list.setParent(this);
           
            super.clearData();
            super.setExitKeys();
            super.setHead('Kreator formularza','bg-info');
            super.setCloseModal();
            this.setModalTitle(this.response.form.title);
            this.setModalReadyDepartment();
            this.setModalMain();
            /*
             * SET READY LIST
             */
             this.Form_creator_chosen_list.setDataChosenList(this.response.form.stage);
            this.setModalPreview();
            this.setModalButtons();
            this.setModalInfo((this.response.form.id_db).toString(),this.response.form);
            super.showModal();
        }
        catch(e){
            console.error("Form_stage_create.setDetailsModal() catch()\r\n",e);
            this.Filled_form_table.setError("Application error occurred! Contact with Administrator!");
        }
    }
    setModal(){
        try{
            console.log('Form_creator.setModal()');
            console.log(this.link);
            this.FormData.id_db='N/A';
            this.Form_creator_chosen_list.reset();
            this.Form_creator_chosen_list.setParent(this);
            super.clearData();
            super.setExitKeys();
            super.setHead('Kreator formularza','bg-info');
            super.setCloseModal();
            this.setModalTitle('');
            this.setModalDepartment();
            this.setModalMain();
            this.setModalPreview();
            this.setModalButtons();
            this.setModalInfo((this.FormData.id_db).toString(),this.FormData.user);
            super.showModal();
        }
        catch(e){
            console.error("Form_stage_create.setModal() catch()\r\n",e);
            this.Filled_form_table.setError("Application error occurred! Contact with Administrator!");
        }
    }
    setModalTitle(data){
        /*
         * SET TITLE
         */
        this.Form_stage_title = new Form_stage_title(this,this.link['adapted'],data);
    }
    setModalDepartment(){
        /*
         * SET DEPARTMENT
         */
        this.Form_stage_department = new Form_stage_department(this,this.link['adapted']);
        this.Form_stage_department.setDepartmentList(this.response.department);
        this.Form_stage_department.set();
    }
    setModalReadyDepartment(){
        /*
         * SET DEPARTMENT
         */
        this.Form_stage_department = new Form_stage_department(this,this.link['adapted']);
        this.Form_stage_department.setDepartmentList(this.response.department);
        this.Form_stage_department.addStageDepartment(this.response.form.department_id,this.response.form.department_name);
        this.Form_stage_department.set();
    }
    setModalMain(){
        console.log('Form_creator.setModalMain()');
        console.log(this.response);
        var row=this.Html.getRow();
            row.setAttribute('id','main');
            row.classList.add('border','mb-1');
        var col=this.Html.getCol(6);
            col.setAttribute('id','main_to_choose');
            col.classList.add('border-right');
        var col_2=this.Html.getCol(6);
            col_2.setAttribute('id','main_chosen');
            row.append(col,col_2);
            
            this.link['dynamic_to_choose']=col;
            //this.link['dynamic_chosen']=col_2;    
            this.link['dynamic']=row;  
            
            this.setModalMainToChoose();  
            this.Form_creator_chosen_list.setList(col_2);
            
            this.link['adapted'].append(row);    
    }
    setModalMainToChoose(){
        var self = this;
        var row_label=this.Html.getRow();
            row_label.classList.add("bg-info");
        var col_label=this.Html.getCol(12);
            row_label.append(col_label);
        var row_data=this.Html.getRow();
        var col_data=this.Html.getCol(12);
            //col_data.classList.add('pl-1');
            row_data.append(col_data);    
        var h=document.createElement('h5');
            h.classList.add('text-left','font-weight-normal','text-white','pl-0','pr-0','pt-1','pb-0');
            h.append(document.createTextNode("Dostępne bloki formularza:"));

            col_label.append(h);

            for(const prop in this.response.stage){
                var p=document.createElement('p');
                    p.classList.add('text-left','ml-0','mt-0','mb-0','mr-0','font-weight-normal');
                    
                var span_bullet=document.createElement('span'); //&bull; &nbsp;
                    span_bullet.classList.add('text-info');
                    span_bullet.append(document.createTextNode("\u2022\u00A0"));
                var span_label=document.createElement('span');
                    span_label.classList.add('text-dark');
                    span_label.append(document.createTextNode("["+this.response.stage[prop].id+"]\u00A0"),document.createTextNode(this.response.stage[prop].title));
                    span_label.style.cursor='pointer';
                    span_label.onclick = function(){
                        try{
                            console.log('Form_creator.setModalMain() span.onclick()');
                            self.Form_creator_chosen_list.add(prop,self.response.stage[prop]);//self,prop,self.counter
                        }
                        catch(e){
                            console.log('Form_creator.setModalMainToChoose() catch() onclick()');
                            console.error(e);
                            self.setError("Application error occurred! Contact with Administrator!");
                        }
                    };
                    p.append(span_bullet,span_label);
                    col_data.append(p);
            }
            this.link['dynamic_to_choose'].append(row_label,row_data);
            console.log(this.link['dynamic_to_choose']);
    }
    setModalPreview(){
        console.log('Form_creator.setModalPreview()');
        var row=this.Html.getRow();
            row.setAttribute('id','main_preview');
        var col=this.Html.getCol(12);
            row.append(col);
            /*
             * SET LINK TO PREVIEW
             */
            this.link['preview_chosen']=col;
            this.link['preview']=row;
            /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);
    }
    setModalButtons(){
        console.log('Form.creator.setModalButtons()');
        console.log(this.link);
        /*
         * SET DEPARTMENT
         * SET ANONYMOUS FUNCTION
         */
        var self = this;
        var getData = function (){ 
            console.log("Form.creator.setModalButtons() anonymous function getData()");
            var stages = self.Form_creator_chosen_list.getDataChosenList();
            return {
                'department_id':self.Form_stage_department.getValue()
                ,'department_name':self.Form_stage_department.getName()
                ,'id_db':self.getIdDb()
                ,'title':self.Form_stage_title.getValue()
                ,'stage':stages()
            };
        };
        
        var updateData = function (r){
            console.log("Form.creator.setModalButtons() anonymous function updateData()");//,r
            self.FormData.id_db=(r.id_db).toString();
            //self.setInfo("Form Stage ID: "+(r.id_db).toString()+", Create user: "+r.create_user_login+" (e-mail: "+r.create_user_email+"), Create date: "+r.create_date+", Modification user: "+r.mod_user_login+" (e-mail: "+r.mod_user_email+"), Version: "+r.mod_date); 
            self.setModalInfo((r.id_db).toString(),r);
            self.Form_creator_chosen_list.updateDataChosenList(r);
        };
        var checkData = function(){
            console.log("Form.creator.setModalButtons() anonymous function checkData()");
            var e = '';
            /*
             * CHECK TITLE
             */
            self.Form_stage_title.checkLength(self.Form_stage_title,self.Form_stage_title.input.value);
            self.Form_stage_title.checkErrors(self.Form_stage_title);
             
            var stages = self.Form_creator_chosen_list.getDataChosenList();
             
            console.log(self.Utilities.countObjectProp(stages()));
            
            if(self.Utilities.countObjectProp(stages())===0){
                e='Nie wskazano żadnego bloku danych.';
            }
            
            if(self.Form_stage_title.Prototype.ErrorStack.check()){
                 e+=' Sprawdź pole tytuł.';
            }
            if(e!==''){
                throw e;
            } 
             
        };
        this.Form_creator_buttons = new Form_creator_buttons(
                this.link
                ,this.response
                ,this.ErrorStack
                ,this.Filled_form_table
                ,getData
                ,this.router
                ,this.getSetError()
                ,this.getSetLoad()
                ,this.app_url
                ,this.getSetSuccess()
                ,updateData
                ,checkData
        );
        this.Form_creator_buttons.set();
    }
    setModalInfo(id_db,user){
        super.setInfo("Form Stage ID: "+id_db+", Create user: "+user.create_user_login+" (e-mail: "+user.create_user_email+"), Create date: "+user.create_date+", Modification user: "+user.mod_user_login+" (e-mail: "+user.mod_user_email+"), Version: "+user.mod_date); 
    }
}

