class Form_stage_create_input_checkbox{  
    
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    
    uniqid='';
    type = 'checkbox';
    input = new Object();
    data = {
        'value':''
        ,'label':''
        ,'class':new Object()
        ,'style':new Object()
        ,'property':new Object()
    }
    
    constructor(Parent){
        try{
            //console.log('Form_stage_create_input_checkbox.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            
            this.Prototype = new Form_stage_create_input_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu checkbox');
            this.Prototype.setUniqid(this.type);
            this.Prototype.setBorder('border-warning');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
            this.setInput();
        }
        catch(e){
            console.log('Form_stage_create_input_checkbox.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setInput(){
        console.log('Form_stage_create_input_checkbox.setInputField()');

        var div_input_group=document.createElement('div');
            div_input_group.classList.add('input-group');
          
        var div_input_group_prepend=document.createElement('div');
            div_input_group_prepend.classList.add('input-group-prepend');
        
        var div_input_group_text=document.createElement('div');
            div_input_group_text.classList.add('input-group-text');
        
       
        var input_checkbox=document.createElement('input');
            input_checkbox.setAttribute('type','checkbox');
            input_checkbox.setAttribute('id',this.uniqid+'_input');
            input_checkbox.setAttribute('name',this.uniqid+'_input');
            
        var input_text=document.createElement('input');
            input_text.classList.add('form-control');
            input_text.setAttribute('id',this.uniqid+'_label');
            input_text.setAttribute('name',this.uniqid+'_label');
            input_text.setAttribute('type','text');
            input_text.setAttribute('placeholder','Write checkbox label...');
            input_text.setAttribute('aria-label',this.uniqid+"text input with checkbox");
            
            div_input_group_text.append(input_checkbox);
            div_input_group_prepend.append(div_input_group_text);
            div_input_group.append(div_input_group_prepend,input_text);

            this.input.checkbox=input_checkbox;
            this.input.text=input_text;
            this.Prototype.ele.input.append(div_input_group);
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_text.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        return {
            'id':this.input.checkbox.id
            ,'value':this.input.checkbox.value
            ,'name':this.input.checkbox.name
            ,'type':'checkbox'
            ,'property':{
                'label':{
                     'id':this.input.text.id
                    ,'value':this.input.text.value
                    ,'name':this.input.text.name
                    ,'type':this.input.text.type
                }
                ,'type':this.input.checkbox.type
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