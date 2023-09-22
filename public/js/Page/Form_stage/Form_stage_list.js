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
            title:'Data utworzenia',
            attribute:{
                scope:'col'
            }
        },
        3:{
            title:'Data modyfikacji',
            attribute:{
                scope:'col'
            }
        },
        4:{
            title:'',
            style:{
                width:'200px'
            },
            attribute:{
                scope:'col'
            }
        }};
    body={
        0:'i'
        ,1:'n'
        ,2:'cd'
        ,3:'md'
    };
    button={
        'show':{
            'set':'getButton'// //getDisabledButton
            ,'title':'Wyświetl'
            ,'class':'btn-info'
            ,'action':'showFormModal'
            ,'url':'getFormDescription&id='
            ,'permission':'SHOW_FORM_STAGE'
        }
        ,'filled':{
            'set':'getButton'// //getDisabledButton
            ,'title':'Zestawienie'
            ,'class':'btn-purple'
            ,'action':'showFilledModal'
            ,'url':'getFilledForms&id='
            ,'permission':'SHOW_LIST_FILLED_FORM'
        }
        ,'hide':{
            'set':'getButton'//getHideButton
            ,'title':'Ukryj'
            ,'class':'btn-secondary'
            ,'action':'showHideModal'
            ,'url':'getHideFormGlossary&id='
            ,'permission':'HIDE_FORM_STAGE'
        }
        ,'remove':{
            'set':'getButton'//getRemoveButton
            ,'title':'Usuń'
            ,'class':'btn-danger'
            ,'action':'showRemoveModal'
            ,'url':'getRemoveFormGlossary&id='
            ,'permission':'REMOVE_FORM_STAGE'
        }
    }
    constructor(Parent){
        super();
        console.log('Form_stage_table.construct()');  
        this.Parent=Parent;
        this.Parse=new Parse();
        this.Xhr=new Xhr2();
        //this.Parse = new Parse();
        this.Html = new Html();
        
    }
    setHead(){
        super.setHead(this.head);
    }
    setProperties(appUrl,url){
        //console.log('ProjectConst::setProperties()');
        this.appUrl=appUrl;
        this.router=url;
        //console.log(appUrl);
        //console.log(url);
    }
    runPOST(action){
        console.log('Form_stage_table.runPost()',action);
        super.unsetError();
        /* SET HEAD */
        //super.setHead(this.head);
        /* GET DATA => SET BODY */
        super.receivePost(this,'setBody',router+action.u,action.d);
    }
    run(task){
        //console.log('Form_stage_table.run()\ntask');
        //console.log(task);
        super.unsetError();
        this.defaultTask=task;
        /* CLEAR TABLE */
        super.clearTable();   
         
        /* GET DATA => SET BODY */
        super.getData(this,'setBody',this.router+task);
    }
    setBody(response){
        console.log('Form_stage_table.setBody()');
        try {
            /*
             * UPDATE BODY DATA
             */
            for(const prop in response){
                this.updateBodyRow(response[prop]);
            }
        }
        catch (error) {
            console.log('Form_stage_table.setBody().catch()');
            console.log(error);
            this.setError('Application error occurred! Contact with Administrator!');
            return {};
        }
    }

    updateBodyRow(bodyRow){      
        //console.log('Form_stage_table.updateBodyRow()');
        var tr=document.createElement('TR');
        for(const prop in this.body){         
            //console.log(prop);
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
        //console.log('ProjectStageTable::setBodyRowColButton()');
        var col = document.createElement('TD');
        var buttonGroup=this.setButtonGroup(value.i);
            col.appendChild(buttonGroup);
            //this.setBlockUserInfo(col,value.bl);
            //console.log(col);
        return col;
    }
    setButtonGroup(id){
        //console.log('Form_stage_table.setGroupBtn('+id+')');
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
        //console.log('Form_stage_table.getShowButton()');
        var btnEle  = this.getButtonEle(prop.title,prop.class);
        var self = this;
        var AjaxRun = this.getXhrRunProperty(prop.url+id);
            AjaxRun.m=prop.action;
            btnEle.onclick = function (){
                //$(self.Parent.Modal.link['main']).modal('show');
                self.unsetError();
                self.Xhr.setOnError({o:self, m:'setError'});
                self.Xhr.run(AjaxRun);
            };
        return btnEle;
    }
    getXhrRunProperty(task){
        var run={
            t:"GET",
            u:this.Parent.router+task,
            c:true,
            d:null,
            o:this.Parent,
            m:''
        };
        return run;
    }
    setPermissions(permissions){
        //console.log('Form_stage_table.setPermissions()');
        this.setButtonPermission(permissions);
    }
    setButtonPermission(permissions){
        //console.log('Form_stage_table.setButtonPermission()');
        for (const prop in this.button){
            //console.log(this.button[prop]);
            if(!permissions.includes(this.button[prop].permission)){
                //console.log('Form_stage_table.setButtonPermission() not include `'+this.button[prop].permission+'`');
                this.button[prop].set='getDisabledButton';
            }
        }
    }
    setResponse(response){
        //console.log('Form_stage_table.setResponse()');
        try {
            /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            //console.log(this.response);
        }
        catch (error) {
            console.log('Form_stage_table.setResponse().catch()');
            console.log(error);
            this.setError('Application error occurred! Contact with Administrator!');
            return {};
        }
        return {};
    }
    get(Parent){
        console.log('Form_stage_table.get()');
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
        console.log('Form_stage_table.set()');
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
}