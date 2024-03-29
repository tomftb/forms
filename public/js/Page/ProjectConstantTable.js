class ProjectConstantTable{
    Xhr= new Object();
    //XhrModal= new Object();
    Html= new Object();
    Parent = new Object();
    Table = new Object ();
    /* FROM ProjectConst 'getprojectsconstslike&u=0&v=1&b=' */
    defaultTask='';
    appUrl='';
    router='';
    
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
            style:{
                    width:'200px'
            },
            attribute:{
                scope:'col'
            }
        },
        2:{
            title:'Wartość',
            
            attribute:{
                scope:'col'
            }
        },
        3:{
            title:'',
            style:{
                width:'200px'
            },
            attribute:{
                scope:'col'
            }
        }};
    body={
        0:'0',
        1:'1',
        2:'2'
    };
    tableColException=new Array('bl');
    tableBody;
    constructor(Parent){
        //console.log('ProjectConstTable::construct()');  
        //console.log(Parent);
        this.Parent=Parent;
        this.Table=Parent.Items.Table;
        this.Xhr=Parent.Items.Xhr;
        this.Html=Parent.Items.Html;
    }
    setProperties(appUrl,url,defaultTask){
        //console.log('ProjectConstTable::setProperties()');
        this.defaultTask=defaultTask;
        this.appUrl=appUrl;
        this.router=url;
        //console.log(appUrl);
        //console.log(defaultTask);
        //console.log(url);
    }
    runPOST(action){
        console.log('ProjectConstTable::runPost()',action);
        this.Table.unsetError();
        /* SET HEAD */
        this.Table.setHead(this.head);
        /* GET DATA => SET BODY */
        this.Table.receivePost(this,'setBody',router+action.u,action.d);
    }
    run (task){
        try{
            this.Table.unsetError();
            this.defaultTask=task;
             /* CLEAR TABLE */
            this.Table.clearTable();   
             /* SET HEAD */
            this.Table.setHead(this.head);
            /* GET DATA => SET BODY */
            this.Table.getData(this,'setBody',task);
        }
        catch(error){
            console.log('ProjectConstCreate::prepare()');
            console.log(error);
            //throw 'An Application Error Has Occurred!';
            this.Parent.Table.setError('An Application Error Has Occurred!');
        }
        
    }
    updateBody(responseData){
        console.log(responseData);
        /* CLEAR TABLE */
        this.Table.clearTable();
        /* SET HEAD */
        this.Table.setHead(this.head);
        /* UPDATE BODY DATA */
        for(const prop in responseData.data.value.data){
            this.updateBodyRow(responseData.data.value.data[prop]);
        }
    }
    setBody(response){
        //console.log('ProjectStageTable::setBody()');
        /* PARSE RESPONSE */
        var data = this.Parent.Items.setTableResponse(response);
        if(this.Table.error){
            console.log('Table error:',this.Table.error);
            return false;
        };
        this.updateBody(data);
    }
    updateBodyRow(bodyRow){      
        var tr=document.createElement('TR');
        for(const prop in this.body){           
            tr.appendChild(this.setBodyRowColData(bodyRow[this.body[prop]]));
        };
        tr.appendChild(this.setBodyRowColButton(bodyRow));
        this.Table.link['body'].appendChild(tr);
    }

    setBodyRowColData(value){
        var col = document.createElement('TD');
            col.innerHTML=value;
            return col;
    }
    setBlockUserInfo(ele,value){
        if(value==='' || value===null){ return true; };
        var small=document.createElement('small');
            small.classList.add('text-danger');
        var label = document.createTextNode(" Actual blocked by user: "+value);
        var i = document.createElement('i');
            i.classList.add('fa','fa-info');
            small.appendChild(i);
            small.appendChild(label);
            ele.appendChild(small);
    }
    setBodyRowColButton(value){
        //console.log('ProjectConstTable::setBodyRowColButton()');
        var col = document.createElement('TD');
        var buttonGroup=this.setButtonGroup(value);
            col.appendChild(buttonGroup);
            this.setBlockUserInfo(col,value.bl);
            //console.log(col);
        return col;
    }
    setButtonGroup(value){
        //console.log('TableNew::setGroupBtn()');
        //console.log(value);
        var btnGroup=document.createElement('DIV');
            btnGroup.setAttribute('class','btn-group pull-left');
            btnGroup.appendChild(this.getShowButton(this.Xhr,value[0]));
            btnGroup.appendChild(this.getHideButton(this.Xhr,value));
            btnGroup.appendChild(this.getDeleteButton(this.Xhr,value));
        /* ADD ROW WITH BLOCK USER INGO */
        
        return btnGroup;
    }
    getButton(title,c){
        var btn = document.createElement('BUTTON'); 
            btn.innerHTML=title;
            btn.setAttribute('class','btn '+c);
        return btn;
    }
    getShowButton(Ajax,id){
        var btn  = this.getButton('Wyświetl','btn-info');    
        
            var AjaxRun = this.getXhrRunProperty('getProjectConstantDetails&id='+id);
                AjaxRun.m='details';
                AjaxRun.o=this.Parent;
                btn.onclick = function (){
                    Ajax.run(AjaxRun);
                };
        
        
        return btn;
    }
    getHideButton(Ajax,v){
        var btn  = this.getButton('Ukryj','btn-secondary');
        if(v['bl']){
              this.Html.setDisabled(btn);
        }
        else{
        var AjaxRun = this.getXhrRunProperty('getProjectConstantHideSlo&id='+v[0]);
            btn.onclick = function (){
                Ajax.run(AjaxRun);
            };
        }
        return btn;
    }
    getDeleteButton(Ajax,v){
        var btn  = this.getButton('Usuń','btn-danger');
        if(v['bl']){
              this.Html.setDisabled(btn);
        }
        else{
            var AjaxRun = this.getXhrRunProperty('getProjectConstantDelSlo&id='+v[0]);
                /* CLOSURE */
                AjaxRun.m='remove';
                btn.onclick = function (){

                        Ajax.run(AjaxRun);

                };
        }
        return btn;
    }
    getXhrRunProperty(task){
        var run={
            t:"GET",
            u:this.router+task,
            c:true,
            d:null,
            o:this.Parent,
            m:'hide'
        };
        return run;
    }
}