class Form_stage_create extends Modal{
    permissions=new Array();
    appUrl='';
    router='';
    Department = new Object();
    Title = new Object();
    Property = new Object();
    Xhr=new Object();
    Form_stage_list = new Object();
    Form_stage_create_department = new Object();
    Form_stage_create_action = new Object();
    Form_stage_create_section = new Object();
    Parse = new Object();
    ErrorStack = new Object();
    FormData = {
        'id_db':'N/A'
        ,'user':{
            'create_user_login':'N/A'
            ,'create_user_email':'N/A'
            ,'create_date':'N/A'
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
                                                               ,'data':{
                                                                   0:{}
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
    }
    /*
     * SET PROPERTY
     */
    setProperty(property){
        //this.FormStage.create_user_id=property.user.userid;
        //this.FormStage.create_user_email=property.user.mail;
        //this.FormStage.create_user_login=property.user.username;
        this.permissions=property.user.perm;
        //const date = new Date();
        //this.FormStage.create_date=date.getFullYear().toString()+"-"+date.getMonth().toString()+"-"+date.getDate().toString()+" "+date.getHours().toString()+":"+date.getMinutes().toString()+":"+date.getSeconds().toString();
        //2023-08-09 15:15:24
    }
    /*
     * CREATE
     */
    create(response){
        try{
            console.log('Form_stage_create.create()');
            console.log(response);
             /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            console.log(this.response);
        }
        catch(e){
            console.log("Form_stage_create.create() parse catch()",e);
            this.Form_stage_list.setError(e);
            return false;
        }
        try{           
            /*
             * CLEAR ErrorStack
             */
            this.ErrorStack.clearStack();
            /*
             * SETUP MODAL
             */
            super.clearData();
            super.setExitKeys();
            super.setHead('Dodaj etap formularza','bg-info');
            super.setCloseModal();
            super.setInfo("Form Stage ID: "+(this.FormData.id_db).toString()+", Create user: "+this.FormData.user.create_user_login+" (e-mail: "+this.FormData.user.create_user_email+"), Create date: "+this.FormData.user.create_date);
            //console.log(this.link['adapted']);  
            console.log(this.link);
            /*
             * SET MAIN DYNAMIC FIELD
             */
            this.setModalMain();
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
            console.log("Form_stage_create.create() modal catch()",e);
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
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
    setModalMain(){
        console.log('Form_stage_create.setModalPreview()');
        var row=this.Html.getRow();
            row.setAttribute('id','main');
        var col=this.Html.getCol(12);
            row.append(col);
            /*
             * SET TITLE
             */
            this.Title = new Form_stage_create_title(this,col);
            /*
             * SET DEPARTMENT
             */
            this.Department = new Form_stage_create_department(this,col,this.response.department);
            /*
             * SET SECTION ROW
             */
            this.Form_stage_create_section.set(col,this.response.parameters);
            /*
             * SET LINK TO DYNAMIC
             */
            this.link['dynamic']=col;
            /*
             * APPEND TO ADAPTED
             */
            this.link['adapted'].append(row);  
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
        super.setInfo("Form Stage ID: "+(this.FormData.stage[0].id_db).toString()+", Create user: "+this.FormData.user.create_user_login+" (e-mail: "+this.FormData.user.create_user_email+"), Create date: "+this.FormData.user.create_date);
        /*
         * UPDATE SECTION, SUBSECTION AND ROW IDS
         */  
        console.log(this.FormData);
        console.log(this.Form_stage_create_section);
        this.Form_stage_create_section.updateId(this.FormData.stage[0].section);
        //this.FormData.user = response.user;
        //this.FormData.stage = response.stage;
    }
    getTitle(self){
        console.log('Form_stage_create.getTitle()');
        return self.Title.getValue();
    }
    getDepartmentName(self){
        console.log('Form_stage_create.getDepartmentName()');
        return self.Department.getName();
    }
    getDepartmentId(self){
        console.log('Form_stage_create.getDepartmetnId()');
        return self.Department.getValue();
    }
    getSectionData(self){
        console.log('Form_stage_create.getSectionData()');
         /*
         * self.Parent references to this object Form_stage_create
         */
        return self.Form_stage_create_section.getData();
        //return {};
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
            new Form_stage_preview(self.link['preview'],stage);
        }
        catch(e){
            console.log("Form_stage_create.preview() catch()",e);
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
            self.FormData.stage[0].department_name = self.getDepartmentName(self);
            self.FormData.stage[0].department_id = self.getDepartmentId(self);
            self.FormData.stage[0].title = self.getTitle(self);
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