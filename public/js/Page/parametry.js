/*
 * 
 * GLOBAL functions:
 * removeHtmlChilds();
 * changeBoxValue();
 * createInput();
 * createTag();
 */

class parametry{
    
     Ajax;
     Error;
     defaultTask='getAllParm';
     fieldDisabled='n';
     run='runMain';
     defaultTableColumns={
        Skrót:{
            style:'width:70px;',
            scope:'col'
        },
        Nazwa:{
            style:'',
            scope:'col'
        },
        Opis:{
            style:'',
            scope:'col'
        },
        Wartość:{
            style:'width:400px;',
            scope:'col'
        }
    };
     defaultTableExceptionCol=new Array('i','md','mu','t','v');
     glossary={
        color:new Array()
        ,'text-align':new Array()
        ,'measurement':new Array()
        ,'font-family':new Array()
        ,'line-spacing':new Array()
        ,'list-type':new Array()
        ,parameters:new Array()
    };
    constructor() {
        this.init();
    }
    destructor(){
        
    }
    init(){
        this.Ajax = new Ajax();
        this.Ajax.setModul(this);
        this.Ajax.setModulTask('runFunction');
        this.Error = new Error();
        this.defaultTask='getAllParm';
        this.fieldDisabled='n';
        this.run='sAll';
    }
     runFunction(response){
        console.log('===runFunction()===');
        console.log(response);
        var jsonResponse={
            status:1,
            info:''
        };
        try{
            // RUN FUNCTION
            jsonResponse=JSON.parse(response);
            this.Error.checkStatusExist(jsonResponse); 
            console.log('FUNCTION TO RUN:\n'+jsonResponse['data']['function']);
            console.log(jsonResponse['data']['function']);
            console.log('run - ',this.run);
            switch(this.run)
            //switch(d['data']['function'])
            {
                case 'pUpdate':     
                    /* update user and date */
                    this.run='sAll';
                    this.Error.checkStatusResponse(jsonResponse);
                    var ele=document.getElementById('info_'+jsonResponse['data']['value']['i']);
                        ele.innerText='Update: '+jsonResponse['data']['value']['u']+', '+jsonResponse['data']['value']['d'];  
                    break;
                case 'runMain':
                    if(jsonResponse['data']['value']['perm'].indexOf('EDIT_PARM')===-1){
                        this.fieldDisabled='y';
                    };
                    this.glossary.color=jsonResponse['data']['value']['color'];
                    this.glossary['text-align']=jsonResponse['data']['value']['text-align'];
                    this.glossary['measurement']=jsonResponse['data']['value']['measurement'];
                    this.glossary['font-family']=jsonResponse['data']['value']['font-family'];
                    this.glossary['line-spacing']=jsonResponse['data']['value']['line-spacing'];
                    this.glossary['list-type']=jsonResponse['data']['value']['list-type'];
                    this.glossary.parameters=jsonResponse['data']['value']['parm'];
                    this.run='sAll';
                case 'sAll': 
                    this.displayAll(jsonResponse['data']['value']['parm']);
                    break;
                default:
                    this.Error.checkStatusResponse(jsonResponse);
                    break;
            }
        }
        catch(e){
            jsonResponse['status']=1;
            jsonResponse['info']=e;
            this.Error.checkStatusResponse(jsonResponse);
            console.log(e);
        }
    }
     displayAll(d)
    { 
        /* SETUP DEFAULT TABLE COLUMN */
        console.log('displayAll',d);
        var defaultTableCol=document.getElementById("colDefaultTable");
            removeHtmlChilds(defaultTableCol);
        for (const c in this.defaultTableColumns)
        {
            var th=createTag(c,'th','');
            for(const atr in this.defaultTableColumns[c]){
                th.setAttribute(atr,this.defaultTableColumns[c][atr]);
            }
            defaultTableCol.appendChild(th);
        }
        /* CREATE ROW */
        var pd=document.getElementById("defaultTableRows");
        /* remove old data */
        removeHtmlChilds(pd);
        for(var i = 0; i < d.length; i++)
        {    
            var tr=createTag('','tr','');
                this.assignDefaultTableData(tr,d[i]);
            pd.appendChild(tr);
        }
        //console.log(pd);
    }
     assignDefaultTableData(tr,d)
    {
        /* d => object with data */
        for (const property in d){        
            if(!this.defaultTableExceptionCol.includes(property)){
                var td=createTag(d[property],'td','');
                tr.appendChild(td);
            } 
        }
        tr.appendChild(this.createTableEditField(d));
    }
     createTableEditField(d){
        var field={
            type:''
            ,input:'input'
            ,data:new Array()
        };
        /*
         * d['t'],d['v'],d['i'],d['md'],d['mu']
         * type,value,id,date,user
         */
        /*
         * SET INPUT TYPE:
         * input,select
         */
        this.setInputType(field,d);
         /*
          * SET INPUT TYPE:
          * password,test,number,checkbox
          */
        this.setFieldType(field,d['t']);
        /*
         * CREATE INPUT
         */
        var input = this['create'+field.input](field,d);
        
         /*
         * SET ON CHANGE
         */
        this.setOnChange(input);
        /*
         * SET ON CLICK
         */
        this.setOnClick(field.type,input);
        /*
         * CREATE TD
         */
        var td=createTag('','td','');
            td.appendChild(input);
        var info=createTag("Update: "+d['mu']+", "+d['md'],'small','text-sm-left text-secondary');
            info.setAttribute('id','info_'+d['i']);
            td.appendChild(info);     
        return td;
    }
     createSelect(field,d){
        console.log('this.createSelect()');
        return createSelectFromObject2(field.data,'n','v',d['i'],'form-control');
    }
     createInput(field,d){
        console.log('this.createInput()');
        return createInput(field.type,d['i'],d['v'],'form-control mb-1','',this.fieldDisabled);
    }
     setFieldType(field,type){
        switch(type){
            case 'c': /* checkbox */
                field.type='checkbox';
                break 
            case 'n': /* input number */
                field.type='number';
                break;
            case 'p': /* input password */
                field.type='password';
                break  
            case 't': /* input text */
            default:
                field.type='text';
                break;
        }
    }
     setInputType(field,d){
       
        switch(d['t']){
            case 's-color':
                field.data=this.getList(d,this.glossary.color);
                field.input='Select';
                break;
            case 's-text-align':
                field.data=this.getList(d,this.glossary['text-align']);
                field.input='Select';
                break;
            case 's-measurement':
                //console.log('measurement');
                field.data=this.getList(d,this.glossary['measurement']);
                field.input='Select';
                break;
            case 's-font-family':
                //console.log('measurement');
                field.data=this.getList(d,this.glossary['font-family']);
                field.input='Select';
                break;
            case 's-line-spacing':
                //console.log('measurement');
                field.data=this.getList(d,this.glossary['line-spacing']);
                field.input='Select';
                break;
            case 's-list-type':
                //console.log('measurement');
                field.data=this.getList(d,this.glossary['list-type']);
                field.input='Select';
                break;
            default:
                field.input='Input';
                break;
        }
    }
     setOnClick(type,input){
        switch(type){
            case 'c': /* checkbox */
                input.onclick=function(){
                    changeBoxValue(this);
                };
                break 
            default:/* NO ACTION */
                break;
        }           
    }
    setOnChange(input){
        var self = this;
        input.onchange=function (t){
            //console.log(t);
            //console.log(self);
            /*
             * t - this
             * s - self
             */
            self.run='pUpdate';
            var form=createForm('POST','updateParm','form-horizontal','OFF');
                form.appendChild(createInput('hidden','id',this.name,'',''));
                form.appendChild(createInput('hidden','value',this.value,'',''));
                self.Ajax.sendData(form,'POST');
        };
    }
     getList(d,glossary){
        var first=new Array();
        var rest=new Array();
        for(const prop in glossary){
            if(glossary[prop].v===d.v){
                first.push(glossary[prop]);
                /* SKIP */
                continue;
            }
            rest.push(glossary[prop]);
        };
        return first.concat(rest);
    }
     findData(value){
        this.Ajax.getData(defaultTask+"&f="+value);
    }
     loadData(){
        console.log('---loadData()---');
        //ajax.getData(defaultTask);
        console.log(this.Error);
        this.Error.set('overAllErr');
        this.run='runMain';
        this.Ajax.getData('getModulParametersDefaults');
    }   
}
/*
 * SET
 */
var Parameters = new parametry();

/*
 * RUN DEFAULT TASK (METHOD)
 */
Parameters.loadData();