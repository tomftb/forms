/*
 * CLASS Modal -> js/Main/Modal.js
 * CLASS TableNew -> js/Main/TableNew.js
 * CLASS Xhr -> js/Main/Xhr.js
 */
var error = false;
class Form_stage{
    Modal = new Object();
    Html = new Object();
    router='';
    appUrl='';
    /* FOR TABLE */
    Xhr = new Object();
    /* FOR MODAL */
    Xhr2 = new Object();
    Stage = new Object();
    Table = new Object();
    ErrorStack = new Object();
    Department = new Object();
    Footer=new Object();
    Heading=new Object();
    loadModal;
    default={
            object:{},
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

    Glossary=new Object();
    constructor(appUrl,url){
        //console.log('Form_part.constructor()'); 
        this.setUrl(appUrl,url);
        this.Parse=new Parse();
        this.Html=new Html();
        this.Modal=new Modal();
        this.ErrorStack = new ErrorStack();
        this.Xhr=new Xhr2();
        this.Xhr2=new Xhr2();
        this.Department=new Department();
        this.Table = new Form_part_table();
        //Items.setLoadInfo();
        this.Glossary={
            text:new Glossary(),
            list:new Glossary(),
            image:new Glossary()
        };
        this.Utilities = new Utilities();
        this.setLoadInfo();
        //this.setLoadModalInfo(this.Xhr2); 
        this.Modal.setLoad(this.Xhr2,appUrl);
        this.Xhr2.setOnError(this.modalXhrError()); 
        this.Stage=new ProjectStage(this);
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
    loadDefaultList(){
        console.log('Form_part.loadDefaultList()'); 
        this.Table.setLink(); 
        /* SET HEAD */
        this.Table.setTableHead();
        this.Xhr.run(this.getXhrParm('GET','getFormPartDefaults','showList'));
    }
    showList(response){
        console.log('Form_part.showList()');
        console.log(response);
        this.Table.setResponse(response);
        //this.Table.clearTable();
        
        this.Table.setBody();

    }
    setUrl(appUrl,url){
        //console.log('Form_part.setUrl()'); 
        this.router=url;
        this.appUrl=appUrl; 
    }
    getJsonResponse(errLink,response){
        //console.log('Form_part.getJsonResponse()');
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
        //console.log('Form_part.checkResponseError()');
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

    setChangeStateFields(ele,sloData){ 
        //console.log('Form_part.setChangeStateFields()');
        var p=document.createElement('P');
            p.setAttribute('class','text-left');
            p.innerText='Podaj Powód:';
        var extraSelect=document.createElement('INPUT');
            extraSelect.setAttribute('type','text');
            extraSelect.setAttribute('id','extra');
            extraSelect.setAttribute('name','extra');
            extraSelect.setAttribute('class','form-control mb-1');
            extraSelect.setAttribute('PLACEHOLDER','Wprowadź powód');
            extraSelect.style.display = "none";
            /*
             * IF EMPTY sloData
             */
            if(sloData.length<1){
                extraSelect.style.display = "block";
            }
            sloData.push({
                            'ID' : "0",
                            'Nazwa' : 'Inny:'
                        });
        var select=this.Html.createSelectFromObject(sloData,'Nazwa','reason','form-control mb-1');
        var self=this;
        /*
         * CLOSURE
         */
            select.onchange = function() { 
                self.checkReason(this,extraSelect); 
            };
        ele.appendChild(p); 
        ele.appendChild(select); 
        ele.appendChild(extraSelect); 
        return '';
    }
    checkReason(t,extraSelect){
        //console.log('Form_part.checkReason()');
        var splitValue=t.value.split("|");
        if(splitValue[0]==='0'){
            extraSelect.style.display = "block";
        }
        else{
            extraSelect.style.display = "none";
        };
    }
    setDefaultModal(){
        //console.log('Form_part.setDefaultModal()');
        try{
            ProjectItems.Modal.setLink();
            ProjectItems.Modal.clearData();
            ProjectItems.Modal.loadNotify='<img src="'+ProjectItems.appUrl+'/img/loading_60_60.gif" alt="load_gif">';
            ProjectItems.Modal.showLoad();
        }
        catch (error){
            console.log(error);
            alert('Form_part.setDefaultModal() Error occured!');
        }
    }
    prepareModal(title,titleClass){
        //console.log('Form_part.prepareModal()');
        //this.Modal.setLink();
        var self= this;
        var f5 = function (e){
            //console.log('f5');
            e = e || window.event;
           if( self.wasPressed ) return; 

            if (e.keyCode === 116) {
                 //alert("f5 pressed");
                
            }else {
                //alert("Window closed");
            }
        };
        window.onbeforeunload = function() {
            return "Opuścić okno bez zapisu?";
        };
        document.onkeydown = function(){
            //console.log('onkeydown');
            f5();
        };
        document.onkeypress = function(){
            //console.log('onkeypress');
            f5();
        };
        document.onkeyup = function(){
            //console.log('onkeyup');
            f5();
        };

        this.Modal.setHead(title,titleClass);
        //$(ProjectItems.Modal.link['main']).modal('show');
        $(this.Modal.link['main']).modal({
            show:true,
            backdrop: 'static',
            keyboard: false  // to prevent closing with Esc button
        });
        // REMOVE data-dismiss="modal" 
        //console.log(this.Modal.link['close'].parentNode);
        this.Modal.link['close'].parentNode.removeAttribute('data-dismiss');
        
    }
    setCloseModal(run){
        console.log('Form_part.setCloseModal()');
        /* CLOSURE */
        var self = this;
        var checkError = function (){
             if(self.ErrorStack.check()){
                    if (confirm('Opuścić okno bez zapisu?') === true) {
                        self.closeModal();
                        return false;
                    }
                    else{ 
                        return false;
                    }
               }
               //console.log('run');
               //console.log(run);
               if (confirm('Wyjść?') === true) {
                    run();
                }
            else{}
        };
        this.Modal.link['close'].onclick = function (){
            /* TO DO */
            checkError();
        };
         /* SET CLOSE VIA MOUSE */
        this.Modal.link['main'].onclick = function (e){
            
            if(e.target.id === 'AdaptedModal'){
                console.log('outside');
                checkError();
            }
            else {}
        };
    }
    filterOutReloadData(fd,m){
        console.log('Form_part.filterOutReloadData()');
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
    reloadData(o,m,u){
        console.log('Form_part.reloadData()');
        console.log(this.default);
        console.log(o);
        console.log(m);
        console.log(u);
        /* CLEAR TABLE */
        this.Table.clearTable();   
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
            t:'GET',
            u:this.router+u,
            c:true,
            d:null,
            o:o,
            m:m
        };
        this.Xhr.run(xhrRun);
    }
    setProperties(){
        //console.log('Form_part.setProperties()');
        try{
            ProjectItems.Xhr.load=document.getElementById('appLoadNotify');
        }
        catch (error){
            console.log(error);
            alert('Form_part.setProperties() Error occured!');
        }
    }
    getCancelButton(fd,m){
        console.log('Form_part.getCancelButton()',fd,m);
        var cancel=this.Html.cancelButton('Anuluj');
        var self = this;
            cancel.onclick=function(){
                if (confirm('Anulować?') === true) {
                    self.Modal.closeModal();
                    window.onbeforeunload = null;
                    self.filterOutReloadData(fd,m);
                }
                else{ 
                }
            };
        return cancel;
    }
    setFilterValue(ele){
        //console.log('Form_part.setFilterValue()');
        this.filter.search=ele;
    }
    filterOut(ele){
        console.log('Form_part.filterOut()');
        console.log(ele.parentNode.parentNode.childNodes[0].value);
        this.filter.search=ele.parentNode.parentNode.childNodes[0];
        this.designateUrl();
        this.default.object.show();
    }
    hidden(ele){
        console.log('Form_part.hidden()');
        this.changeValue(ele);
        console.log(this.default);
        this.filter.hidden=ele;
        this.designateUrl();
        this.default.object.show();
    }
    deleted(ele){
        console.log('Form_part.deleted()');
        console.log(ele);
        this.changeValue(ele);
        this.filter.deleted=ele;
        this.designateUrl();
        this.default.object.show();
    }
    all(ele){
        console.log('Form_part.all()');
        console.log(ele);
        this.changeValue(ele);
        this.filter.all=ele;
        this.designateUrl();
        this.default.object.show();
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
    changeValue(ele){
        console.log('Form_part.changeValue()');
        console.log(ele,ele.value,typeof(ele.value));
        if(ele.value==='0'){
            ele.value='1';
        }
        else{
            ele.value='0';
        }
    }
    setLoadInfo(){
        //console.log('Form_part.setLoadInfo()');
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
        console.log('Form_part.parseResponse()');
        //console.log(response);
        try {
            var json=this.Parse.getJson(response);
            //Error.clear();
            //var data = JSON.parse(response);  
        }
        catch (e){
            console.log('ProjectItems.parseResponse()');
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
    setChangeDataState(i,t,f,g,btnLabel,titleClass,fd,m){
        //console.log('Form_part.setChangeDataState()');
        /*
            i - id
            t - tile
            f - function to run
            g - glossary
            o - object
            m - method
            u - url (task)
            fd - {
                f - filtr search value
                p - part (Stage)
                b - block id
            }
        */
        
        var form=this.Html.getForm();
        var h=document.createElement('H5');
            h.setAttribute('class','text-'+titleClass+' mb-3 text-center font-weight-bold');
            h.innerHTML=t;
        
            form.appendChild(this.Html.getInput('id',i,'hidden'));
        this.setChangeStateFields(form,g);
        this.Modal.link['form']=form; 
        this.Modal.link['adapted'].appendChild(h);
        this.Modal.link['adapted'].appendChild(form);
        var self=this;
        var confirmButton=this.Html.confirmButton(btnLabel,'btn btn-'+titleClass,f);   
            /* CLOSURE */
            confirmButton.onclick = function () {  
                
                let fdLocal = new FormData(form);
                for(let prop of fd.entries()){
                    //console.log(prop[0],prop[1]);
                    fdLocal.append(prop[0],prop[1]);
                }
                fdLocal.append('filter',self.default.url.active);
                let xhrRun={
                    t:'POST',
                    u:self.router+f,
                    c:true,
                    d:fdLocal,
                    o:self.default.object,
                    m:m
                };
                if(confirm('Potwierdź wykonanie akcji')){   
                    //console.log(xhrRun);
                    //Items.Xhr2.setOnError(xhrError);
                    self.Xhr2.run(xhrRun);
                };
            };
        this.Modal.link['button'].appendChild(this.getCancelButton(fd,m));
        this.Modal.link['button'].appendChild(confirmButton);
    }
    closeModal(){
        //console.log('Form_part.closeModal()');
        window.onbeforeunload = null;
        $(this.Modal.link['main']).modal('hide');
    }

    setModalResponse(response){
        console.log('Form_part.setModalResponse()');
        //console.log(response);
        var data={
            data:{
                value:{
                    data:{}
                }
            },
            info:'',
            status:1
        };
        try {
            var data=this.parseResponse(response);
            /* CLOSE MODAL IF OK */
            this.closeModal(); 
            return data;
        }
        catch (error) {
            console.log(error);
            /* SHOW ERROR MODAL */ 
           this.Modal.setError(error);
           //this.Html.showField(this.Modal.link['error'],error);
           return data;
        }
    }
    setFieldResponse(response){
        console.log('Form_part.setFieldResponse()');
        try {
            return this.parseResponse(response);
            /* TO DO -> set value to field if ok */
        }
        catch (error) {
            console.log(error);
            /* SHOW ERROR MODAL */ 
            this.Modal.setError(error);
            //this.Html.showField(this.Modal.link['error'],error);
            return false;
        }
        return false;
    }
    uploadFile(response){
        
        var data = this.setFieldResponse(response);
        if(data===false){
            return false;
        }
            console.log(data);
            console.log(data.data);
        var win = window.open('router.php?task='+data['data']['function']+'&file='+data['data']['value'], '_blank');
            win.focus();
    }
    setUpModalData(response){
        //console.log('Form_part.setUpModalData()');
        var data={};
        try {
            data=this.parseResponse(response);
        }
        catch (error) {
            console.log(error);
            this.Html.showField(this.Modal.link['error'],error);
        } 
        return data;
    }
    modalXhrError(){
        //console.log('Form_part.modalXhrError()');
         var xhrError={
            o:this.Modal,
            m:'setError'
        };
        return xhrError;
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
        //console.log('Form_part.setDefaultActionUrl()',o,m,t);
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
        //console.log('Form_part.setDefaultTitle()');
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
    setTitle(){
        var title=document.getElementById('headTitle');
        //console.log(title.parentNode);
        title.innerHTML=this.default.title.label;
        /* text-info */
        title.parentNode.classList.remove('text-info','text-warning','text-purple','text-brown');
        title.parentNode.classList.add(this.default.title['text-color']);
    }
    getFilterData(id){
        var fd = new FormData();
            fd.append('f',this.filter.search.value);
            fd.append('b',id);
        return fd;
    }
}
try{
   var FormPart = new Form_stage(window.appUrl,window.appUrl+'/router.php?task=');
   window.addEventListener('load', function(){
        console.log('page is fully loaded');
        try{
            FormPart.Modal.setLink();
            FormPart.Table.setLink();
            /* SETUP PARAMETERS => Glossary */
            FormPart.loadDefaultList();
        }
        catch (error){
            console.log(error);
            alert('Form_part.load() Error occured!');
        }
    }
    ,false);
}
catch (e){
    console.log(e);
    error=true;
    alert('Something went wrong! Contact with administrator!');    
}