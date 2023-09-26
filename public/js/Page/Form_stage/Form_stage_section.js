class Form_stage_section{

    id_db = 0;
    subsection_min = 1;
    subsection_max = 12;
    subsection_counter = 5;
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
    
    constructor(parent_ele,section_counter){
        console.log('Form_stage_section.constructor()');
        this.senUniqid(); 
        this.Html = new Html();
        this.ele.parent = parent_ele;
        this.section_counter = section_counter;
        /*
         * SET Dynamic Main Field
         */
        this.setDynamic();
        this.setMain();
        /*
         * SET HEAD OPTION BODY AND FOOTER FILED
         */
        this.setTitle();
        this.setHead();
        this.setBody();
        this.setFooter();
        console.log(this.ele.parent);
        console.log(this.Subsection);
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
            this.setBodyColumn(this,this.subsection_counter);
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
                        //for(const prop in self.ele.dynamic_fields[id]){
                          //  self.ele.dynamic_fields[id][prop].remove();
                        //}
                        /*
                         * REMOVE OBJECT KEY
                         */
                        //delete self.ele.dynamic_fields[id];
                        
                        /*
                         * REMOVE Section with id
                         */
                         //delete self.Section[id];
                        //console.log(self.Section[id]);
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
    setBodyColumn(self,current){
        console.log('Form_stage_section.setBodyColumn()');
        var total = Math.round(current);
        if(total>self.subsection_max){
            console.log('Form_stage_section.setBodyColumn() EXCEPTION MAX');
            total = self.subsection_max;
        }
        if(total<self.subsection_min){
            console.log('Form_stage_section.setBodyColumn() EXCEPTION MIN');
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
             * CLEAR
             */
            self.Subsection = new Object();
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
                self.Subsection[i] = new Form_stage_create_subsection(self,col,tmp_column_size);
                  //  Form_stage_create_subsection.set(col);
                /*
                 * PREPEND
                 */
                //self.ele.dynamic_fields[id]['body'].prepend(col);
                /*
                 * 
                 * APPEND
                 */
                self.ele.body.append(col);
            }
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