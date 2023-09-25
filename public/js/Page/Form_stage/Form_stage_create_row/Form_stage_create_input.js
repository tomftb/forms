class Form_stage_create_input{  
    uniqid='';
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    type = 'input';
    input = new Object();
    data = {
        'value':''
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
            this.Prototype = new Form_stage_create_input_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu input');
            this.Prototype.setBorder('border-purple');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
            this.setInput();
        }
        catch(e){
            console.log('Form_stage_create_input.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setInput(){
        console.log('Form_stage_create_input.setInputField()');
        var text_div=document.createElement('div');
            text_div.classList.add('form-group','mb-1');//
        var text_input=document.createElement('input');
            text_input.classList.add('form-control');
            text_input.setAttribute('readonly','');
            text_input.setAttribute('disabled','');
            text_input.setAttribute('id',this.uniqid);
            text_input.setAttribute('name',this.uniqid);
            text_input.setAttribute('type','text');/* TO DO */
            text_input.setAttribute('placeholder','Write...');
            text_div.append(text_input);
            this.input = text_input;
            this.Prototype.ele.input.append(text_div);
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_text.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        //this.data.value=this.input.value;
        //return this.data;
        return {
            'id':0//this.input.id
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
}