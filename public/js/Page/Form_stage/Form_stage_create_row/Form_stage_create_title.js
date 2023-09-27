class Form_stage_create_title{    
    Html = new Object();

    Prototype = new Object();
    

    select = new Object();
    value = "";

    title = new Object();
    help = new Object();
    error = new Object();

    uniqid = '';
    type='title';
    runError = 'setError';
    
    input = new Object();
    value = "";
    value_length = 0;
    title = new Object();
    help = new Object();
    error = new Object();

    max = 1024;
    min = 3;
   
    constructor(Parent,ele){
        try{
            console.log('Form_stage_create_title.construct()');
            this.Parent = Parent;
            /*
             * Prototype
             */
            this.Prototype = new Form_stage_prototype(Parent,ele);
            this.Html=new Html();
            this.Prototype.unsetBorder();
            this.Prototype.setUniqid(this.type);
            this.Prototype.setFields();
            this.setInput();
        }
        catch(e){
            console.log('Form_stage_create_title.construct() catch()',e);
        }
    }
    getValue(){
        return this.input.value;
    }
    getInputField(){
        var self=this;
        this.input = this.Html.getInput('title','','text');
        this.input.classList.add('form-control');
        this.input.setAttribute('placeholder','Enter title');
        this.input.setAttribute('aria-describedby',"titleHelp" );
        this.input.setAttribute('maxlength',this.max);
        this.input.value=this.value;
        this.input.oninput = function(){
            console.log('Form_stage_create_title.getInput() oninput()');
            self.checkLength(self,this.value);
            self.checkErrors(self);
        };
        this.input.onblur = function(){
            console.log('Form_stage_create_title.getInput() onblur()');
            self.checkLength(self,this.value);
            self.checkErrors(self);
        };
        return  this.input;
    }
    setInput(){
        console.log('Form_stage_create_title.setInput()');
        var row=this.Html.getRow();
        var col_1=this.Html.getCol(1);
        var col_2=this.Html.getCol(11);
            col_1.appendChild(this.getTitleField());
            col_2.appendChild(this.getInputField());
            row.append(col_1,col_2);
        this.Prototype.ele.input.append(row);
        this.setHelpField();
    }
    getTitleField(){
        var text=document.createTextNode('Tytuł:');
            this.title=document.createElement('h3');
            this.title.classList.add('text-center','font-weight-bold','text-dark');//text-danger
            this.title.appendChild(text);
        return this.title;
    }
    getInputField(){
        var self=this;
        this.input = this.Html.getInput('title','','text');
        this.input.classList.add('form-control');
        this.input.setAttribute('placeholder','Enter title');
        this.input.setAttribute('aria-describedby',"titleHelp" );
        this.input.setAttribute('maxlength',this.max);
        this.input.value=this.value;
        this.input.oninput = function(){
            try{
                console.log('Form_stage_create_title.getInput() oninput()');
                self.checkLength(self,this.value);
                self.checkErrors(self);
            }
            catch(e){
                console.log('Form_stage_create_title.getInput() oninput() catch',e);
                self.Prototype.setError(self.Prototype,'_title_oninput','Application error occurred! Contact with Administrator!');
            }
        };
        this.input.onblur = function(){
            try{
                console.log('Form_stage_create_title.getInput() onblur()');
                self.checkLength(self,this.value);
                self.checkErrors(self);
            }
            catch(e){
                console.log('Form_stage_create_title.getInput() onblur() catch',e);
                self.Prototype.setError(self.Prototype,'_title_onblur','Application error occurred! Contact with Administrator!');
            }
        };
        return  this.input;
    }
    setHelpField(){
        var row=this.Html.getRow();
        var col_1=this.Html.getCol(1);
        var col_2=this.Html.getCol(11);
        var text=document.createTextNode('Staraj sie wprowadzić jednoznaczy tytuł. Należy wprowadzić minimum '+this.min.toString()+' znaki, a maksimum '+this.max.toString()+' znaki.');     
            this.help=document.createElement('small');
            this.help.setAttribute('id','titleHelp');
            this.help.classList.add('form-text','text-muted');
            this.help.appendChild(text);
            col_2.appendChild(this.help);
            row.append(col_1,col_2); 
            this.Prototype.ele.input.append(row);
    }
    checkLength(self,value){
        console.log('Form_stage_create_title.checkLength()',value); 
        self.value_length=value.length;
        self.checkMin(self);
        self.checkMax(self);
    }
    checkMax(self){
        console.log('Form_stage_create_title.checkMax()'); 
        if(self.value_length>self.max){
            self.Prototype.setError(self.Prototype,'_max','Wprowadzono za dużo znaków ('+self.value_length+').');
        }
        else{
            self.Prototype.unsetError(self.Prototype,'_max');
        }
    }
    checkMin(self){
        console.log('Form_stage_create_title.checkMin()');  
        if(self.value_length<self.min){
            self.Prototype.setError(self.Prototype,'_min','Wprowadź minimalną ilości znaków ('+self.value_length+').');
        }
        else{
            self.Prototype.unsetError(self.Prototype,'_min');
        }
    }
    checkErrors(self){
        console.log('Form_stage_create_title.checkErrors()');
        if(self.Prototype.ErrorStack.check()){
            console.log('Form_stage_create_title.checkErrors() errors exists');
            self.title.classList.remove('text-dark');//text-danger
            self.title.classList.add('text-danger');//text-danger
            self.input.classList.add('border-danger');
        }
        else{
            //console.log('Form_stage_create_title.checkErrors() no errors');
            self.title.classList.remove('text-danger');//text-danger
            self.title.classList.add('text-dark');//text-danger
            self.input.classList.remove('border-danger');
        }
        self.Prototype.checkErrors(self.Prototype);
    }
}