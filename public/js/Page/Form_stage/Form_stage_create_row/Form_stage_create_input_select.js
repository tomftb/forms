class Form_stage_create_input_select {  

    Html = new Object();
    Parent = new Object();
    Prototype = new Object();

    uniqid = '';
    type = 'select';
    input = new Object();
    input_position = new Object();
    options = new Object();
    tmp_positions = new Array();

    data = {
        'id_db':0
        ,'value': ''
        ,'type': 'select'
        , 'class': new Object()
        , 'style': new Object()
        , 'property': new Object()
        , 'glossary': {
            'id_glossary':0
            ,'name':''
            ,'id_glossary_position':0
            ,'position_name':''
        }
    }
    glossary = new Object();

    constructor(Parent) {
        try {
            //console.log('Form_stage_create_input_select.construct()');
            this.Html = new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.glossary = Parent.glossary;
            this.Prototype = new Form_stage_prototype(Parent,Parent.ele.dynamic);
            this.Prototype.setUniqid(this.type);
            this.Prototype.setTitle(this.type);
            this.Prototype.setRemoveTitle('Potwierdź usunięcie pola typu select');
            this.Prototype.setBorder('border-warning');
            this.Prototype.setFields();
            this.Prototype.setHeaderField();
            this.uniqid = this.Prototype.getUniqid();

        } catch (e) {
            console.log('Form_stage_create_input_select.construct() catch()', e);
            //alert('Application error occurred! Contact with Administrator!');
            Parent.setError(this, 'overall_input', 'Section row input error has occured! Contact with Administrator!');
            Parent.checkErrors(this);
        }
    }
    setInputWithData(StageRow){
        try{
            console.log("Form_stage_create_input_select.setInputWithData()\r\n",StageRow);
            this.data.id_db = StageRow.id_db;
            this.Prototype.Utilities.propertyExists(StageRow,'glossary','Object `StageRow` doesn\'t have `glossary` property!');
            this.Prototype.Utilities.propertyExists(StageRow.glossary,'id_glossary','Object `StageRow.glossary` doesn\'t have `id_glossary` property!');
            this.Prototype.Utilities.propertyExists(StageRow.glossary,'name','Object `StageRow.glossary` doesn\'t have `name` property!');
            this.Prototype.Utilities.propertyExists(StageRow.glossary,'id_glossary_position','Object `StageRow.glossary` doesn\'t have `id_glossary_position` property!');
            this.Prototype.Utilities.propertyExists(StageRow.glossary,'position_name','Object `StageRow.glossary` doesn\'t have `position_name` property!');
            console.log(this.glossary);
            this.Prototype.Utilities.propertyExists(this.glossary,StageRow.glossary.id_glossary,'Object `'+this.glossary+'` doesn\'t have `'+StageRow.glossary.id_glossary+'` property!');
            this.Prototype.Utilities.propertyExists(this.glossary[StageRow.glossary.id_glossary],'positions','Object `glossary[StageRow.glossary.id_glossary]` doesn\'t have `positions` property!');
            this.Prototype.Utilities.propertyExists(this.glossary[StageRow.glossary.id_glossary].positions,StageRow.glossary.id_glossary_position,'Object `glossary[StageRow.glossary.id_glossary].positions` doesn\'t have `'+StageRow.glossary.id_glossary_position+'` property!');
            this.data.glossary.id_glossary = StageRow.glossary.id_glossary;
            this.data.glossary.name = StageRow.glossary.name;//+'aa';
            this.data.glossary.id_glossary_position = StageRow.glossary.id_glossary_position;
            this.data.glossary.position_name = StageRow.glossary.position_name;//+'aaaa';
            this.setInputGlossary();
            this.setInputGlossaryOptionsWithCheck();
            this.setInputGlossaryPositions();
            this.setInputGlossaryPositionsOptionsWithCheck();
        }
        catch(e){
            console.log('Form_stage_create_input_select.setInputWithData() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.Prototype.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            this.Prototype.checkErrors(this);
        }
    }
    setInput() {
        try{
            console.log('Form_stage_create_input_select.setInput()');
            console.log(this.glossary);
            this.setInputGlossary();
            this.setInputGlossaryOptions();
            this.setInputGlossaryPositions();
            this.setInputGlossaryPositionsOptions();
        }
        catch(e){
            console.log('Form_stage_create_input_select.setInput() catch()',e);
            //alert('Application error occurred! Contact with Administrator!');
            this.Prototype.setError(this,'overall_input','Section row input error has occured! Contact with Administrator!');
            this.Prototype.checkErrors(this);
        }
    }
    setInputGlossary(){
        console.log('Form_stage_create_input_select.setInputGlossary()');
        var self = this;
        var div = document.createElement('div');
            div.classList.add('form-group', 'mb-1');
        var label_glossary = document.createElement('label');
            label_glossary.append(document.createTextNode('Wskaż słownik:'));
        var select = document.createElement('select');
            select.classList.add('form-control');
            select.setAttribute('id', this.uniqid + '_glossary');
            select.setAttribute('name', this.uniqid + '_glossary');
            select.onchange = function () {
                try {
                    console.log('Form_stage_create_input_select.setInputGlossary() onchange()');
                    console.log(this.value);
                    console.log(self.glossary);
                    self.Html.removeChilds(self.input_position);
                    self.setInputGlossaryPositionsNewOptions(self,parseInt(this.value, 10));
                } catch (e) {
                    self.Parent.setError(self.Parent, 'overall_select', 'Section row input select error has occured! Contact with Administrator!');
                    self.Parent.checkErrors(self.Parent);
                }
            };
        div.append(label_glossary);
        div.append(select);
        this.input = select;
        this.Prototype.ele.input.append(div);
    }
    setInputGlossaryOptions(){
        console.log('Form_stage_create_input_select.setInputGlossaryOptions()');
        for(const prop in this.glossary) {
            var option = document.createElement('option');
                option.value = prop;// IN POST SET GET ID this.glossary[i].id;
                name = this.glossary[prop].name;
                option.append(document.createTextNode(name));
                this.input.append(option);
        }
    }
    setInputGlossaryOptionsWithCheck(){
        console.log('Form_stage_create_input_select.setInputGlossaryOptionsWithCheck()');
        var name = '';
        for(const prop in this.glossary ) {
            //console.log("prop",prop);
            // console.log("name",this.glossary[prop].name);
            // console.log("id_glossary",this.data.glossary.id_glossary);
            // console.log("glossary name",this.glossary[prop].name); 
            var option = document.createElement('option');
                option.value = prop;
                name = this.glossary[prop].name;
                if(prop===this.data.glossary.id_glossary){
                    option.setAttribute('selected','');
                }
                if(prop===this.data.glossary.id_glossary && this.glossary[prop].name!==this.data.glossary.name){
                    name+=' ('+this.data.glossary.name+')';
                }
                option.append(document.createTextNode(name));
                this.input.append(option);
        }
    }
    setInputGlossaryPositions() {
        console.log('Form_stage_create_input_select.setInputGlossaryPositions()');
        var div = document.createElement('div');
            div.classList.add('form-group', 'mb-1');
        var label_glossary = document.createElement('label');
            label_glossary.append(document.createTextNode('Wskaż domyślną pozycję słownika:'));
        var select = document.createElement('select');
            select.classList.add('form-control');
            select.setAttribute('id', this.uniqid + '_glossary_position');
            select.setAttribute('name', this.uniqid + '_glossary_position');
        this.input_position = select;
        div.append(label_glossary);
        div.append(select);
        this.Prototype.ele.input.append(div);
    }
    setInputGlossaryPositionsOptions(){
        console.log('Form_stage_create_input_select.setInputGlossaryPositionsOptions()');
        for (const prop in this.glossary) {   
            this.setInputGlossaryPositionsNewOptions(this,prop);
            /* ONLY FIRST AT START */
            break;
        }
    }
    setInputGlossaryPositionsOptionsWithCheck(){
        var name = '';
        for (const prop in this.glossary[this.data.glossary.id_glossary].positions) {
            name = this.glossary[this.data.glossary.id_glossary].positions[prop].name;
            var option = document.createElement('option');
                option.value = prop;
                if(prop===this.data.glossary.id_glossary_position){
                    option.setAttribute('selected','');
                }
                if(prop===this.data.glossary.id_glossary_position && this.glossary[this.data.glossary.id_glossary].positions[prop].name!==this.data.glossary.position_name){
                    name+=' ('+this.data.glossary.position_name+')';
                }
                option.append(document.createTextNode(name));
                this.input_position.append(option);
        }
    }
    setInputGlossaryPositionsNewOptions(self,value){
        console.log('Form_stage_create_input_select.setInputGlossaryPositionsNewOptions()');
        for (const prop in self.glossary[value].positions) {
            var option = document.createElement('option');
                option.value = prop;
                option.append(document.createTextNode(self.glossary[value].positions[prop].name));
                self.input_position.append(option);
        }
    }
    setData(data_row, data_row_id) {
        console.log('Form_stage_create_select.setData()');
        this.Prototype.setDataRow(data_row, data_row_id);
    }
    getData() {
        return {
            'id_db': this.data.id_db
            , 'value': this.input.value
            , 'name': this.input.name
            , 'type': 'select'
            , 'property': {
                'type': this.input.type
            }
            , 'style': new Object()
            ,'glossary':{
                'id_glossary': this.input.value//this.getGlossaryId()
                , 'name': this.glossary[this.input.value].name //''
                , 'id_glossary_position':this.input_position.value//0
                , 'position_name': this.glossary[this.input.value].positions[this.input_position.value].name //this.getGlossaryPositionId()'
            }
           
        };
    }
    getName() {
        this.data.value = this.input.value;
        return this.uniqid;
    }
    getType() {
        return this.type;
    }
    updateIdDb(row) {
        console.log('Form_stage_create_select.updateIdDb()');
        this.data.id_db = row.id_db;
    }
}