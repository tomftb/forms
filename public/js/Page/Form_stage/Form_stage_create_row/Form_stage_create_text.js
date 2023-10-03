class Form_stage_create_text{  
   
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    
    uniqid='';
    type = 'text';

    input = new Object();
    
    data = {
        'id_db':0
        ,'value':''
        ,'type':'text'
        ,'class':new Object()
        ,'style':new Object()
        ,'property':new Object()
    }
    constructor(Parent){
        try{
            //console.log('Form_stage_create_text.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.Prototype = new Form_stage_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu tekst');
            this.Prototype.setBorder('border-success');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
        }
        catch(e){
            console.log('Form_stage_create_text.construct() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            Parent.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            Parent.checkErrors(this);
        }
    }
    setInputWithData(StageRow){
        console.log("Form_stage_create_text.setInputWithData()",StageRow);
        this.data.id_db = StageRow.id_db;
        this.data.value = StageRow.value;
        this.data.type = StageRow.type;
        this.setInput();
    }
    setInput(){
        try{
            console.log('Form_stage_create_text.setInput()');
            var text_div=document.createElement('div');
                text_div.classList.add('form-group','mb-1');
            var input=document.createElement('input');
                input.classList.add('form-control');
                input.setAttribute('id',this.uniqid);
                input.setAttribute('name',this.uniqid);
                input.setAttribute('type',this.data.type);/* TO DO */
                input.setAttribute('placeholder','Write text...');/* TO DO */
                input.value=this.data.value;
                text_div.append(input);
                this.input=input;
                this.Prototype.ele.input.append(text_div);
        }
        catch(e){
            console.log('Form_stage_create_text.setInput() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.Prototype.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            this.Prototype.checkErrors(this);
        }
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_text.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        console.log('Form_stage_create_text.getData()',this.input);
        return {
            'id_db':this.data.id_db
            ,'value':this.input.value
            ,'name':this.input.name
            ,'type':'text'
            ,'property':{
                'type':this.input.type
            }
            ,'style':new Object()
        };
    }
    getName(){
        this.data.value=this.input.value;
        return this.uniqid;
    }
    getType(){
        return this.type;
    }
    updateIdDb(row){
        console.log('Form_stage_create_text.setData()');
        this.data.id_db = row.id_db;
    }
}