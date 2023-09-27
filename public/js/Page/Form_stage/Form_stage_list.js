class Form_stage_list extends Table{
    Html= new Object();
    //Parse = new Object();
    Xhr = new Object();
    Parent = new Object();
    defaultTask='';
    appUrl='';
    router='';
    detailsTask='detailsText';
    response=new Object();

    
    head={
        0:{
            title:'ID',
            style:{
                width:'70px' /* NO SEMICOLON */
            },
            attribute:{
                scope:'col'
            }
        },
        1:{
            title:'Nazwa',
            attribute:{
                scope:'col'
            }
        },
        2:{
            title:'Department',
            attribute:{
                scope:'col'
            }
        },
        3:{
            title:'Data utworzenia',
            attribute:{
                scope:'col'
            }
        },
        4:{
            title:'Data modyfikacji',
            attribute:{
                scope:'col'
            }
        },
        5:{
            title:'',/* BUTTONS */
            style:{
                width:'200px'
            },
            attribute:{
                scope:'col'
            }
        }};
    body={
        0:'id'
        ,1:'title'
        ,2:'department_name'
        ,3:'create_date'
        ,4:'mod_date'
    };
    button={
        'show':{
            'set':'getButton'// //getDisabledButton
            ,'title':'Wyświetl'
            ,'class':'btn-info'
            ,'action':'editStage'
            ,'url':'getFormStageShowData&id='
            ,'permission':'SHOW_FORM_STAGE'
        }
        ,'hide':{
            'set':'getButton'//getHideButton
            ,'title':'Ukryj'
            ,'class':'btn-secondary'
            ,'action':'hideStage'
            ,'url':'getFormStageHideData&id='
            ,'permission':'HIDE_FORM_STAGE'
        }
        ,'remove':{
            'set':'getButton'//getRemoveButton
            ,'title':'Usuń'
            ,'class':'btn-danger'
            ,'action':'removeStage'
            ,'url':'getFormStageRemoveData&id='
            ,'permission':'REMOVE_FORM_STAGE'
        }
    }
    constructor(){
        super();
        console.log('Form_stage_list.construct()');  
        this.Parse=new Parse();
        this.Xhr=new Xhr2();
        this.Html = new Html();

    }
    setHead(){
        console.log('Form_stage_list.setHead()');  
        super.setHead(this.head);
    }
    setProperties(appUrl,url){
        console.log('Form_stage_list.setProperties()');  
        this.appUrl=appUrl;
        this.router=url;
        //console.log(appUrl);
        //console.log(url);
    }
    runPOST(action){
        console.log('Form_stage_list.runPost()',action);
        super.unsetError();
        /* SET HEAD */
        //super.setHead(this.head);
        /* GET DATA => SET BODY */
        super.receivePost(this,'setBody',router+action.u,action.d);
    }
    run(task){
        //console.log('Form_stage_list.run()\ntask');
        //console.log(task);
        super.unsetError();
        this.defaultTask=task;
        /* CLEAR TABLE */
        super.clearTable();   
         
        /* GET DATA => SET BODY */
        super.getData(this,'setBody',this.router+task);
    }
    setBody(response){
        console.log('Form_stage_list.setBody()');
        try {
            /*
             * UPDATE BODY DATA
             */
            for(const prop in response){
                this.updateBodyRow(response[prop]);
            }
        }
        catch (error) {
            console.log('Form_stage_list.setBody().catch()');
            console.log(error);
            this.setError('Application error occurred! Contact with Administrator!');
            return {};
        }
    }
    updateBodyRow(bodyRow){      
        //console.log('Form_stage_list.updateBodyRow()');
        //console.log(bodyRow);
        var tr=document.createElement('TR');
        for(const prop in this.body){         
            //console.log(prop);
            //console.log(this.body[prop]);
            tr.appendChild(this.setBodyRowColData(bodyRow[this.body[prop]]));
        };
        tr.appendChild(this.setBodyRowColButton(bodyRow));
        this.link['body'].appendChild(tr);
    }
    setBodyRowColData(value){
        var col = document.createElement('TD');
            col.innerHTML=value;
            return col;
    }
    setBodyRowColButton(value){
        console.log('Form_stage_list.setBodyRowColButton()',value);
        var col = document.createElement('TD');
        var buttonGroup=this.setButtonGroup(value[this.body[0]]);
            col.appendChild(buttonGroup);
            //this.setBlockUserInfo(col,value.bl);
            //console.log(col);
        return col;
    }
    setButtonGroup(id){
        console.log('Form_stage_list.setGroupBtn() id - ',id);
        //console.log(Ajax);
        /* ADD LOAD INFO */
        var btnGroup=document.createElement('DIV');
            btnGroup.setAttribute('class','btn-group pull-left');
            for (const prop in this.button){
                //console.log(this.button[prop]);
                //console.log(this.button[prop].set);
                btnGroup.appendChild(this[this.button[prop].set](this.button[prop],id));
            }
        /* ADD ROW WITH BLOCK USER INGO */
        return btnGroup;
    }
    getButtonEle(title,c){
        var btn = document.createElement('BUTTON'); 
            btn.innerHTML=title;
            btn.setAttribute('class','btn '+c);
        return btn;
    }
    getDisabledButton(prop,id){
        var btnEle  = this.getButtonEle(prop.title,prop.class);
            btnEle.classList.add('disabled');
            btnEle.setAttribute('disabled','');
        return btnEle;
    }
    getButton(prop,id){
        //console.log('Form_stage_list.getButton()');
        console.log(this.Parent);
        var btnEle  = this.getButtonEle(prop.title,prop.class);
        var self = this;
        var AjaxRun = {
                    t:"GET"
                    ,u:self.router+prop.url+id
                    ,c:true
                    ,d:null
                    ,o:this.Parent
                    ,m:prop.action
                };
           
            btnEle.onclick = function (){
                console.log('Form_stage_list.getButton() onclick()');
                console.log(prop);
                console.log(id);
                console.log(AjaxRun);
                
                //$(self.Parent.Modal.link['main']).modal('show');
                //self.unsetError();
                //self.Xhr.setOnError({o:self, m:'setError'});
                //self.Xhr.run(AjaxRun);
            };
        return btnEle;
    }
    setPermissions(permissions){
        //console.log('Form_stage_list.setPermissions()');
        this.setButtonPermission(permissions);
    }
    setButtonPermission(permissions){
        //console.log('Form_stage_list.setButtonPermission()');
        for (const prop in this.button){
            //console.log(this.button[prop]);
            if(!permissions.includes(this.button[prop].permission)){
                //console.log('Form_stage_list.setButtonPermission() not include `'+this.button[prop].permission+'`');
                this.button[prop].set='getDisabledButton';
            }
        }
    }
    setResponse(response){
        //console.log('Form_stage_list.setResponse()');
        try {
            /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            //console.log(this.response);
        }
        catch (error) {
            console.log('Form_stage_list.setResponse().catch()');
            console.log(error);
            this.setError('Application error occurred! Contact with Administrator!');
            return {};
        }
        return {};
    }
    get(Parent){
        console.log('Form_stage_list.get()');
        /*
         * 
         * @param {type} response
         * @returns {void}
         */
        
        /*
         * SET XHR ERROR
         */
        this.Xhr.setOnError({
            'o':this
            ,'m':'setError'
        }); 
        /*
         * RUN XHR
         */
        this.Xhr.run({
                    t:'GET',
                    u:self.router+'getFormStageList',
                    c:true,
                    d:null,
                    o:this,
                    m:'set'
        });
        
    }
    set(response){
        console.log('Form_stage_list.set()');
        console.log(response);
        /*
         * CLEAR TABLE HEAD ERROR
         */
        this.clearError();
        /*
         * SET RESPONSE
         */
        this.setResponse(response);
         /*
          * SET BODY
          */
        this.setBody(this.response);
    }
    setParent(Parent){
        this.Parent=Parent;
    }
}