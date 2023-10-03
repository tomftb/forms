/*
 * CLASS Modal -> js/Main/Modal.js
 * CLASS TableNew -> js/Main/TableNew.js
 * CLASS Xhr -> js/Main/Xhr.js
 */
var error = false;
class Filled_form{

    Html = new Object();
    router='';
    appUrl='';
    /* FOR TABLE */
    Xhr = new Object();
    /* FOR MODAL */
    Xhr2 = new Object();
    Stage = new Object();
    Constant = new Object();
    Variable = new Object();
    Filled_form_table = new Object();
    ErrorStack = new Object();
    Department = new Object();
    Footer=new Object();
    Heading=new Object();
    loadModal;
    Form_creator = new Object();
    /*
     * USER APPLIACTION PERMISSIONS
     */
    permissions=new Object();
    default={
            method:'',
            title:{
                label:'Etapy',
                'text-color':'text-info'
            },
            url:{
                primary:'getProjectStages',
                active:'getProjectStages',
                hidden:'',
                deleted:'',
                hiddenAndDeleted:'',
                all:''
            }
    };
    /* SET PROPERTY LIKE ELE */
    filter={
        'hidden':{
            value:'0',
            checked:false
        },
        'deleted':{
            value:'0',
            checked:false
        },
        'all':{
            value:'0',
            checked:false
        },
        'search':{
            value:''
        }
    };
    constructor(appUrl,url){
        //console.log('Filled_form.constructor()'); 
        this.setUrl(appUrl,url);
        this.Parse=new Parse();
        this.Html=new Html();
        this.ErrorStack = new ErrorStack();
        this.Xhr=new Xhr2();
        this.Xhr2=new Xhr2();
        this.Filled_form_table = new Filled_form_table(this);
        this.Filled_form_show=new Filled_form_show_filled(this);
        this.Utilities = new Utilities();
        this.setLoadInfo();
        this.Form_creator = new Form_creator(appUrl,url,this.Filled_form_table);
    }
    getXhrParm(type,url,method){
        return {
                t:type,
                u:this.router+url,
                c:true,
                d:null,
                o:this,
                m:method
            };
    }
    setUpParameters(){
        console.log('Filled_form.setUpParameters()'); 
        /* TO DO -> EXTEND FOR ALL GLOSSARY */
        this.Xhr.setOnError({o:this.Filled_form_table, m:'setError'});
        
        this.Xhr.run(this.getXhrParm('GET','loadFilledFormDefault','setUpDefaults'));
    }
    setUpDefaults(response){
        console.log('Filled_form.setUpDefaults()');
        //console.log(response);
        var json = this.setTableResponse(response);
        //console.log(json);
        try {
            if(!json.data.hasOwnProperty('permissions')){
                throw 'No permissions key!';
            }
            if(!json.data.hasOwnProperty('form')){
                throw 'No form key!';
            }
        }
        catch (error) {
            console.log(error);
            this.Filled_form_table.setError('Application error occurred! Contact with Administrator!');
            return false;
        }
        /*
         * SET PERMISSIONS
         */
        this.permissions=json.data.permissions;
        //console.log(this.permissions);
        this.Filled_form_table.updateBody(json.data.form);
    }
    setUrl(appUrl,url){
        //console.log('ProjectItems::setUrl()'); 
        this.router=url;
        this.appUrl=appUrl; 
    }
    getJsonResponse(errLink,response){
        //console.log('ProjectItems::getJsonResponse()');
        //console.log(response);
        try {
            return JSON.parse(response);    
        }
        catch (error) {
            ProjectItems.setError(errLink,error);
            return false;
        } 
        return false;
    }
    checkResponseError(ele,jsonResponse){
        //console.log('ProjectItems::checkResponseError()');
        /*
         * ele -> link to html element
         * jsonResponse -> response data from backend
         * errorStatus -> overall error status
         */
        if(parseInt(jsonResponse['status'],10)===1){
            ProjectItems.setError(ele,jsonResponse['info']);
            return true;
        }
        else{
            ProjectItems.unsetError(ele); 
            return false;
        }
    }
    unsetError(ele){
        ProjectItems.Html.hideAndClearField(ele);
    }
    filterOutReloadData(fd,m){
        console.log('ProjectItems::filterOutReloadData()');
        var xhrRun={
            t:'POST',
            u:this.router+this.default.url.active,
            c:true,
            d:fd,
            o:this.default.object,
            m:m
        };
        this.Xhr.run(xhrRun);
    }
    reloadData(fd,u){
        console.log('ProjectItems::reloadData()');
        console.log(this.default);
        console.log(m);
        console.log(u);
        /* CLEAR TABLE */
        this.Filled_form_table.clearTable();   
        /*
         * property:
         * t = type GET/POST 
         * u = url
         * c = capture
         * d = data
         * o = object
         * m = method
         */
        var xhrRun={
            t:'POST',
            u:this.router+u,
            c:true,
            d:fd,
            o:this,
            m:''
        };
        this.Xhr.run(xhrRun);
    }
    setProperties(){
        //console.log('ProjectItems::setProperties()');
        try{
            ProjectItems.Xhr.load=document.getElementById('appLoadNotify');
        }
        catch (error){
            console.log(error);
            alert('ProjectItems::setProperties() Error occured!');
        }
    }
    setFilterValue(ele){
        //console.log('ProjectItems::setFilterValue()');
        this.filter.search=ele;
    }
    showFilterOut(ele){
        console.log('ProjectItems::filterOut()');
        console.log(ele.parentNode.parentNode.childNodes[0].value);
        this.filter.search=ele.parentNode.parentNode.childNodes[0];
        this.designateUrl();
        this.showFiltered();
    }
    showHidden(ele){
        console.log('Filled_form.hidden()');
        this.changeValue(ele);
        this.filter.hidden=ele;
        this.designateUrl();
        this.showFiltered();
    }
    showDeleted(ele){
        console.log('Filled_form.deleted()');
        console.log(ele);
        this.changeValue(ele);
        this.filter.deleted=ele;
        this.designateUrl();
        console.log(this.filter.deleted);
        this.showFiltered();
        
    }
    showAll(ele){
        console.log('Filled_form.showAll()');
        console.log(ele);
        this.changeValue(ele);
        this.filter.all=ele;
        this.designateUrl();
        /* TO DO */
        //this.default.object.show();
    }
    showFiltered(){
        console.log('Filled_form.showFiltered()');
         /* TO DO */
         //this.reloadData();
    }
    changeValue(ele){
        
        console.log(ele,ele.value,typeof(ele.value));
        if(ele.value==='0'){
            ele.value='1';
        }
        else{
            ele.value='0';
        }
    }
    designateUrl(){
        console.log(this.filter.hidden.value);
        console.log(this.filter.deleted.value);
        console.log(this.filter.all.value);
        switch (this.filter.hidden.value+this.filter.deleted.value+this.filter.all.value) {
            case '100':
              console.log('Only hidden');
              this.default.url.active=this.default.url.hidden;
              break;
            case '110':
                console.log('hidden and deleted');
                this.default.url.active=this.default.url.hiddenAndDeleted;
                break;
            case '010':
                console.log('only deleted');
                this.default.url.active=this.default.url.deleted;
                break;
            case '001':
            case '011':
            case '101':
            case '111':
              console.log('all');
              this.default.url.active=this.default.url.all;
              break;
            case '000':
            default:
              console.log(`default 000`);
              this.default.url.active=this.default.url.primary;
          }
    }
    setLoadInfo(){
        //console.log('ProjectItems::setLoadInfo()');
        var start = function(){
                    var g = document.getElementById('appLoadNotify');
                    g.classList.remove("d-none");
                    g.classList.add("d-block");
            };
        var end = function(){
                    var g = document.getElementById('appLoadNotify');
                    g.classList.remove("d-block");
                    g.classList.add("d-none");
            };
        this.Xhr.setOnLoadStart(start);
        this.Xhr.setOnLoadEnd(end);
    }
    parseResponse(response){
        console.log('Filled_form.parseResponse()');
        //console.log(response);
        try {
            var json=this.Parse.getJson(response);
            //Error.clear();
            //var data = JSON.parse(response);  
        }
        catch (e){
            console.log('Forms.parseResponse()');
            console.log(response);
            console.log('ERROR:');
            console.log(e);
            this.ErrorStack.add('main','Application error occurred! Contact with Administrator!');
            throw 'Application error occurred! Contact with Administrator!';
            return false;
        }
        if(json.error!==''){
            console.log(json.error);
            this.ErrorStack.add('main',json.error);
            throw json.error;
        }
        return json.value;
    }
    setTableResponse(response){
        console.log('Filled_form.setTableResponse()');
        //console.log(response);
        try {
            return this.parseResponse(response);
        }
        catch (error) {
            console.log(error);
            /* SHOW ERROR MODAL */ 
            this.Filled_form_table.setError(error);
            return {};
        }
        return {};
    }
    count(o){
    /* 
     * 0 - object to count
     */
        var i=0;
        for (const prop in o){
            i++;
        }
        return i;
    }
    successfully(){
       // console.log('ProjectItems.successfully()');
    }
    setClearDefault(o,m,t){
        //console.log('ProjectItems.setClearDefault()');
        //console.log(o.url);   
        /*
        o - object
        m - method
        t - title
        */     
        this.filter.search.value='';
        this.filter.hidden.checked=false;
        this.filter.deleted.checked=false;
        this.filter.all.checked=false;
        this.filter.hidden.value='0';
        this.filter.deleted.value='0';
        this.filter.all.value='0';
        this.setDefaultTitle(t);
        this.setDefault(o,m,o.url);
    }
    setDefaultActionUrl(o,m,t){
        //console.log('ProjectItems::setDefaultActionUrl()',o,m,t);
        this.setDefaultAction(o,m);
        this.setDefaultActiveUrl(o.url);
        this.setDefaultTitle(t);
    }
    setDefaultAction(o,m){
        this.default.object=o;
        this.default.method=m;
    }
    setDefault(o,m,u){
        this.setDefaultUrl(u);
        this.setDefaultAction(o,m);
    }
    setDefaultTitle(t){
        //console.log('ProjectItems::setDefaultTitle()');
        for(const prop in t){
            //console.log(prop,t[prop]);
            this.default.title[prop]=t[prop];
        }
    }
    setDefaultActiveUrl(u){
        //console.log('ProjectItems.setDefaultActiveUrl()');  
        //console.log(this.default.url);     
        //console.log(u);    
        /* FIRST RUN Create from button list, set proper url */
        if(this.default.url.primary!==u.primary){
            /* SET VALUE, NOT OBJECT, IF OBJECT IT SET REFERENCES */
            this.setDefaultUrl(u);
        };
    }
    setDefaultUrl(u){
        this.default.url.active=u.primary;
        this.default.url.primary=u.primary;
        this.default.url.hidden=u.hidden;
        this.default.url.deleted=u.deleted;
        this.default.url.hiddenAndDeleted=u.hiddenAndDeleted;
        this.default.url.all=u.all;
    }
    getFilterData(id){
        var fd = new FormData();
            fd.append('f',this.filter.search.value);
            fd.append('b',id);
        return fd;
    }
    showFormModal(response){
        console.log('Filled_form.showFormModal()');  
    }
    
    showFilledModal(response){
        console.log('Filled_form.showFilledModal()');  
        //console.log(response);        
        //console.log(this.setTableResponse(response));
        //
        try {
            var data=this.parseResponse(response);
            this.Filled_form_show.show(data);
        }
        catch (error) {
            //console.log(error);
            /* SHOW ERROR MODAL */ 
            this.Filled_form_table.setError(error);
           // return false
        }
        //return {};
    }
    showRemoveModal(response){
        console.log('Filled_form.showRemoveModal()');  
    }
    showHideModal(response){
        console.log('Filled_form.showHideModal()');  
    }
    setCreateFormButton(ele){
        console.log('Filled_form.setCreateFormButton()');  
        //console.log(ele);
        var self = this;
        ele.onclick = function(){
            self.Form_creator.creator();  
        };
    }
}
/*
 * 
 * @type Forms
 */
try{
    var FilledForm = new Filled_form(window.appUrl,window.appUrl+'/router.php?task=');
}
catch (e){
    console.log(e);
    error=true;
    alert('Something went wrong! Contact with administrator!');    
}
if(error===false){
    window.addEventListener('load', function(){
    //console.log('page is fully loaded');
    try{
        FilledForm.Filled_form_table.setLink();
        /* SETUP PARAMETERS => Glossary */
        FilledForm.setUpParameters();
        FilledForm.setCreateFormButton(document.getElementById("createForm"));
    }
    catch (error){
        console.log(error);
        alert('ProjectItems::load() Error occured!');
    }
    },false); 
}