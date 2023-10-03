class Form_stage_preview{
    Html = new Object();
    Utilities = new Object();
    //ele = new Object();
    //data = new Object();
    subsection_min = 1;
    subsection_max = 12;
    uniqid = '';
    counter = 0;
    glossary = new Object();
    
    constructor(){
        console.log('Form_stage_preview.construct()');
        this.setUniqid();
        this.Html = new Html();
        this.Utilities = new Utilities();
    }
    setGlossary(glossary){
         this.glossary = glossary;
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_preview";
        console.log(this.uniqid);
    }
    load(ele,data){
        console.log('Form_stage_preview.load()');
         /*
         * CLEAR PREVIEW ELEMENT FIELD
         */
        this.Html.removeChilds(ele);
        this.setStage(ele,data);
        console.log('Form_stage_preview.construct() END');
        console.log(ele);
    }
    setStage(ele,data){
        //console.log('Form_stage_preview.setStage()');
        for(const prop in data){
            //console.log(data[prop]);
            this.setSection(ele,data[prop].section);
        }
    }
    setSection(ele,data){
        //console.log('Form_stage_preview.setSection()',data);     
        for(const prop in data){
            var row = this.Html.getRow();
                console.log(data[prop]);
                this.setSubsection(row,data[prop].subsection);
                ele.append(row);
        }    
    }
    setSubsection(ele,data){
        //console.log('Form_stage_preview.setSubsection()',data);
        
        var current = 0;
        for(const prop in data){
                current++;
        }
        if(current<1){
            return false;
        }
        if(current>12){
            throw "Too many subsections - `"+current+"`, max allowed - `12`";
        }
        var column_size = Math.floor(12/current);//round
        var tmp_column_size = column_size;
        var rest = 12 - (column_size*current);
        
        for(const prop in data){
                tmp_column_size=column_size;
                // console.log(rest);
                if(rest>0){
                    tmp_column_size+=1;
                    //console.log('tmp column size - ',tmp_column_size);
                    rest--;
                }
            var col = this.Html.getCol(tmp_column_size);
                //console.log(data[prop]);
                this.setRow(col,data[prop].row);
                ele.append(col);
                //ele.prepend(col);
        }
    }
    setRow(ele,data){
        //console.log('Form_stage_preview.setRow()',data);
        for(const prop in data){
            this.setRowProperty(ele,data[prop]);
            this.counter++;
        }
    }
    setRowProperty(ele,data){
        console.log('Form_stage_preview.setRowProperty()',data);
        this.Utilities.propertyExists(data,'type',"Row data doesn't have `type` property!");
        this.Utilities.propertyExists(data,'property',"Row data doesn't have `property` property!");
        this.Utilities.propertyExists(data,'value',"Row data doesn't have `value` property!");
        this.Utilities.propertyExists(data,'name',"Row data doesn't have `name` property!");

        try{
            /*
             * TO DO - number,password, email
             */
            this['setRow_'+data.type](ele,data);
        }
        catch(e){
            console.log('data.type - ',data.type);
            console.log('Form_stage_preview.setRowProperty()',e);
            throw "Form_stage_preview.setRowProperty()\n"+e;
        }
    }
    setRow_text(ele,data){
        console.log('Form_stage_preview.setRow_text()',data);
        
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
        
        var p = document.createElement('p');
            p.append(document.createTextNode(data.value.toString()));
            col.append(p);
            row.append(col);
            ele.append(row);
    }
    setRow_input(ele,data){
        console.log('Form_stage_preview.setRow_input()',data);
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
        var form_div=document.createElement('div');
            form_div.classList.add('form-group','mb-1');//
        var input=document.createElement('input');
            input.classList.add('form-control');
            input.setAttribute('placeholder','Write...');
            form_div.append(input);
            col.append(form_div);
            row.append(col);
            ele.append(row);
    }
    setRow_select(ele,data){
        console.log("Form_stage_preview.setRow_select()\r\n",data,"\r\n",this.glossary);
        console.log(this.glossary[data.property.glossary_id_db]);
        this.Utilities.propertyExists(data,'glossary',"Row data doesn't have `glossary` property!");
        this.Utilities.propertyExists(data.glossary,'id_glossary',"Row data `glossary doesn't have `id_glossary` property!");
        this.Utilities.propertyExists(data.glossary,'id_glossary_position',"Row data `glossary` doesn't have `id_glossary_position` property!");
        this.Utilities.propertyExists(this.glossary,data.glossary.id_glossary,"Glossary doesn't have `"+data.property.id_glossary+"` property!");
        this.Utilities.propertyExists(this.glossary[data.glossary.id_glossary],'positions',"Glossary `"+data.glossary.id_glossary+"` doesn't have `positions` property!");
        this.Utilities.propertyExists(this.glossary[data.glossary.id_glossary].positions,data.glossary.id_glossary_position,"Glossary property `"+data.glossary.id_glossary+"` `positions` doesn't have `"+data.glossary.id_glossary_position+"` property!");
        //this.Utilities.propertyExists(data.property,'options',"Row data `select` `property` doesn't have `options` property!");
        
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
        
        var form_div=document.createElement('div');
            form_div.classList.add('form-group','mb-1');//
        var select=document.createElement('select');
            select.classList.add('form-control');
        
            for(const prop in this.glossary[data.glossary.id_glossary].positions){
                //console.log(prop);
                //console.log(data.property.glossary_position_id_db);
                var option = document.createElement('option');
                    option.value=prop;
                    option.append(document.createTextNode(this.glossary[data.glossary.id_glossary].positions[prop].name));
                    if(prop === data.glossary.id_glossary_position){
                        option.setAttribute('selected','');
                    }
                    select.append(option);
            }
            form_div.append(select);
            col.append(form_div);
            row.append(col);
            ele.append(row);
    }
    setRow_checkbox(ele,data){
        console.log('Form_stage_preview.setRow_checkbox()',data);
        this.Utilities.propertyExists(data,'child',"Row data `checkbox` doesn't have `child` property!");
        /*
         * LABEL CHECK
         */
        this.Utilities.propertyExists(data.child,'value',"Row data `child` doesn't have `value` property!");
        var id = this.uniqid+"_checkbox_"+this.counter.toString();
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
        var form_check=document.createElement('div');
            form_check.classList.add('form-check','mb-1');
        var input=document.createElement('input');
            input.classList.add('form-check-input');
            input.setAttribute('type','checkbox');
            input.setAttribute('id',id);
        var label=document.createElement('label');
            label.classList.add('form-check-label'); 
            label.setAttribute('for',id);   
            label.append(document.createTextNode(data.child.value));
            form_check.append(input,label);
            col.append(form_check);
            row.append(col);
            ele.append(row);
    }
    setRow_radio(ele,data){
        console.log('Form_stage_preview.setRow_radio()',data);
         this.Utilities.propertyExists(data,'child',"Row data `radio` doesn't have `child` property!");
        /*
         * LABEL CHECK
         */
        this.Utilities.propertyExists(data.child,'value',"Row data `radio` `child` doesn't have `value` property!");
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
                var id = this.uniqid+"_checkbox_"+this.counter.toString();
        var row = this.Html.getRow();
        var col = this.Html.getCol(12);
        var form_check=document.createElement('div');
            form_check.classList.add('form-check','mb-1');
        var input=document.createElement('input');
            input.classList.add('form-check-input');
            input.setAttribute('type','radio');
            input.setAttribute('id',id);
        var label=document.createElement('label');
            label.classList.add('form-check-label');
            label.setAttribute('for',id);   
            label.append(document.createTextNode(data.child.value));
            form_check.append(input,label);
            col.append(form_check);
            row.append(col);
            ele.append(row);
    }
}