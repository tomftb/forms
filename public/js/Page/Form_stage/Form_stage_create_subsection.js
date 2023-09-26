class Form_stage_create_subsection{  
    Html = new Object();
    ErrorStack = new Object();
    /*
     * REFERENCES TO ELEMENTS
     */
    ele={
        'main':new Object()
        ,'action':new Object()
        ,'dynamic':new Object()
        ,'dynamic_fields':new Object()
        ,'error':new Object()
    }    
    uniqid = '';
    fields_counter=0;
    column_size=2;
    Row = new Object();
    id_db = 0;
    
    constructor(Parent,ele,column_size){
        try{
            //console.log('Form_stage_create_subsection.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            this.setUniqid();  
            this.set(ele,column_size);
        }
        catch(e){
            console.log('Form_stage_create_subsection.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setValue(value){
        this.value=value;
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_";
    }
    setDynamicField(){
        //console.log('Form_stage_create_subsection.setDynamicField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'subsection_dynamic_field');
        this.ele.dynamic=this.Html.getCol(12);
            row.appendChild(this.ele.dynamic);
            this.ele.main.append(row);
    }
    setErrorField(){
        var row = this.Html.getRow();
            row.classList.add('mt-1');
            row.setAttribute('id',this.uniqid+'subsection_error_field');
        var col=this.Html.getCol(12);
            this.ele.error = document.createElement('div');
            col.appendChild(this.ele.error);
            row.append(col);
        this.ele.main.append(row);
    }
    setActionField(){
        //console.log('Form_stage_create_section.setActionField() column_size - ',this.column_size);
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'subsection_action_field');
        var col = this.Html.getCol(12);//2
            this.ele.action=document.createElement('div');
            if(this.column_size>1){
                this.ele.action.classList.add('btn-group','pull-left');
            }
            else{
                this.ele.action.classList.add('btn-group-vertical');
            }
            col.append(this.ele.action);
            row.append(col);//,col_1
            this.ele.main.append(row);
            /*
             * SET ADD ACTION - BUTTON 
             */
            this.setAddButton('T','success','Dodaj tekst',function(self){ return new Form_stage_create_text(self);});//Create label
            this.setAddButton('I','purple','Dodaj pole typu wprowadź dane',function(self){ return new Form_stage_create_input(self);});//Create input
            this.setAddButton('S','danger','Dodaj pole typu wskaż z listy',function(self){ return new Form_stage_create_input_select(self);});//Create input select
            this.setAddButton('C','warning','Dodaj pole typu zaznacz',function(self){ return new Form_stage_create_input_checkbox(self);});//Create input checkbox
            this.setAddButton('R','primary','Dodaj pole typu wyboru',function(self){ return new Form_stage_create_input_radio(self);});//Create input radio
    }

    setAddButton(label,button_color,title,create){
        //console.log('Form_stage_create_section.setAddButton() label - '+label);
        var self = this;
        var button = this.Html.getButton(label,['btn','btn-'+button_color]);//,'btn-sm'
            button.setAttribute('title',title);
            button.onclick=function(){
            try{
                var id = self.uniqid+self.fields_counter.toString();
                //console.log('Form_stage_create_subsection.setAddText() onclick() '+label);
                console.log(self.ele.dynamic);
                console.log(self.fields_counter);
                /*
                 * DYNAMIC RUN ANONYMOUSE FUNCTION AND SETUP ROW OBJECT
                 */
                self.Row[id] = create(self);
                /*
                 * SET REFERENCE TO ROW OBJECT
                 */
                self.Row[id].setData(self.Row,id);
                self.fields_counter++;
                console.log(self.ele.dynamic_fields);
            }
            catch(e){
                console.log('Form_stage_create_subsection.construct() onclick() catch()',label,e);
                self.setError(self,'add','Subsection error has occured! Contact with Administrator!');
                self.checkErrors(self);
            }
        };
        this.ele.action.append(button);
    }
    setMainEle(ele){
        //console.log('Form_stage_create_subsection.setMainEle()');
        //console.log(ele);
        this.ele.main = ele;
    }
    get(){
        return this.ele;
    }
    getData(){
        console.log('Form_stage_create_subsection.getData()');
        var data = new Object();
        for (const prop in this.Row){
            data[prop] = this.Row[prop].getData();
        };
        return data;
    }
    set(ele,column_size){        
        //console.log('Form_stage_create_subsection.set()');
        this.column_size=column_size;
        this.setMainEle(ele);
        this.setDynamicField();
        this.setActionField();
        this.setErrorField();       
        this.get();
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
        console.log('Form_stage_create_subsection.checkErrors()');
        try{
            if(self.ErrorStack.check()){
                console.log('Form_stage_create_subsection.checkErrors() errors exists');
                this.ele.error.classList.add('alert','alert-danger');
                this.ele.error.setAttribute('role','alert');
                self.Html.removeChilds(self.ele.error);
                self.ele.error.innerHTML = self.ErrorStack.getHtmlWithMask(self.uniqid);
            }
            else{
                console.log('Form_stage_create_subsection.checkErrors() no errors');
                self.ele.error.classList.remove('alert','alert-danger');
                self.ele.error.removeAttribute('role');
                self.Html.removeChilds(self.ele.error);
            }
        }
        catch(e){
            console.log('Form_stage_create_subsection.checkErrors()',e);
            alert('Application error occurred! Contact with Administrator!');
        }  
    }
    getIdDb(){
        return this.id_db;
    }
    updateIdDb(data){
        console.log('Form_stage_create_subsection.updateIdDb()');
        console.log(data);
        this.id_db = data.id_db;
        for (const prop in data.row){
            console.log(this.Row[prop]);
            this.Row[prop].updateIdDb(data.row[prop]);
        };
    }
}