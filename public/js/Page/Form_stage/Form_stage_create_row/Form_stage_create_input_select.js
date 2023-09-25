class Form_stage_create_input_select{  
    
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();
    
    uniqid='';
    type = 'select';
    input = new Object();
    options = new Object();
    
    data = {
        'value':''
        ,'class':new Object()
        ,'style':new Object()
        ,'property':new Object()
    }
    
    constructor(Parent){
        try{
            //console.log('Form_stage_create_input_select.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            
            this.Prototype = new Form_stage_create_input_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu select');
            this.Prototype.setBorder('border-warning');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
            this.setInput();
        }
        catch(e){
            console.log('Form_stage_create_input_select.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setInput(){
        console.log('Form_stage_create_input_select.setInputField()');

        var text_div=document.createElement('div');
            text_div.classList.add('form-group','mb-1');//
        var select=document.createElement('select');
            select.classList.add('form-control');
            select.setAttribute('id',this.uniqid);
            select.setAttribute('name',this.uniqid);
        
        var country = new Array('PL','EN','DE');
            for(var i=0;i<country.length;i++){
                var option = document.createElement('option');
                    option.value=country[i];
                    option.append(document.createTextNode(country[i]));
                    select.append(option);
                    this.options[i]=country[i];
            }

            text_div.append(select);
            this.input=select;
            this.Prototype.ele.input.append(text_div);
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_text.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        return {     
            'id':this.input.id
            ,'value':this.input.value
            ,'name':this.input.name
            ,'type':'select'
            ,'property':{
                'options':this.options
                ,'type':'select'
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