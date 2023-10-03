class Form_stage_create_input_radio{  
    
    Html = new Object();
    Parent = new Object();
    Prototype = new Object();

    uniqid='';
    type = 'radio';
    input = {
        'radio':new Object()
        ,'text':new Object()
    };
    data = {
        'value':''
        ,'id_db':0
        ,'label':''
        ,'class':new Object()
        ,'style':new Object()
        ,'property':new Object()
        ,'child':{
             'id_db':0
            ,'name':''
            ,'type':'text'
            ,'value':''
        }
    }
    constructor(Parent){
        try{
            //console.log('Form_stage_create_input_radio.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            /*
             * Prototype
             */
            this.Prototype = new Form_stage_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu radio');
            this.Prototype.setUniqid(this.type);
            this.Prototype.setBorder('border-primary');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();
        }
        catch(e){
            console.log('Form_stage_create_input_radio.construct() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            Parent.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            Parent.checkErrors(this);
        }
    }
    setInputWithData(StageRow){
        console.log('Form_stage_create_input_radio.setInputWithData()');
        this.data.id_db = StageRow.id_db; 
        
        this.Prototype.Utilities.propertyExists(StageRow,'child','Object `StageRow` doesn\'t have `child` property!');
        this.Prototype.Utilities.propertyExists(StageRow.child,'id_db','Object `StageRow.child` doesn\'t have `id_db` property!');
        this.Prototype.Utilities.propertyExists(StageRow.child,'value','Object `StageRow.child` doesn\'t have `value` property!');
        this.Prototype.Utilities.propertyExists(StageRow.child,'name','Object `StageRow.child` doesn\'t have `name` property!');
        this.Prototype.Utilities.propertyExists(StageRow.child,'type','Object `StageRow.child` doesn\'t have `type` property!');
           
        this.data.child.id_db = StageRow.child.id_db;
        this.data.child.value = StageRow.child.value;
        this.data.child.name = StageRow.child.name;
        this.data.child.type = StageRow.child.typ;
        
        this.setInput();
    }
    setInput(){
        try{
            console.log('Form_stage_create_input_radio.setInput()');
            var div_input_group=document.createElement('div');
                div_input_group.classList.add('input-group');
            var div_input_group_prepend=document.createElement('div');
                div_input_group_prepend.classList.add('input-group-prepend');
            var div_input_group_text=document.createElement('div');
                div_input_group_text.classList.add('input-group-text');
            var input_radio=document.createElement('input');
                input_radio.setAttribute('type','radio');
                input_radio.setAttribute('id',this.uniqid+'_input');
                input_radio.setAttribute('name',this.uniqid+'_input');
            var input_text=document.createElement('input');
                input_text.classList.add('form-control');
                input_text.setAttribute('id',this.uniqid+'_label');
                input_text.setAttribute('name',this.uniqid+'_label');
                input_text.setAttribute('type',this.data.child.type);
                input_text.setAttribute('value',this.data.child.value);
                input_text.setAttribute('placeholder','Write radio label...');
                input_text.setAttribute('aria-label',this.uniqid+"text input with radio button");
                div_input_group_text.append(input_radio);
                div_input_group_prepend.append(div_input_group_text);            
                div_input_group.append(div_input_group_prepend,input_text);
                /*
                 * SET INPUT
                 */
                this.input.radio=input_radio;
                this.input.text=input_text;
                this.Prototype.ele.input.append(div_input_group); 
        }
        catch(e){
            console.log('Form_stage_create_input_radio.setInput() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.Prototype.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            this.Prototype.checkErrors(this);
        }
            
    }
    setData(data_row,data_row_id){
        console.log('Form_stage_create_radio.setData()');
        this.Prototype.setDataRow(data_row,data_row_id);
    }
    getData(){
        return {
            'id_db':this.data.id_db
            ,'value':this.input.radio.value
            ,'name':this.input.radio.name
            ,'type':'radio'
            ,'property':{
                'type':this.input.radio.type
            }
            ,'child':{//label
                'id_db':this.data.child.id_db
                ,'value':this.input.text.value
                ,'name':this.input.text.name
                ,'type':this.input.text.type
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
        console.log('Form_stage_create_radio.updateIdDb()');
        this.data.id_db = row.id_db;
        this.data.child.id_db = row.child.id_db;
    }
}