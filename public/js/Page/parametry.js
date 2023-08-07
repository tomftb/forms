/*
 * 
 * GLOBAL functions:
 * removeHtmlChilds();
 * changeBoxValue();
 * createInput();
 * createTag();
 */

class parametry{
    
    static Ajax;
    static Error;
    static defaultTask='getAllParm';
    static fieldDisabled='n';
    static run='runMain';
    static defaultTableColumns={
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
    static defaultTableExceptionCol=new Array('i','md','mu','t','v');
    static glossary={
        color:new Array()
        ,'text-align':new Array()
        ,'measurement':new Array()
        ,'font-family':new Array()
        ,'line-spacing':new Array()
        ,'list-type':new Array()
        ,parameters:new Array()
    };
    constructor() {
        
    }
    destructor(){
        
    }
    static init(){
        parametry.Ajax = new Ajax();
        parametry.Ajax.setModul(parametry);
        parametry.Ajax.setModulTask('runFunction');
        parametry.Error = new Error();
        parametry.defaultTask='getAllParm';
        parametry.fieldDisabled='n';
        parametry.run='sAll';
        
    }
    static runFunction(response){
        console.log('===runFunction()===');
        console.log(response);
        var jsonResponse={
            status:1,
            info:''
        };
        try{
            // RUN FUNCTION
            jsonResponse=JSON.parse(response);
            parametry.Error.checkStatusExist(jsonResponse); 
            console.log('FUNCTION TO RUN:\n'+jsonResponse['data']['function']);
            console.log(jsonResponse['data']['function']);
            console.log('run - ',parametry.run);
            switch(parametry.run)
            //switch(d['data']['function'])
            {
                case 'pUpdate':     
                    /* update user and date */
                    parametry.run='sAll';
                    parametry.Error.checkStatusResponse(jsonResponse);
                    var ele=document.getElementById('info_'+jsonResponse['data']['value']['i']);
                        ele.innerText='Update: '+jsonResponse['data']['value']['u']+', '+jsonResponse['data']['value']['d'];  
                    break;
                case 'runMain':
                    if(jsonResponse['data']['value']['perm'].indexOf('EDIT_PARM')===-1){
                        parametry.fieldDisabled='y';
                    };
                    parametry.glossary.color=jsonResponse['data']['value']['color'];
                    parametry.glossary['text-align']=jsonResponse['data']['value']['text-align'];
                    parametry.glossary['measurement']=jsonResponse['data']['value']['measurement'];
                    parametry.glossary['font-family']=jsonResponse['data']['value']['font-family'];
                    parametry.glossary['line-spacing']=jsonResponse['data']['value']['line-spacing'];
                    parametry.glossary['list-type']=jsonResponse['data']['value']['list-type'];
                    parametry.glossary.parameters=jsonResponse['data']['value']['parm'];
                    parametry.run='sAll';
                case 'sAll': 
                    parametry.displayAll(jsonResponse['data']['value']['parm']);
                    break;
                default:
                    parametry.Error.checkStatusResponse(jsonResponse);
                    break;
            }
        }
        catch(e){
            jsonResponse['status']=1;
            jsonResponse['info']=e;
            parametry.Error.checkStatusResponse(jsonResponse);
            console.log(e);
        }
    }
    static displayAll(d)
    { 
        /* SETUP DEFAULT TABLE COLUMN */
        console.log('displayAll',d);
        var defaultTableCol=document.getElementById("colDefaultTable");
            removeHtmlChilds(defaultTableCol);
        for (const c in parametry.defaultTableColumns)
        {
            var th=createTag(c,'th','');
            for(const atr in parametry.defaultTableColumns[c]){
                th.setAttribute(atr,parametry.defaultTableColumns[c][atr]);
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
                parametry.assignDefaultTableData(tr,d[i]);
            pd.appendChild(tr);
        }
        //console.log(pd);
    }
    static assignDefaultTableData(tr,d)
    {
        /* d => object with data */
        for (const property in d){        
            if(!parametry.defaultTableExceptionCol.includes(property)){
                var td=createTag(d[property],'td','');
                tr.appendChild(td);
            } 
        }
        tr.appendChild(parametry.createTableEditField(d));
    }
    static createTableEditField(d){
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
        parametry.setInputType(field,d);
         /*
          * SET INPUT TYPE:
          * password,test,number,checkbox
          */
        parametry.setFieldType(field,d['t']);
        /*
         * CREATE INPUT
         */
        var input = parametry['create'+field.input](field,d);
        
         /*
         * SET ON CHANGE
         */
        parametry.setOnChange(input);
        /*
         * SET ON CLICK
         */
        parametry.setOnClick(field.type,input);
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
    static createSelect(field,d){
        console.log('parametry.createSelect()');
        return createSelectFromObject2(field.data,'n','v',d['i'],'form-control');
    }
    static createInput(field,d){
        console.log('parametry.createInput()');
        return createInput(field.type,d['i'],d['v'],'form-control mb-1','',parametry.fieldDisabled);
    }
    static setFieldType(field,type){
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
    static setInputType(field,d){
       
        switch(d['t']){
            case 's-color':
                field.data=parametry.getList(d,parametry.glossary.color);
                field.input='Select';
                break;
            case 's-text-align':
                field.data=parametry.getList(d,parametry.glossary['text-align']);
                field.input='Select';
                break;
            case 's-measurement':
                //console.log('measurement');
                field.data=parametry.getList(d,parametry.glossary['measurement']);
                field.input='Select';
                break;
            case 's-font-family':
                //console.log('measurement');
                field.data=parametry.getList(d,parametry.glossary['font-family']);
                field.input='Select';
                break;
            case 's-line-spacing':
                //console.log('measurement');
                field.data=parametry.getList(d,parametry.glossary['line-spacing']);
                field.input='Select';
                break;
            case 's-list-type':
                //console.log('measurement');
                field.data=parametry.getList(d,parametry.glossary['list-type']);
                field.input='Select';
                break;
            default:
                field.input='Input';
                break;
        }
    }
    static setOnClick(type,input){
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
    static setOnChange(input){
        input.onchange=function (){
            parametry.run='pUpdate';
            var form=createForm('POST','updateParm','form-horizontal','OFF');
                form.appendChild(createInput('hidden','id',this.name,'',''));
                form.appendChild(createInput('hidden','value',this.value,'',''));
                parametry.Ajax.sendData(form,'POST');
        };
    }
    static getList(d,glossary){
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
    static findData(value){
        this.Ajax.getData(defaultTask+"&f="+value);
    }
    static loadData(){
        console.log('---loadData()---');
        //ajax.getData(defaultTask);
        console.log(parametry.Error);
        parametry.Error.set('overAllErr');
        parametry.run='runMain';
        parametry.Ajax.getData('getModulParametersDefaults');
    }   
}
/*
 * SET INIT VALUE
 */
parametry.init();
/*
 * RUN DEFAULT TASK (METHOD)
 */
parametry.loadData();