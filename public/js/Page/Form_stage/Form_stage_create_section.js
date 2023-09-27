class Form_stage_create_section{  
    
    Html = new Object();
    Utilities = new Object();
    ErrorStack = new Object();
    /*
     * REFERENCES TO ELEMENTS
     */
    ele={
        'main':new Object()
        ,'action':new Object()
        ,'dynamic':new Object()
        ,'error':new Object()
    }
    section_counter = 0;
    Section = new Object();
    uniqid = '';
    
    constructor(Parent){
        try{
            console.log('Form_stage_create_section.construct()');
            this.Html=new Html();
            this.Utilities = new Utilities();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            
        }
        catch(e){
            console.log('Form_stage_create_section.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_preview";
        console.log(this.uniqid);
    }
    setActionField(){
        console.log('Form_stage_create_section.setActionField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'section_action_field');
        var col_1=this.Html.getCol(10);
        this.ele.action=this.Html.getCol(2);
            //this.ele_action.classList.add('btn-group','pull-right');
            row.append(this.ele.action,col_1);
            this.ele.main.append(row);
            /*
             * SET ADD ACTION - BUTTON 
             */
            this.setAddAction();
    }
    setAddAction(){
        console.log('Form_stage_create_section.setAddAction()');
        var self = this;
        var button = this.Html.getButton('Dodaj wiersz',['btn','btn-success']);
            button.onclick=function(){
                try{
                    console.log('Form_stage_create_section.setAddButton() onclick()');
                    console.log(self.ele.dynamic);
                    console.log(self.section_counter);
                    self.Section[self.section_counter] = new Form_stage_section(self.ele.dynamic,self.section_counter,self.parameters);
                    //self.addField(self);
                    self.section_counter++;
                    //console.log(self.ele.dynamic_fields);
                }
                catch(e){
                    console.log('Form_stage_create_section.construct() catch()',e);
                    self.setError(self,'add','Section error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            };
        this.ele.action.append(button);
    }
    setDynamicField(){
        console.log('Form_stage_create_section.setDynamicField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'section_dynamic_field');
        this.ele.dynamic=this.Html.getCol(12);
            row.appendChild(this.ele.dynamic);
            this.ele.main.append(row);
    }
    setValue(value){
        this.subsection_counter=Math.floor(value);
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_";
        console.log(this.uniqid);
    }
    getData(){
        console.log('Form_stage_create_section.getData()');
        var data = new Object();
        for(const prop in this.Section){
            console.log(this.Section[prop]);
            data[prop] = {
                'id_db':this.Section[prop].getIdDb()
                ,'subsection':this.Section[prop].getData()
            };
        }
        return data;
    }
    setErrorField(){
        var row = this.Html.getRow();
            row.classList.add('mt-1');
            row.setAttribute('id',this.uniqid+'section_error_field');
        var col=this.Html.getCol(12);
            this.ele.error = document.createElement('div');
            col.appendChild(this.ele.error);
            row.append(col);
        this.ele.main.append(row);
    }
    setMainEle(ele){
        console.log('Form_stage_create_section.setMainEle()');
        console.log(ele);
        this.ele.main = ele;
    }
    set(ele,parameters){
        console.log('Form_stage_create_section.set()');
        /*
         * RESET FIELD COUNTER
         */
        this.setSectionCounter(parameters);
        
        /*
         * RESET FIELD SUBSETION DEFAULT COUNTER
         */
        //this.subsection_counter = 2;
        this.parameters = parameters;
        this.setUniqid();
        this.setMainEle(ele);
        this.setDynamicField();
        this.setSections(parameters);
        this.setActionField();
        this.setErrorField();       
        console.log(this.ele);
    }
    setSectionCounter(parameters){
        this.Utilities.propertyExists(parameters,'FORM_STAGE_SECTION_COUNT','No `FORM_STAGE_SECTION_COUNT` parameter!');
        this.section_counter = parseInt(parameters.FORM_STAGE_SECTION_COUNT,10);
    }
    setSections(parameters){
        for(var i = 0; i < this.section_counter ; i++){
            this.Section[i] = new Form_stage_section(this.ele.dynamic,i,parameters);
        }
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
        console.log('Form_stage_create_section.checkErrors()');
        try{
            if(self.ErrorStack.check()){
                console.log('Form_stage_create_section.checkErrors() errors exists');
                this.ele.error.classList.add('alert','alert-danger');
                this.ele.error.setAttribute('role','alert');
                self.Html.removeChilds(self.ele.error);
                self.ele.error.innerHTML = self.ErrorStack.getHtmlWithMask(self.uniqid);
            }
            else{
                console.log('Form_stage_create_section.checkErrors() no errors');
                self.ele.error.classList.remove('alert','alert-danger');
                self.ele.error.removeAttribute('role');
                self.Html.removeChilds(self.ele.error);
            }
        }
        catch(e){
            console.log('Form_stage_create_section.checkErrors()',e);
            alert('Application error occurred! Contact with Administrator!');
        }  
    }
    updateId(section){
        console.log('Form_stage_create_section.updateId()');
        console.log('NEW DATA',section);
        console.log('PRESENT DATA',this.Section);
        for(const prop in section){
            this.Section[prop].updateIdDb(section[prop]);
        }
        console.log('NEW PRESENT DATA',this.Section);
    }
}