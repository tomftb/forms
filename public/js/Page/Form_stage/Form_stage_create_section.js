class Form_stage_create_section{  
    
    Html = new Object();
    
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
    section_counter = 0;
    subsection_min = 1;
    subsection_max = 12;
    subsection_counter = 5;
    uniqid = '';
    Section = new Object();
    
    constructor(Parent){
        try{
            console.log('Form_stage_create_section.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            this.setUniqid(); 
        }
        catch(e){
            console.log('Form_stage_create_section.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setActionField(){
        console.log('Form_stage_create_section.setActionField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'section_action_field');
        var col_1=this.Html.getCol(10);
        this.ele.action=this.Html.getCol(2);
            //this.ele_action.classList.add('btn-group','pull-right');
            row.append(this.ele.action,col_1);
            this.ele.main.append(row);
            /*
             * SET ADD ACTION - BUTTON 
             */
            this.setAddAction();
    }
    setAddAction(){
        console.log('Form_stage_create_section.setAddAction()');
        var self = this;
        var button = this.Html.getButton('Dodaj wiersz',['btn','btn-success']);
            button.onclick=function(){
                try{
                    console.log('Form_stage_create_section.setAddButton() onclick()');
                    console.log(self.ele.dynamic);
                    console.log(self.section_counter);
                    self.addField(self);
                    self.section_counter++;
                    console.log(self.ele.dynamic_fields);
                }
                catch(e){
                    console.log('Form_stage_create_section.construct() catch()',e);
                    self.setError(self,'add','Section error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            };
        this.ele.action.append(button);
    }
    setDynamicField(){
        console.log('Form_stage_create_section.setDynamicField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'section_dynamic_field');
        this.ele.dynamic=this.Html.getCol(12);
            row.appendChild(this.ele.dynamic);
            this.ele.main.append(row);
    }
    addField(self){
        console.log('Form_stage_create_section.addField()');
        /*
         * SET MAIN ID
         */
        var id = this.uniqid+'section_'+self.section_counter;
        /*
         * SET DYNAMIC FIELDS SKELETON;
         */
        self.ele.dynamic_fields[id]=new Object();
        /*
         * CREATE NEW Section property
         */
        self.Section[id]={
            'id':id
            ,'subsection':new Object()
        };
        /*
         * APPEND TO MAIN DYNAMIC ELEMENT
         */
        self.ele.dynamic.append(self.getFieldHead(self,id),self.getFieldOption(self,id),self.getFieldBody(self,id),self.getFieldFooter(self,id));
    }
    getFieldHead(self,id){
        var row=self.Html.getRow();
            row.setAttribute('id',id);
        var col=self.Html.getCol(12);
        var hr = document.createElement('hr');
            hr.classList.add('w-100','border-1','border-secondary','mt-2');
        var h = document.createElement('h3');
            h.classList.add('w-100','text-center','bg-info','text-white');
        var text = document.createTextNode('Wiersz nr '+self.section_counter);
            h.append(text);
            col.append(hr,h);
            row.append(col);
            console.log(self.ele.dynamic_fields);
        self.ele.dynamic_fields[id]['head']=row;
        return row;
    }
    getFieldOption(self,id){
        var row=self.Html.getRow();
            row.setAttribute('id',id+"_option");
        var col_1=self.Html.getCol(3);
        var col_2=self.Html.getCol(3);
        var col_3=self.Html.getCol(3);
        var col_4=self.Html.getCol(3);
            self.setSubsectionSelect(self,col_1,id);
            col_4.append(self.getRemoveButton(self,id));
            row.append(col_1,col_2,col_3,col_4);
            self.ele.dynamic_fields[id]['action']=row;
        return row;
    }
    getFieldBody(self,id){
        console.log('Form_stage_create_section.getFieldBody()');
        var row=self.Html.getRow();
            row.setAttribute('id',id+"_body");
            self.ele.dynamic_fields[id]['body']=row;
            
            self.setFieldBodyColumn(self,id,self.subsection_counter);
        return row;
    }
    setFieldBodyColumn(self,id,current){
        console.log('Form_stage_create_section.setFieldBodyColumn()');
        var total = Math.round(current);
        if(total>self.subsection_max){
            console.log('Form_stage_create_section.setFieldBodyColumn() EXCEPTION MAX');
            total = self.subsection_max;
        }
        if(total<self.subsection_min){
            console.log('Form_stage_create_section.setFieldBodyColumn() EXCEPTION MIN');
            total = self.subsection_min;
        }
        /*
         * MAX BOOTSTRAP COLUMN EQUAL 12
         */
        //console.log(self.subsection_max/current);
        var column_size = Math.floor(self.subsection_max/current);//round
        var tmp_column_size = column_size;
        var rest = self.subsection_max - (column_size*total);
            //console.log('total column - ',total);
            //console.log('column size - ',column_size);
            //console.log('rest column size - ',rest);
            /*
             * DEFAULT COLUMN
             */
            for(var i=1; i<total+1;i++){
                tmp_column_size=column_size;
               // console.log(rest);
                if(rest>0){
                    tmp_column_size+=1;
                    //console.log('tmp column size - ',tmp_column_size);
                    rest--;
                }
                var col=self.Html.getCol(tmp_column_size);
                self.Section[id].subsection[i] = new Form_stage_create_subsection(self,col,tmp_column_size);
                  //  Form_stage_create_subsection.set(col);
                /*
                 * PREPEND
                 */
                //self.ele.dynamic_fields[id]['body'].prepend(col);
                /*
                 * 
                 * APPEND
                 */
                self.ele.dynamic_fields[id]['body'].append(col);
            }
        /*
         * UPDATE CURRENT SUBSECTION COUNTER
         */
        //self.subsection_counter = current;
        //console.log(self.ele.dynamic_fields[id]['body']);
    }
    getFieldFooter(self,id){
        var row_footer=self.Html.getRow();
            row_footer.setAttribute('id',id+"_footer");
        var col_footer=self.Html.getCol(12);
            row_footer.append(col_footer);
            self.ele.dynamic_fields[id]['footer']=row_footer;
            return row_footer;
    }
    setValue(value){
        this.subsection_counter=Math.floor(value);
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_";
        console.log(this.uniqid);
    }
    getData(){
        console.log('Form_stage_create_section.getData()');
        var data = new Object();
        for(const section in this.Section){
            console.log(this.Section[section]);
            data[section] = {
                'id':section
                ,'subsection':new Object
            };
            for(const subsection in this.Section[section].subsection){
                data[section].subsection[subsection]={
                    'id':subsection
                    ,'row':this.Section[section].subsection[subsection].getData()
                };
            }
        }
        return data;
    }
    getRemoveButton(self,id){
        console.log('Form_stage_create_section.getRemoveButton() id - ',id);
        var button = self.Html.getButton('Usuń wiersz',['btn','btn-danger']);
            button.classList.add('float-right');
            button.onclick=function(){
                console.log('Form_stage_create_section.getRemoveButton() onclick() id - ',id);
                /*
                 * CLOSURE
                 */
                try{
                    if (confirm('Potwierdź usunięcie wiersza') === true) {
                        /*
                         * REMOVE FIELDS
                         */
                        for(const prop in self.ele.dynamic_fields[id]){
                            self.ele.dynamic_fields[id][prop].remove();
                        }
                        /*
                         * REMOVE OBJECT KEY
                         */
                        delete self.ele.dynamic_fields[id];
                        /*
                         * REMOVE Section with id
                         */
                         delete self.Section[id];
                        //console.log(self.Section[id]);
                    }
                    //console.log(self.Section[id]);
                }
                catch(e){
                    console.log('Form_stage_create_section.getRemoveButton() onclick() catch()',e);
                    self.setError(self,id,'Section error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            };
        return button;
    }
    setSubsectionSelect(self,ele,id){
        console.log('Form_stage_create_section.setSubsectionSelect() id - ',id);
        /*
         * SELECT INFO LABEL
         */
        var current_value=0;
        var current_index=0;
        var div_info = document.createElement('div');
            div_info.classList.add('w-100','mt-1','mb-0');
        var p_info = document.createElement('p');
            p_info.classList.add('text-info','mb-0','mt-0');
        var text_info = document.createTextNode('Wskaż ilość kolumn:');
            p_info.append(text_info);
            div_info.append(p_info);
        /*
         * SELECT INPUT
         */    
        var div_select = document.createElement('div');
            div_select.classList.add('w-100','mb-1');
        var select =  document.createElement('select');
            select.classList.add('form-control','form-control-sm');
            select.style.cursor='pointer';
        
        /*
         * SELECT INPUT DEFAULT OPTION
         */
        var option_default = self.Html.getOption(self.subsection_counter.toString());
            option_default.classList.add('font-weight-bold','bg-info','text-white');
            option_default.append(document.createTextNode(' (default)'));
            option_default.setAttribute('selected','');
        select.append(option_default);
        
        /*
         * SELECT INPUT OPTION
         */   
            for(var i=self.subsection_min;i<self.subsection_max+1;i++){
                if(i!==self.subsection_counter){
                    var option = self.Html.getOption(i.toString());
                    select.append(option);
                }
                
            }
        /*
         * SELECT INPUT ONCLICK
         */ 
            select.onclick = function(){
                //console.log('Form_stage_create_section.setSubsectionSelect() onclick()');
                current_value=parseInt(this.value,10);
                current_index=this.selectedIndex;
                //console.log("current value - ",current_value);
                //console.log("current index - ",current_index);
            };
        /*
         * SELECT INPUT ONCHANGE
         */ 
            select.onchange = function(){
                try{
                    //console.log('Form_stage_create_section.setSubsectionSelect() onchange()');
                    //console.log("current - ",current_value);
                    var value = parseInt(this.value,10);
                    //console.log("value - ",value);
                    if(current_value>value){
                        if (confirm('Zmniejszyć ilość kolumn?') === true) {
                            self.Html.removeChilds(self.ele.dynamic_fields[id]['body']);
                            self.setFieldBodyColumn(self,id,value);
                        }
                        else{
                            // NO
                            //console.log("reject change");
                            //console.log("value - ",value);
                            this.selectedIndex = current_index;
                            this.value = current_value;
                            //console.log("current value - ",current_value);
                            //console.log("current index - ",current_index);
                        }
                    }
                    else{
                        self.Html.removeChilds(self.ele.dynamic_fields[id]['body']);
                        self.setFieldBodyColumn(self,id,value);
                    }  
                }
                catch(e){
                    console.log('Form_stage_create_section.setSubsectionSelect() onclick() catch()',e);
                    self.setError(self,id,'Section error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            }; 
        /*
         * APPEND
         */
        div_select.append(select);
        ele.append(div_info,div_select);
    }
    setErrorField(){
        var row = this.Html.getRow();
            row.classList.add('mt-1');
            row.setAttribute('id',this.uniqid+'section_error_field');
        var col=this.Html.getCol(12);
            this.ele.error = document.createElement('div');
            col.appendChild(this.ele.error);
            row.append(col);
        this.ele.main.append(row);
    }
    setMainEle(ele){
        console.log('Form_stage_create_section.setMainEle()');
        console.log(ele);
        this.ele.main = ele;
    }
    get(){
        return this.ele;
    }
    set(ele){
        /*
         * RESET FIELD COUNTER
         */
        this.section_counter = 0;
        /*
         * RESET Subsection object
         */
        this.Subsection = new Object();
        /*
         * RESET FIELD SUBSETION DEFAULT COUNTER
         */
        //this.subsection_counter = 2;
        
        this.setMainEle(ele);
        this.setDynamicField();
        this.setActionField();
        this.setErrorField();       
        this.get();
    }
    setError(self,code,msg){
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
        console.log('Form_stage_create_section.checkErrors()');
        try{
            if(self.ErrorStack.check()){
                console.log('Form_stage_create_section.checkErrors() errors exists');
                this.ele.error.classList.add('alert','alert-danger');
                this.ele.error.setAttribute('role','alert');
                self.Html.removeChilds(self.ele.error);
                self.ele.error.innerHTML = self.ErrorStack.getHtmlWithMask(self.uniqid);
            }
            else{
                console.log('Form_stage_create_section.checkErrors() no errors');
                self.ele.error.classList.remove('alert','alert-danger');
                self.ele.error.removeAttribute('role');
                self.Html.removeChilds(self.ele.error);
            }
        }
        catch(e){
            console.log('Form_stage_create_section.checkErrors()',e);
            alert('Application error occurred! Contact with Administrator!');
        }  
    }
}