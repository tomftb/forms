class Form_stage_create_text{  
   
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    
    uniqid='';
    type = 'text';

    input = new Object();
    
    data = {
        'value':''
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
            this.Prototype = new Form_stage_create_input_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu tekst');
            this.Prototype.setBorder('border-success');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
            this.setInput();
        }
        catch(e){
            console.log('Form_stage_create_text.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setInput(){
        console.log('Form_stage_create_text.setInputField()');
        var text_div=document.createElement('div');
            text_div.classList.add('form-group','mb-1');
        var input=document.createElement('input');
            input.classList.add('form-control');
            input.setAttribute('id',this.uniqid);
            input.setAttribute('name',this.uniqid);
            text_div.append(input);
            this.input=input;
            this.Prototype.ele.input.append(text_div);
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_text.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        console.log('Form_stage_create_text.getData()',this.input);
        return {
            'value':this.input.value
            ,'id':this.uniqid
            ,'type':'text'
            ,'property':{}
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