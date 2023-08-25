/*
 * Author: Tomasz Borczynski
 */
class Filled_form_show_filled{
    Modal=new Object();
    Html=new Object();
    Xhr=new Object();
    ErrorStack = new Object();
    Parent=new Object();
    //permissions=new Object();
    router='';
    appUrl='';
    data=new Object();
    button={
        'show':{
            'set':'getButton'// //getDisabledButton
            ,'title':'EXCEL'
            ,'class':'btn-success'
            ,'action':'uploadFile'//Check
            ,'url':'getFilledFormExcel&id='
            ,'permission':'EXCEL_FILLED_FORM'
            
        }
    }
    constructor(Parent){
        console.log('Filled_form_show_filled.constructor()');
        this.Parent=Parent;
        this.Modal=new Modal();
       
        this.Html=Parent.Html;
        this.Xhr=Parent.Xhr2;
        this.router=Parent.router;
        this.appUrl=Parent.appUrl;
        //this.permissions=Parent.permissions;
        this.ErrorStack=Parent.ErrorStack;
        this.Xhr.setOnError(this.modalXhrError()); 
    }
    show(response){
        console.log('Filled_form_show_filled.show()');
        /*
         * SETUP PERMISSIONS
         */
        this.setButtonsPermissions(this.Parent.permissions);
        try {
            this.data=response;
            this.Modal.setLink();
            this.Modal.setLoad(this.Xhr,this.appUrl);
            this.Modal.prepareModal();
            this.Modal.setLink();
            this.Modal.clearData();
            this.Modal.loadNotify='<img src="'+this.appUrl+'/img/loading_60_60.gif" alt="load_gif">';
            this.setUpModal();
        }
        catch (error) {
            console.log(error);
            /* SHOW ERROR MODAL */ 
            this.Modal.setError(error);
            //this.Html.showField(this.Modal.link['error'],error);
            return false;
        }
    }
    setUpModal(){
        console.log('Filled_form_show_filled.setUpModal()');
        console.log(this.data);
        try{
            /* CLEAR DATA MODAL */
            this.Modal.clearData();
            /* SET CLOSE BUTTON */
            //console.log(this.StageData.Stage); 
            this.Modal.setCloseModal();
            /* SET HEAD */
            this.Modal.setHead('Zestawienie','bg-purple');
            this.setTable();
            /* ASSING ACTION BUTTONS */
            this.createManageButton(this.data.data.form.i);
            /* SET INFO */
            this.Modal.setInfo('ID: '+this.data.data.form.i+', Create user: '+this.data.data.form.cul+' ('+this.data.data.form.cufn+'), Create date: '+this.data.data.form.cd+', Version: '+this.data.data.form.md);

        }
        catch(err){
            console.log('ProjectStageCreate::setUpModal()\r\nERROR:');
            throw err;
        }
        /* IN ANOTHER BLOCK TRY CATCH TO PREVENT OPEN MODAL IF ERROR EXISTS TO HIDE ERROR SHOWED IN TABLE  */
        
    }
    createManageButton(id){
        console.log('Filled_form_show_filled.createManageButton()');
        for (const prop in this.button){
                this.Modal.link['button'].appendChild(this[this.button[prop].set](this.button[prop],id));
        }
        /*
         * CANCEL BUTTON
         */
        this.Modal.link['button'].appendChild(this.getCancelButton());
    }
    getCancelButton(){
        var cancel=this.Html.cancelButton('Wyjdź');
        var self = this;
            cancel.onclick=function(){
                console.log('Filled_form_show_filled.getCancelButton().onclick()');
                if(self.ErrorStack.check()){
                    console.log(self.ErrorStack);
                    if (confirm('Opuścić okno bez zapisu?') === true) {
                        self.Modal.closeModal();
                        
                        return false;
                    }
                    else{ 
                        return false;
                    }
               }
               if (confirm('Wyjść?') === true) {
                   self.Modal.closeModal();
                   
               }
               else{ 
               }
            };
        return cancel;
    }
    Check(response){
        console.log('Filled_form_show_filled.Check()');
        console.log(response);
        try {
            this.Parent.parseResponse(response);
            /* CLOSE MODAL IF OK */
            this.closeModal(); 
        }
        catch (error) {
            console.log(error);
            /* SHOW ERROR MODAL */ 
           this.Modal.setError(error);
        }
    }
    /* 
     * SEND INPUT DATA TO SEND 
     */
    sendInputData(self){
        //console.log('ProjectStageCreate.sendInputData()');
        if(self.ErrorStack.check()){ return false;}
        var fd = new FormData();
            fd.append('stage',JSON.stringify(self.StageData.Stage));
        this.Xhr.run({
                t:'POST',
                u:this.router+'confirmProjectStageText',
                c:true,
                d:fd,
                o:self,
                m:'Save'
        });      
    }
    setTable(){
        console.log('Filled_form_show_filled.setTable()'); 
        console.log(this.data); 
        //var row=document.createElement('div');
        var div=document.createElement('div');
            div.classList.add('table-responsive');
        var table=document.createElement('table');
            table.classList.add('table','table-striped','table-hover','responsive');
        this.setTableHead(table);  
        this.setTableBody(table);  
        div.appendChild(table);
        
        //this.Html.removeChilds(this.Modal.link['body']);
        this.Modal.link['adapted'].append(div);
        //this.Modal.link['body'].append(div); 
        console.log(this.Modal.link);
    }
    setTableHead(table){
        var thead=document.createElement('thead');
            //thead.classList.add('thead-dark');
        var tr=document.createElement('tr');
        for(const prop in this.data.data.col){
            console.log(this.data.data.col[prop]);
            var th=document.createElement('th');
                th.setAttribute('scope','col');
            var t=document.createTextNode(this.data.data.col[prop].v);
                th.appendChild(t);
                tr.appendChild(th);
                thead.appendChild(th); 
        }
        
        table.appendChild(thead);
    }
    setTableBody(table){
        console.log('Filled_form_show_filled.setTableBody()');
        var tbody=document.createElement('tbody');
        for(const prop in this.data.data.list){
            console.log(this.data.data.list[prop]);
            //console.log(prop);
            var tr=document.createElement('tr');
            
            var setTh=function(value){
                var th=document.createElement('th');
                    th.setAttribute('scope','row');
                var t=document.createTextNode(value);   
                    th.appendChild(t);
                return th;
            };
            var setTd=function(value){
                var td=document.createElement('td');
                var t=document.createTextNode(value);   
                    td.appendChild(t);
                return td;
            };
            var set=setTh;
            for(const propCol in this.data.data.list[prop]){
                //var col = set(this.data.data.list[prop][propCol].v);
                var col = set(this.data.data.list[prop][propCol]);
                tr.appendChild(col);
                set=setTd;
            }
            tbody.appendChild(tr); 
        }
        
        table.appendChild(tbody);
    }
    setButtonsPermissions(permissions){
        console.log('Filled_form_show_filled.setButtonsPermissions()');
        for (const prop in this.button){
            //console.log(this.button[prop]);
            if(!this.checkPermission(permissions,this.button[prop].permission)){
                this.button[prop].set='getDisabledButton';
            }
        }
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
    getDisabledButton(prop,id){
        var btnEle  = this.getButtonEle(prop.title,prop.class);
            btnEle.classList.add('disabled');
            btnEle.setAttribute('disabled','');
        return btnEle;
    }
    getButtonEle(title,c){
        var btn = document.createElement('BUTTON'); 
            btn.innerHTML=title;
            btn.setAttribute('class','btn '+c);
        return btn;
    }
    getButton(prop,id){
        console.log('Filled_form_show_filled.getButton()');
        var btnEle  = this.getButtonEle(prop.title,prop.class);
        var self = this;
        var AjaxRun = this.getXhrRunProperty(prop,id);
            AjaxRun.m=prop.action;
            btnEle.onclick = function (){
                //$(self.Parent.Modal.link['main']).modal('show');
                self.Modal.unsetError();
                self.Xhr.setOnError({o:self, m:'setError'}); //this.Modal.setError(error);
                self.Xhr.run(AjaxRun);
            };
        return btnEle;
    }
    getXhrRunProperty(prop,id){
        var run={
            t:"GET"
            ,u:this.router+prop.url+id
            ,c:true
            ,d:null
            ,o:this
            ,m:prop.action
        };
        return run;
    }
    setError(error){
        //this.Parent.parseResponse(error);
        this.Modal.setError(error);
    }
    unsetError(){
        this.Modal.unsetError();
    }
    uploadFile(response){
        console.log('Filled_form_show_filled.uploadFile()');
        var data = this.setFieldResponse(response);
        if(data===false){
            return false;
        }
            console.log(data);
            console.log(data.data);
        var win = window.open('router.php?task='+data['data']['function']+'&file='+data['data']['value'], '_blank');
            win.focus();
    }
    setFieldResponse(response){
        console.log('ProjectItems::setFieldResponse()');
        try {
            return this.Parent.parseResponse(response);
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
    modalXhrError(){
        //console.log('ProjectItems::modalXhrError()');
         var xhrError={
            o:this.Modal,
            m:'setError'
        };
        return xhrError;
    }
}