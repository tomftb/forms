class Form_stage_create_action{  
    Html = new Object();
    ErrorStack = new Object();
    ele = {
        'button':new Object()
        ,'error':new Object()
    };
    input = new Object();
    value = "";
    value_length = 0;
    title = new Object();
    help = new Object();
    error = new Object();

    max = 1024;
    min = 3;
    uniqid = '';
    Modal = new Object();
    
    constructor(Parent){
        try{
            console.log('Form_stage_create_action.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            this.setUniqid();  
        }
        catch(e){
            console.log('Form_stage_create_action.construct() catch()',e);
        }
    }
    setValue(value){
        this.value=value;
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_";
        console.log(this.uniqid);
    }
    setSaveButton(){
        var self = this;
        var button = this.Html.getButton('Zapisz',['btn','btn-success']);
            button.onclick=function(){
                console.log('Form_stage_create_action.setSaveButton() onclick()');
                self.Parent.save(self.Parent);
            };
        this.ele.button.append(button);
    }
    setCloseButton(){
        var self=this;
        var button = this.Html.getButton('Wyjdź',['btn','btn-dark']);
            button.onclick=function(){
               if(self.ErrorStack.check()){
                    if (confirm('Opuścić okno bez zapisu?') === true) {
                        window.onbeforeunload = null;
                        $(self.Parent.link['main']).modal('hide');
                        self.Parent.Form_stage_list.reload(self.Parent.Form_stage_list);
                        return false;
                    }
                    else{ 
                        return false;
                    }
               }
               if (confirm('Wyjść?') === true) {
                    window.onbeforeunload = null;
                    $(self.Parent.link['main']).modal('hide');
                    self.Parent.Form_stage_list.reload(self.Parent.Form_stage_list);
               }
               else{ 
               }
            };
        this.ele.button.append(button);
    }
    setPreviewButton(){
        var self = this;
        var button = this.Html.getButton('Podgląd',['btn','btn-warning']);
            button.setAttribute('value','showPreview');
            button.onclick=function(){
                try{
                    //console.log('Form_stage_create_action.setPreviewButton() onclick()');
                    if(this.value==='showPreview'){
                        /*
                         * HIDE MAIN
                         */
                        self.Parent.link['dynamic'].classList.add('d-none');
                        /*
                         * SHOW PREVIEW
                         */
                        this.value='showDynamic';
                        self.Parent.link['preview'].classList.remove('d-none');
                        self.Html.removeChilds(this);
                        this.append(document.createTextNode('Edytuj'));
                        /*
                         * RUN PARENT PREVIEW
                         */
                        self.Parent.preview(self.Parent);
                    }
                    else{
                        /*
                         * SHOW MAIN
                         */
                         self.Parent.link['dynamic'].classList.remove('d-none');
                        /*
                         * HIDE PREVIEW
                         */
                        self.Parent.link['preview'].classList.add('d-none');
                        this.value='showPreview';
                        self.Html.removeChilds(this);
                        this.append(document.createTextNode('Podgląd'));
                    }
                }
                catch(e){
                    console.log('Form_stage_create_action.setPreviewButton() onclick() catch',e);
                    self.setError(self,'onclick_preview','Application error occurred! Contact with Administrator!');
                    self.checkErrors(self);
                }
            };
        this.ele.button.append(button);
    }
    set(ele){
        this.ele = ele;
        this.setCloseButton();
        this.setPreviewButton();
        this.setSaveButton();       
    }
    setError(self,code,msg){
        /*
         * ADD to ErrorStack
         */
        self.ErrorStack.add(self.uniqid+code,msg);
    }
    unsetError(self,code){
        /*
         * CLEAR ErrorStack
         */
        self.ErrorStack.remove(self.uniqid+code);
    }
    checkErrors(self){
        console.log('Form_stage_create_action.checkErrors()');
        console.log(self);
        if(self.ErrorStack.check()){
            console.log('Form_stage_create_action.checkErrors() errors exists');
            /*
             * PARENT EXTENDS MODAL -> modal.setError()
             */
            self.Parent.setError(self.ErrorStack.getHtmlWithMask(self.uniqid));
        }
        else{
            console.log('Form_stage_create_action.checkErrors() no errors');
            /*
             * PARENT EXTENDS MODAL -> modal.unsetError()
             */
            self.Parent.unsetError();
        }
    }

}