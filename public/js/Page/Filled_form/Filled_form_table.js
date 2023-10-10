class Filled_form_table extends Table{
    Html= new Object();
    Parent = new Object();
    Parse = new Object();
    /* FROM ProjectConst 'getprojectsconstslike&u=0&v=1&b=' */
    defaultTask='';
    appUrl='';
    router='';
    detailsTask='detailsText';
    Table = new Object();
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
            ,'title':'Kreator'
            ,'class':'btn-info'
            ,'action':'showFormModal'
            ,'url':'getFormDescription&id='
            ,'permission':'SHOW_FORM'
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
            ,'permission':'HIDE_FORM'
        }
        ,'remove':{
            'set':'getButton'//getRemoveButton
            ,'title':'Usuń'
            ,'class':'btn-danger'
            ,'action':'showRemoveModal'
            ,'url':'getRemoveFormGlossary&id='
            ,'permission':'REMOVE_FORM'
        }
    }
    constructor(Parent){
        console.log('Filled_form_table.construct()');  
        super();
        this.Parent=Parent;
        this.Parse = new Parse();
        this.Html = new Html();
       
    }
    init(permissions){
        console.log('Filled_form_table.init()');  
        //console.log(permissions);
        /* SET HEAD */
        super.setHead(this.head);
         /* SET PERMISSIONS */
        this.setButtonsPermissions(permissions);
    }
    setProperties(appUrl,url){
        console.log('Filled_form_table.setProperties()');
        this.appUrl=appUrl;
        this.router=url;
    }
    run(task){
        console.log("Filled_form_table.run()\r\ntask",task);
        super.unsetError();
        this.defaultTask=task;
        /* CLEAR TABLE */
        super.clearTable();   
         /* SET HEAD */
        super.setHead(this.head);
        /* GET DATA => SET BODY */
        super.getData(this,'setBody',this.router+task);
    }
    updateBody(responseData){
        //console.log('Filled_form_table.updateBody()');
        /* UPDATE BODY DATA */
        for(const prop in responseData){
            //console.log(prop);
            //console.log(responseData[prop]);
            //console.log(responseData[prop]);
            this.updateBodyRow(responseData[prop]);
        }
    }
    //setBody(response){
       // console.log('Filled_form_table.setBody()');
      ///  try{
        //    var data = JSON.parse(response);
        //    this.updateBody(data);
        //}
       // catch(error){
         //   super.setError('Application error occurred! Contact with Administrator!');
      //  }        
  //  }
    updateBodyRow(bodyRow){      
        //console.log('Filled_form_table.updateBodyRow()');
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
    //setBlockUserInfo(ele,value){
    //    if(value==='' || value===null){ return true; };
     //   var small=document.createElement('small');
     //       small.classList.add('text-danger');
      //  var label = document.createTextNode(" Actual blocked by user: "+value);
      //  var i = document.createElement('i');
       //     i.classList.add('fa','fa-info');
       //     small.appendChild(i);
       //     small.appendChild(label);
       //     ele.appendChild(small);
   // }
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
        //console.log('Filled_form_table.setGroupBtn('+id+')');
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
        //console.log('Filled_form_table.getShowButton()');
        var button  = this.getButtonEle(prop.title,prop.class);
        var self = this;
            button.onclick = function (){
                console.log("Filled_form_table.getButton() onclick()");
                self.Xhr.setOnError2(self,'setError');
                self.unsetError();
                self.Xhr.get(self.Parent,prop.action,self.Parent.router+prop.url+id);
            };
        return button;
    }
    checkPermission(permissions,perm){
        for (const p in permissions){
            //console.log(this.Parent.permissions[p]);
            if(permissions[p]===perm){
                return true;
            }
        }
        return false;
    }
    setButtonsPermissions(permissions){
        console.log('Filled_form_table.setButtonsPermissions()');
        for (const prop in this.button){
            //console.log(this.button[prop]);
            if(!this.checkPermission(permissions,this.button[prop].permission)){
                this.button[prop].set='getDisabledButton';
            }
        }
    }

    reload(){
        console.log('Filled_form_table.reload()');
        console.log(self);
        /*
         * RUN XHR
         */
        this.Xhr.setOnError2(this,'setError');
        this.Xhr.get(this,'reloadBody',self.router+'reloadFormList');
    }
    reloadBody(response){
        console.log('Filled_form_table.reloadBody()');
         /*
         * CLEAR TABLE BODY
         */
        super.clearBody();
        /*
         * SET NEW TABE BODY DATA
         */
        this.set(response);
    }
    set(response){
        console.log('Filled_form_table.set()');
        console.log(response);
        /*
         * CLEAR TABLE HEAD ERROR
         */
        super.clearError();
        /*
         * SET RESPONSE
         */
        this.setResponse(response);
         /*
          * SET BODY
          */
        this.updateBody(this.response.form);
    }
    setResponse(response){
        console.log('Filled_form_table.setResponse()');
        try {
            /*
             * PARSE RESPONSE
             */
            this.response = this.Parse.getSimpleJson(response);
            //console.log(this.response);
        }
        catch (e) {
            console.log('Form_stage_list.setResponse().catch()');
            console.log(e);
            this.setError(e);
            //this.setError('Application error occurred! Contact with Administrator!');
            return {};
        }
        return {};
    }
}