class Form_stage_create extends Modal{
    permissions=new Array();
    appUrl='';
    router='';
    
    Parse = new Object();
    ErrorStack = new Object();
    Property = new Object();
    Xhr=new Object();
    
    Form_stage_title = new Object();
    Form_stage_department = new Object();
    Form_stage_list = new Object();
    Form_stage_create_action = new Object();
    Form_stage_create_section = new Object();
    Form_stage_preview = new Object();

    setData='setNoData';

    //glossary = new Array();
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
            0:{
                'id_db':0// STAGE ID
                ,'department_name':''// STAGE ID
                ,'department_id':0// STAGE ID
                ,'title':0// STAGE ID
                ,'section':{
                            0:{
                                'id_db':0// SECTION ID [ROW]
                                ,'subsection':{
                                                0:{
                                                    'id_db':0// SUBSECTION ID [COLUMN]
                                                    ,'row':{
                                                            0:{
                                                               'id_db':0// ROW ID [COLUMN ROW]
                                                               ,'name':""
                                                               /* type: text,input,checkbox,radio,select */
                                                               ,'type':"text"
                                                               /* value - mixed */
                                                               ,'value':""
                                                               ,'style':{}
                                                               ,'property':{
                                                                   /* ONLY RADIO AND CHECKBOX */
                                                                   'label':{
                                                                        'id_db':0// ROW ID [COLUMN ROW]
                                                                        ,'name':""
                                                                        /* type: text,input,checkbox,radio,select */
                                                                        ,'type':"text"
                                                                        /* valu - mixed */
                                                                        ,'value':""
                                                                   }
                                                                   /* END ONLY RADIO AND CHECKBOX */
                                                                   /* ONLY SELECT */
                                                                    ,'glossary_id_db':0
                                                                    ,'glossary_name':''
                                                                    ,'glossary_position_id_db':0
                                                                    ,'glossary_position_value':''
                                                                   /* END ONLY SELECT */
                                                               }
                                                        }
                                                    }//END ROW PROPERTY
                                                }
                                }// END SUBSECTION PROPERTY
                            }
                }// END SECTION PROPERTY
            }
        }//END STAGE PROPERTY
    };
    
    constructor(router,appUrl,Form_stage_list){
        super();
        console.log('Form_stage_create.construct()');
        this.Xhr=new Xhr2();
        this.ErrorStack=new ErrorStack();
        this.router=router;  
        this.appUrl=appUrl;  
        this.Parse=new Parse();
        this.setLoad(this.Xhr,this.appUrl);
        this.Form_stage_list=Form_stage_list;        
        this.Form_stage_create_action=new Form_stage_create_action(this);
        this.Form_stage_create_section=new Form_stage_create_section(this);
        this.Form_stage_preview=new Form_stage_preview();
    }
    /*
     * SET PROPERTY
     */
    setProperty(property){
        console.log('Form_stage_create.setProperty()');
        this.permissions=property.user.perm;
        this.department=property.department;
        this.Form_stage_create_section.setGlossary(property.glossary);
        this.Form_stage_preview.setGlossary(property.glossary);
    }
    /*
     * CREATE
     */
    create(response){
        this.setData='setCreateData';
        this.setResponse(response);
        this[this.setData]();
    }
    show(response){
        this.setData='setShowData';
        this.setResponse(response);
        this[this.setData]();
    }
    setNoData(){
        console.log('Form_stage_create.setNoData()');
    }
    setCreateData(){
        console.log('Form_stage_create.setCreateData()');
        try{           
            /*
             * CLEAR ErrorStack
             */
            this.ErrorStack.clearStack();
            /*
             * CLEAR FormData
             */
            this.FormData = {
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
                            0:{
                                'id_db':0// STAGE ID
                            }
                        }
            };
            /*
             * SETUP MODAL PROPERTIES
             */
            this.setModalProperties('Dodaj etap formularza');
            this.setModalCreateMain();
            /*
             * SET PREVIEW FIELD
             */
            this.setModalPreview();
            /*
             * SET ACTION
             */
            this.Form_stage_create_action.set(this.link);
            /*
             * SHOW MODAL
             */
            super.showModal();
        }
        catch(e){
            console.error("Form_stage_create.create() modal catch()\r\n",e);
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
        }
    }
    setShowData(){
        console.log('Form_stage_create.setShowData()');
        try{
            /*
             * CLEAR ErrorStack
             */
            this.ErrorStack.clearStack();
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
            this.setModalProperties('Wyświetl etap formularza');

            /*
             * SET ACTION
             */
            this.Form_stage_create_action.set(this.link);
            console.log(this.link);
        }
        catch(e){
            console.error("Form_stage_show.create() modal catch()\r\n",e);
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
            return false;
        }
        try{           
            /*
             * SET MAIN DYNAMIC FIELD
             */
            this.setModalData();
            /*
             * SET PREVIEW FIELD
             */
            this.setModalPreview();
            super.showModal();
        }
        catch(e){
            console.error("Form_stage_show.create() modal catch()\r\n",e);
            this.Form_stage_list.setError(e);//'Application error occurred! Contact with Administrator!'
        }
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
            this.Form_stage_list.setError("Application error occurred! Contact with Administrator!");
            this.setData='setNoData';
            //throw "Application error occurred! Contact with Administrator!";
            //return false;
        }
    }
    setModalPreview(){
        console.log('Form_stage_create.setModalPreview()');
        var row=this.Html.getRow();
            row.setAttribute('id','preview');
        var col=this.Html.getCol(12);
            row.append(col);
            /*
             * SET LINK TO PREVIEW
             */
            this.link['preview']=col;
            /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);
    }
    setModalProperties(title){
        console.log('Form_stage_show.setModalProperties()');
        /*
         * SETUP MODAL
         */
            super.clearData();
            super.setExitKeys();
            super.setHead(title,'bg-info');
            super.setCloseModal();
            /*
             * SET MAIN DYNAMIC FIELD
             */
        var row=this.Html.getRow();
            row.setAttribute('id','main');
        var col=this.Html.getCol(12);
            row.append(col);
            /*
             * SET LINK TO DYNAMIC
             */
            this.link['dynamic']=col;
            /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);       
            super.setInfo("Form Stage ID: "+(this.FormData.id_db).toString()+", Create user: "+this.FormData.user.create_user_login+" (e-mail: "+this.FormData.user.create_user_email+"), Create date: "+this.FormData.user.create_date+", Modification user: "+this.FormData.user.mod_user_login+" (e-mail: "+this.FormData.user.mod_user_email+"), Version: "+this.FormData.user.mod_date); 
    }
    setModalCreateMain(){
        console.log('Form_stage_create.setModalPreview()');
        /*
         * SET TITLE
         */
        this.Form_stage_title = new Form_stage_title(this,this.link['dynamic'],'');
        /*
         * SET DEPARTMENT
         */
        this.Form_stage_department = new Form_stage_department(this,this.link['dynamic']);
        this.Form_stage_department.setDepartmentList(this.department);
        this.Form_stage_department.set();
        /*
         * SET SECTION ROW
         */
        this.Form_stage_create_section.set(this.link['dynamic'],this.response.parameters);
    }
    setModalData(){
        console.log('Form_stage_show.setModalData()');
        console.log(this.response.stage);
        /*
         * SET TITLE
         */
        this.Form_stage_title = new Form_stage_title(this,this.link['dynamic'],this.response.stage[0].title);
        /*
         * SET DEPARTMENT
         */
        this.Form_stage_department = new Form_stage_department(this,this.link['dynamic']);
        this.Form_stage_department.setDepartmentList(this.department);
        this.Form_stage_department.addStageDepartment(this.response.stage[0].department_id,this.response.stage[0].department_name);
        this.Form_stage_department.set();
        /*
         * SET SECTION ROW WITH DATA
         */
        this.Form_stage_create_section.setWithData(this.link['dynamic'],this.response.parameters,this.response.stage[0]);
    }
    updateData(response){
        console.log('Form_stage_create.updateData()');
        //console.log(response);
        /*
         * UPDATE FormData
         */
        this.FormData=response;
        /*
         * UPDATE Modal info
         */
        super.setInfo("Form Stage ID: "+(this.FormData.stage[0].id_db).toString()+", Create user: "+this.FormData.user.create_user_login+" (e-mail: "+this.FormData.user.create_user_email+"), Create date: "+this.FormData.user.create_date+", Modification user: "+this.FormData.user.mod_user_login+" (e-mail: "+this.FormData.user.mod_user_email+"), Version: "+this.FormData.user.mod_date);
        /*
         * UPDATE SECTION, SUBSECTION AND ROW IDS
         */  
        console.log(this.FormData);
        console.log(this.Form_stage_create_section);
        this.Form_stage_create_section.updateId(this.FormData.stage[0].section);
    }
    getSectionData(self){
        console.log('Form_stage_create.getSectionData()');
        /*
         * self.Parent references to this object Form_stage_create
         */
        return self.Form_stage_create_section.getData();
    }
    preview(self){
        console.log('Form_stage_create.preview()');
        /*
         * self references to this object Form_stage_create
         */
        try{
            var stage={
                0:{
                    'id_db':0
                    ,'section':self.getSectionData(self)
                }
            };
            self.Form_stage_preview.load(self.link['preview'],stage);
        }
        catch(e){
            //console.clear();
            console.log("Form_stage_create.preview() catch()\r\n");
            console.error(e);
            /*
             * SET MODAL ERROR
             */
            self.setError('Application error occurred! Contact with Administrator!');
        }
    }
    save(self){
        console.log('Form_stage_create.save()');
        try{
            if(self.ErrorStack.check()){ 
                console.log('');
                return false;
            }
            console.log(self.FormData);
            self.FormData.stage[0].department_name = self.Form_stage_department.getName();
            self.FormData.stage[0].department_id = self.Form_stage_department.getValue();
            self.FormData.stage[0].title = self.Form_stage_title.getValue();
            self.FormData.stage[0].section = self.getSectionData(self);
            /*
             * self.Parent references to this object Form_stage_create
             */
            console.log(self.FormData.stage);
            new Form_stage_save(self);
        }
        catch(e){
            console.log("Form_stage_create.save() catch()",e);
            /*
             * SET MODAL ERROR
             */
            self.setError('Application error occurred! Contact with Administrator!');
        }
    }
}