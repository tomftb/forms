class Filled_form_table extends Table{
    Html= new Object();
    Parent = new Object();
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
            ,'title':'Wyświetl'
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
        this.Html = new Html();
    }
    setProperties(appUrl,url){
        //console.log('ProjectConst::setProperties()');
        this.appUrl=appUrl;
        this.router=url;
        //console.log(appUrl);
        //console.log(url);
    }
    runPOST(action){
        console.log('ProjectStageTable::runPost()',action);
        this.Table.unsetError();
        /* SET HEAD */
        this.Table.setHead(this.head);
        /* GET DATA => SET BODY */
        this.Table.receivePost(this,'setBody',router+action.u,action.d);
    }
    run(task){
        //console.log('ProjectStageTable.run()\ntask');
        //console.log(task);
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
        console.log('Filled_form_table.updateBody()');
        //console.log(responseData);
        //console.log(this.Parent.permissions);
        /* CLEAR TABLE */
        super.clearTable();
        /* SET HEAD */
        super.setHead(this.head);
        /* SET PERMISSIONS */
        this.setButtonsPermissions(this.Parent.permissions);
        /* UPDATE BODY DATA */
        for(const prop in responseData){
            //console.log(responseData[prop]);
            this.updateBodyRow(responseData[prop]);
        }
    }
    setBody(response){
        //console.log('Filled_form_table.setBody()');
        //console.log(response);
        /* PARSE RESPONSE */
        try{
            var data = JSON.parse(response);
            this.updateBody(data);
        }
        catch(error){
            super.setError('Application error occurred! Contact with Administrator!');
        }        
    }
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
    test(){
        console.log('Filled_form_table.test()');
    }
}