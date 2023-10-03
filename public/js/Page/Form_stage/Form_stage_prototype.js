class Form_stage_prototype{  
    Html = new Object();
    ErrorStack = new Object();
    Utilities = new Object();
    /*
     * REFERENCES TO ELEMENTS
     */
    main = new Object()
    ele={
        'all_row':new Object()
        ,'all_col':new Object()
        ,'header':new Object()
        ,'options':new Object()
        ,'input':new Object()
        ,'error':new Object()
    }    
    uniqid = '';
    counter = 0;
    title='text';
    remove_title='Potwierdź usunięcie pola tekstowego';
    border={
      'set':'addBorder'
      ,'value':'border-primary'
    };
    data_row = {
        0:new Object()
    };
    data_row_id = 0;
        
    constructor(Parent,main_ele){
        try{
            //console.log('Form_stage_prototype.construct()');
            this.Html=new Html();
            this.Utilities=new Utilities();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            /*
             * MAIN ELE
             */
            this.main = main_ele;
        }
        catch(e){
            console.log('Form_stage_prototype.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setValue(value){
        this.value=value;
    }
    setUniqid(sufix){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_"+sufix;
        console.log(this.uniqid);
    }
    getUniqid(){
        return this.uniqid;
    }
    setBorder(border){
        this.border.value=border;
    }
    unsetBorder(){
        this.border.set='noBorder';
    }
    addBorder(row){
         row.classList.add('border','mb-1',this.border.value);
    }
    noBorder(row){
        //no border
    }
    setTitle(title){
        this.title=title;
    }
    setRemoveTitle(title){
        this.remove_title=title;
    }
    setAllField(){
        var row=this.Html.getRow();
            //row.classList.add('border','mb-1');
            row.setAttribute('id',this.uniqid+'_all_field');
            /*
             * SET BORDER
             */
            this[this.border.set](row);
        var col=this.Html.getCol(12); 
            row.appendChild(col);
            this.ele.all_row=row;
            this.ele.all_col=col;
            this.main.append(row);
    }
    setErrorField(){
        var row = this.Html.getRow();
            row.classList.add('mt-1');
            row.setAttribute('id',this.uniqid+'_error_field');
        var col=this.Html.getCol(12);
            row.append(col);
            this.ele.error = col;
            this.ele.all_col.append(row);
    }
    setHeaderField(){
        console.log('Form_stage_prototype.setHeaderField()');
        var row=this.Html.getRow();
            row.classList.add('mt-1','mb-1');
            row.setAttribute('id',this.uniqid+'_head_field');
        var col=this.Html.getCol(12);
        var span = document.createElement('span');
            span.classList.add('text-muted','text-left');
            span.append(document.createTextNode(this.title));
            col.append(span);
            row.appendChild(col);
            this.setRemoveButton(col);
            this.ele.header=col;
            this.ele.all_col.prepend(row);
    }
    setInputField(){
        console.log('Form_stage_prototype.setInputField()');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'_input_field');
        var col=this.Html.getCol(12);  
            row.append(col);
            this.ele.input=col;
            this.ele.all_col.append(row);
    }
    setOptionsField(){
        console.log('Form_stage_prototype.setOptionsField() column_size - ');
        var row=this.Html.getRow();
            row.setAttribute('id',this.uniqid+'_options_field');
        var col = this.Html.getCol(12);
            row.append(col);
            this.ele.options=col;
            this.ele.all_col.append(row);
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
        console.log('Form_stage_prototype.checkErrors()');
        try{
            if(self.ErrorStack.check()){
                console.log('Form_stage_prototype.checkErrors() errors exists');
                self.ele.error.classList.add('alert','alert-danger');
                self.ele.error.setAttribute('role','alert');
                self.Html.removeChilds(self.ele.error);
                self.ele.error.innerHTML = self.ErrorStack.getHtmlWithMask(self.uniqid);
            }
            else{
                console.log('Form_stage_prototype.checkErrors() no errors');
                self.ele.error.classList.remove('alert','alert-danger');
                self.ele.error.removeAttribute('role');
                self.Html.removeChilds(self.ele.error);
            }
        }
        catch(e){
            console.log('Form_stage_prototype.checkErrors()',e);
            alert('Application error occurred! Contact with Administrator!');
        }  
    }
    setFields(){
        console.log('Form_stage_prototype.setFields()');        
        this.setAllField();
        this.setInputField();
        this.setOptionsField();
        this.setErrorField();       
    }
    setRemoveButton(ele){
        console.log('Form_stage_prototype.setRemoveButton() uniqid - '+this.uniqid);
        var self = this;
        var i=document.createElement('i');
            i.classList.add('fa','fa-minus');
            i.setAttribute('aria-hidden','true');
            i.style.color='color:#ffffff;';
        
        var button = this.Html.getButton('',['btn','btn-danger','btn-sm']);
            button.classList.add('float-right');
            button.onclick=function(){
                /*
                 * CLOSURE
                 */
                try{
                    if (confirm(self.remove_title) === true) {
                        console.log(self.ele);
                        /*
                         * REMOVE FIELDS
                         */
                        self.ele.all_row.remove();     
                        /*
                         * REMOVE OBJECT DATA ROW
                         */
                        delete self.data_row[self.data_row_id];
                    }
                }
                catch(e){
                    console.log('Form_stage_prototype.setRemoveButton() onclick() catch()',e);
                    self.setError(self,'_rm_onclick','Prototype error has occured! Contact with Administrator!');
                    self.checkErrors(self);
                }
            };
            button.append(i);
            ele.append(button);
    }
    setDataRow(data_row,data_row_id){
        /*
         * FOR REMOVE ELE
         */
        this.data_row = data_row;
        this.data_row_id=data_row_id;
    }
}