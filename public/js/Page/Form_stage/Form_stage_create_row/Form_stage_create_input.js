class Form_stage_create_input{  
    uniqid='';
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    type = 'input';
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
            //console.log('Form_stage_create_input.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            /*
             * Prototype
             */
            this.Prototype = new Form_stage_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu input');
            this.Prototype.setBorder('border-purple');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
        }
        catch(e){
            console.log('Form_stage_create_input.construct() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            Parent.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            Parent.checkErrors(this);
        }
    }
    setInputWithData(StageRow){
        console.log('Form_stage_create_input.setInputWithData()');
        this.data.id_db = StageRow.id_db; 
        this.data.value = StageRow.value;
        this.data.type = StageRow.type;
        this.setInput();
    }
    setInput(){
        try{
            console.log('Form_stage_create_input.setInput()');
            var text_div=document.createElement('div');
                text_div.classList.add('form-group','mb-1');//
            var text_input=document.createElement('input');
                text_input.classList.add('form-control');
                text_input.setAttribute('readonly','');
                text_input.setAttribute('disabled','');
                text_input.setAttribute('id',this.uniqid);
                text_input.setAttribute('name',this.uniqid);
                text_input.setAttribute('value',this.data.value);/* TO DO */
                text_input.setAttribute('type',this.data.type);/* TO DO */
                text_input.setAttribute('placeholder','Write...');
                text_div.append(text_input);
                this.input = text_input;
                this.Prototype.ele.input.append(text_div);
        }
        catch(e){
            console.log('Form_stage_create_input.setInput() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.Prototype.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            this.Prototype.checkErrors(this);
        }
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_input.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        //this.data.value=this.input.value;
        //return this.data;
        return {
            'id_db':this.data.id_db
            ,'value':this.input.value
            ,'name':this.input.name
            ,'type':'input'
            ,'property':{
                'type':this.input.type//number to do in future
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
        console.log('Form_stage_create_input.updateIdDb()');
        this.data.id_db = row.id_db;
    }
}