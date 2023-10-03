class Form_stage_create_subsection{  
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
        ,'dynamic_fields':new Object()
        ,'error':new Object()
    }    
    uniqid = '';
    row_counter=0;
    column_size=2;
    Row = new Object();
    id_db = 0;
    default_row_field = 'text';
    create = new Object();
    glossary = new Object();
    
    constructor(Parent,ele,column_size,glossary){
        try{
            console.log('Form_stage_create_subsection.construct()');
            this.Html=new Html();
            this.Utilities=new Utilities();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            this.parameters = Parent.parameters;
            this.glossary = glossary;
            this.setUniqid();  
            this.setCreate();
            this.setRowCounter(Parent.parameters);
            this.setRowDefaultField(Parent.parameters);
            this.set(ele,column_size);
            //this.setRows();
        }
        catch(e){
            console.log('Form_stage_create_subsection.construct() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.setError(this,'overall_subsection','Application error occurred! Contact with Administrator!');
            this.checkErrors(this);
        }
    }
    setWithoutData(){
        console.log('Form_stage_create_subsection.setWithoutData()');
        //console.log('Form_stage_create_subsection.setRows()');
        var max = this.row_counter;
        for(var i=0;i<max;i++){
            //self.Row[i] = create(this);
            var id = this.uniqid+this.row_counter.toString();
                //console.log('Form_stage_create_subsection.setAddText() onclick() '+label);
                console.log(this.ele.dynamic);
                console.log(this.row_counter);
                /*
                 * DYNAMIC RUN ANONYMOUSE FUNCTION AND SETUP ROW OBJECT
                 */
                this.Row[this.row_counter] = this.create[this.default_row_field](this);//self.row_counter//id
                this.Row[this.row_counter].setInput();
                /*
                 * SET REFERENCE TO ROW OBJECT
                 */
                this.Row[this.row_counter].setData(this.Row,id);//self.row_counter//id
                this.row_counter++;
                console.log(this.ele.dynamic_fields);
        }
    }
    setWithData(StageSubsection){
        console.log("Form_stage_create_subsection.setWithData()\r\n",StageSubsection);//,StageRow
        
        this.id_db = StageSubsection.id_db;
        for(const prop in StageSubsection.row){
            console.log(StageSubsection.row[prop]);
            this.Utilities.propertyExists(StageSubsection.row[prop],'id_db','Object `StageSubsection.row[prop]` dosn\'t have `id_db` property!');
            this.Utilities.propertyExists(StageSubsection.row[prop],'name','Object `StageSubsection.row[prop]` dosn\'t have `name` property!');
            this.Utilities.propertyExists(StageSubsection.row[prop],'type','Object `StageSubsection.row[prop]` dosn\'t have `type` property!');
            this.Utilities.propertyExists(StageSubsection.row[prop],'value','Object `StageSubsection.row[prop]` dosn\'t have `value` property!');
            var id = this.uniqid+this.row_counter.toString();
            this.Row[this.row_counter] = this.create[StageSubsection.row[prop].type](this);//self.row_counter//id
            this.Row[this.row_counter].setInputWithData(StageSubsection.row[prop]);
            this.Row[this.row_counter].setData(this.Row,id);//self.row_counter//id
            this.row_counter++;
        }
    }
    setRowCounter(parameters){
        this.Utilities.propertyExists(parameters,'FORM_STAGE_ROW_COUNT','No `FORM_STAGE_ROW_COUNT` parameter!');
        this.row_counter = parseInt(parameters.FORM_STAGE_ROW_COUNT,10);
    }
    setRowDefaultField(parameters){
        this.Utilities.propertyExists(parameters,'FORM_STAGE_ROW_FIELD','No `FORM_STAGE_ROW_FIELD` parameter!');
        this.default_row_field = parameters.FORM_STAGE_ROW_FIELD;
    }
    setCreate(){
        this.create.text = function(self){return new Form_stage_create_text(self);};
        this.create.input = function(self){ return new Form_stage_create_input(self);};
        this.create.select = function(self){ return new Form_stage_create_input_select(self);};
        this.create.checkbox = function(self){ return new Form_stage_create_input_checkbox(self);};
        this.create.radio = function(self){ return new Form_stage_create_input_radio(self);};
    }
    //setRows(){

   // }
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
            this.setAddButton('T','success','Dodaj tekst',this.create.text);
            this.setAddButton('I','purple','Dodaj pole typu wprowadź dane',this.create.input);
            this.setAddButton('S','danger','Dodaj pole typu wskaż z listy',this.create.select);
            this.setAddButton('C','warning','Dodaj pole typu zaznacz',this.create.checkbox);
            this.setAddButton('R','primary','Dodaj pole typu wyboru',this.create.radio);
    }
    setAddButton(label,button_color,title,create){
        //console.log('Form_stage_create_section.setAddButton() label - '+label);
        var self = this;
        var button = this.Html.getButton(label,['btn','btn-'+button_color]);//,'btn-sm'
            button.setAttribute('title',title);
            button.onclick=function(){
            try{
                var id = self.uniqid+self.row_counter.toString();
                //console.log('Form_stage_create_subsection.setAddText() onclick() '+label);
                console.log(self.ele.dynamic);
                console.log(self.row_counter);
                /*
                 * DYNAMIC RUN ANONYMOUSE FUNCTION AND SETUP ROW OBJECT
                 */
                self.Row[self.row_counter] = create(self);//self.row_counter//id
                self.Row[self.row_counter].setInput();
                /*
                 * SET REFERENCE TO ROW OBJECT
                 */
                self.Row[self.row_counter].setData(self.Row,id);//self.row_counter//id
                self.row_counter++;
                console.log(self.ele.dynamic_fields);
            }
            catch(e){
                //console.clear();
                console.error('Form_stage_create_subsection.construct() onclick() catch()');
                console.error('button label - ',label);
                console.error('error - ',e);
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
    }
    setError(self,code,msg){
        console.log('Form_stage_create_subsection.setError()');
        console.log(self);
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