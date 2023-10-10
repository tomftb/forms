class Form_stage_section{

    Html = new Object();
    Utilites = new Object();
    ErrorStack = new Object();
    id_db = 0;
    subsection_min = 1;
    subsection_max = 12;
    subsection_counter = 1;
    section_counter = 0;
    uniqid = '';
    subsection_fields;
    ele = {
        'parent':new Object()
        ,'main':new Object()
        ,'dynamic':new Object()
        ,'body':new Object()
        ,'footer':new Object()
    };
    Subsection = new Object();

    parameters = new Object();
    glossary = new Object();
    column_count = 1;
    column_size = 1;
    tmp_column_size = 1;
    rest_column_size = 0;
    
    constructor(parent_ele,glossary,ErrorStack,parameters){
        console.log('Form_stage_section.constructor()');
        this.parameters = parameters;
        this.glossary = glossary;
        //console.log(this.glossary);
        this.senUniqid(); 
        this.Html = new Html();
        this.Utilities = new Utilities();
        this.ErrorStack = ErrorStack;
        this.ele.parent = parent_ele;
        /*
         * SET Dynamic Main Field
         */
        this.setDynamic();
        this.setMain();

        //this.setSubsectionCounter(parameters);
        //console.log(this.ele.parent);
        //console.log(this.Subsection);
    }
    set(section_counter,subsection_counter){
        this.section_counter = section_counter;
        this.subsection_counter = subsection_counter;
        this.setSectionProperties();
        this.setBodyColumn(this,this.subsection_counter);
    }
    setWithData(section_counter,StageDataSection){
        console.log("Form_stage_section.setWithData()StageDataSection:\r\n",section_counter,StageDataSection);
        this.section_counter = section_counter;
        this.id_db = parseInt(StageDataSection.id_db,10);
        this.Utilities.propertyExists(StageDataSection,'id_db','Object `StageDataSection` doesn\'t have `id_db` property!');
        this.Utilities.propertyExists(StageDataSection,'subsection','Object `StageDataSection` doesn\'t have `subsection` property!');
        this.subsection_counter = this.Utilities.countObjectProp(StageDataSection.subsection);//StageDataSection.subsection.length;
        this.checkSubsectionCounter();
        this.setSectionProperties();
        this.setBodyColumnWithData(StageDataSection.subsection);
    }
    setSectionProperties(){
        console.log('Form_stage_section.setSectionProperties()');
        /*
         * SET HEAD OPTION BODY AND FOOTER FILED
         */
        this.setTitle();
        this.setHead();
        this.setBody();
        this.setFooter();
    }
    checkSubsectionCounter(){
        console.log("Form_stage_section.setWithData() subsection length - ",this.subsection_counter);       
        if(this.subsection_counter<1){
            throw 'Subsection counter `'+this.subsection_counter+'` is less than 1!';
        }
        if(this.subsection_counter>12){
            throw 'Subsection counter `'+this.subsection_counter+'` is greater than 12!';
        }
    }
    senUniqid(){
        console.log('Form_stage_section.setUniqid()');
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_section";
        console.log(this.uniqid);
    }
    setDynamic(){
        console.log('Form_stage_section.setDynamic()');
        var col = this.Html.getCol(12);
            col.setAttribute('id',this.uniqid+'_dynamic');   
            this.ele.dynamic = col;
    }
    setMain(){
        console.log('Form_stage_section.setMain()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'_main');   
            this.ele.main = row;
            this.ele.main.append(this.ele.dynamic);
            this.ele.parent.append(this.ele.main);
    }
    setTitle(){
        console.log('Form_stage_section.setTitle()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'_title');
        var col=this.Html.getCol(12);
        var hr = document.createElement('hr');
            hr.classList.add('w-100','border-1','border-secondary','mt-2');
        var h = document.createElement('h3');
            h.classList.add('w-100','text-center','bg-info','text-white');
        var text = document.createTextNode('Wiersz nr '+this.section_counter);
            h.append(text);
            col.append(hr,h);
            row.append(col);
            this.ele.dynamic.append(row);
    }
    setHead(){
        console.log('Form_stage_section.setHead()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+"_head");
        var col_1=this.Html.getCol(3);
        var col_2=this.Html.getCol(3);
        var col_3=this.Html.getCol(3);
        var col_4=this.Html.getCol(3);
            this.setColumnSelector(col_1);
            this.setRemoveSection(col_4);
            row.append(col_1,col_2,col_3,col_4);
            this.ele.dynamic.append(row);
    }
    setBody(){
        console.log('Form_stage_section.setBody()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+"_body");
            this.ele.body=row;
            this.ele.dynamic.append(row);
    }
    setFooter(){
        console.log('Form_stage_section.setFooter()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+"_footer");
        var col=this.Html.getCol(12);
            row.append(col);
            this.ele.footer=col;
            this.ele.dynamic.append(row);
    }
    setColumnSelector(ele){
        console.log('Form_stage_section.setColumnSelector()');
        /*
         * SELECT INFO LABEL
         */
        var self = this;
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
                //console.log('Form_stage_section.setSubsectionSelect() onclick()');
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
                    //console.log('Form_stage_section.setSubsectionSelect() onchange()');
                    //console.log("current - ",current_value);
                    var value = parseInt(this.value,10);
                    //console.log("value - ",value);
                    if(current_value>value){
                        if (confirm('Zmniejszyć ilość kolumn?') === true) {
                                self.Html.removeChilds(self.ele.body);
                                /*
                                * CLEAR
                                */
                                self.Subsection = new Object();
                                self.setBodyColumn(self,value);
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
                        self.Html.removeChilds(self.ele.body);
                         /*
                        * CLEAR
                        */
                        self.Subsection = new Object();
                        self.setBodyColumn(self,value);
                    }  
                }
                catch(e){
                    console.log('Form_stage_section.setSubsectionSelect() onclick() catch()',e);
                    self.setError(self,'Section error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            }; 
        /*
         * APPEND
         */
        div_select.append(select);
        ele.append(div_info,div_select);
    }
    setRemoveSection(ele){
        console.log('Form_stage_section.setRemoveSection()');
        var self = this;
        var button = this.Html.getButton('Usuń wiersz',['btn','btn-danger']);
            button.classList.add('float-right');
            button.onclick=function(){
                console.log('Form_stage_section.setRemoveSection() onclick()');
                /*
                 * CLOSURE
                 */
                try{
                    if (confirm('Potwierdź usunięcie wiersza') === true) {
                        /*
                         * REMOVE FIELDS
                         */
                        self.ele.main.remove();                        
                        /*
                         * REMOVE Subsection object
                         */
                        self.Subsection = new Object();
                    }
                    //console.log(self.Section[id]);
                }
                catch(e){
                    console.log('Form_stage_create_section.getRemoveButton() onclick() catch()',e);
                    self.setError(self,'Section error has occured! Contact with Administrator!');
                }
            };
        ele.append(button);
    }
    setBodyColumnWithData(StageDataSubsection){
        console.log('Form_stage_section.setBodyColumnWitData()');
        //console.log(StageDataSubsection);
        var length = this.Utilities.countObjectProp(StageDataSubsection);//StageDataSubsection.length
        this.setBodyColumnCount(this,length);
        this.setBodyColumnSize(this,length);
        var column_size = 1;
        var i=1;
        for(const prop in StageDataSubsection){
            column_size = this.getBodyColumnSize(this);
            var col=this.Html.getCol(column_size);
            //console.log(StageDataSubsection[prop]);
            this.Utilities.propertyExists(StageDataSubsection[prop],'id_db','Object `StageDataSubsection[prop]` dosn\'t have `id_db` property!');
            this.Utilities.propertyExists(StageDataSubsection[prop],'row','Object `StageDataSubsection[prop]` dosn\'t have `row` property!');
            this.Subsection[prop] = new Form_stage_create_subsection(this,col,column_size,this.glossary);
            this.Subsection[prop].setWithData(StageDataSubsection[prop]);
            this.ele.body.append(col);
            i++;
        }
    }
    setBodyColumn(self,current){
        console.log('Form_stage_section.setBodyColumn()');
        self.setBodyColumnCount(self,current);
        self.setBodyColumnSize(self,current);
        var column_size = 1;
        /*
         * DEFAULT COLUMN
         */
        for(var i=1; i<self.column_count+1;i++){
            column_size = self.getBodyColumnSize(self);
            var col=self.Html.getCol(column_size);
            self.Subsection[i] = new Form_stage_create_subsection(self,col,column_size,self.glossary);
            self.Subsection[i].setWithoutData();
            /*
             * PREPEND / APPEND
             */
            //self.ele.dynamic_fields[id]['body'].prepend(col);
            self.ele.body.append(col);
        }
    }
    setBodyColumnCount(self,current){
        self.column_count = Math.round(current);
        if(self.column_count>self.subsection_max){
            console.log('Form_stage_section.setBodyColumn() EXCEPTION MAX');
            self.column_count = self.subsection_max;
        }
        if(self.column_count<self.subsection_min){
            console.log('Form_stage_section.setBodyColumn() EXCEPTION MIN');
            self.column_count = self.subsection_min;
        }
    }
    setBodyColumnSize(self,current){
          /*
         * MAX BOOTSTRAP COLUMN EQUAL 12
         */
        self.column_size = Math.floor(self.subsection_max/current);//round
        self.tmp_column_size = self.column_size;
        self.rest_column_size = self.subsection_max - (self.column_size*self.column_count);
    }
    getBodyColumnSize(self){
        self.tmp_column_size=self.column_size;
        if(self.rest_column_size>0){
            self.tmp_column_size+=1;
            self.rest_column_size--;
        }
        return self.tmp_column_size;
    }
    setError(self,code,msg){
        console.log('Form_stage_section.setError()');
        /*
         * ADD to ErrorStack
         */
        //self.ErrorStack.add(self.uniqid+code,msg);
        self.ele.footer.classList.add('alert','alert-danger');
        self.ele.footer.setAttribute('role','alert');
        self.Html.removeChilds(self.ele.footer);
        self.ele.footer.append(document.createTextNode(msg));
    }
    getData(){
        console.log('Form_stage_section.getData()');
        var data = new Object();
        for(const prop in this.Subsection){
                data[prop]={
                    'id_db':this.Subsection[prop].getIdDb()
                    ,'row':this.Subsection[prop].getData()
                };
        }
        return data;
    }
    setIdDb(data){
        console.log('Form_stage_section.setId()');
        console.log('NEW DATA',data);
        console.log('PRESENT DATA',this.Subsection);
        
    }
    updateIdDb(data){
        console.log('Form_stage_section.updateIdDb()');
        console.log(data);
        this.id_db = data.id_db;
        /*
         * UPDATE SUBSECTION
         */
        for(const prop in data.subsection){
            this.Subsection[prop].updateIdDb(data.subsection[prop]);
        }
    }
    getIdDb(){
        return this.id_db;
    }
}