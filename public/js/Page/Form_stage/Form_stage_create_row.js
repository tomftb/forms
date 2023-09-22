/*
 * 
 * NOT USED
 */

class Form_stage_create_row{  
    Html = new Object();
    ErrorStack = new Object();
    /*
     * REFERENCES TO ELEMENTS
     */
    ele={
        'main':new Object()
        ,'error':new Object()
    }    
    uniqid = '';

    constructor(Parent){
        try{
            console.log('Form_stage_create_row.construct()');
            this.Html=new Html();
            /*
             * PARENT EXTENDS MODAL
             */
            this.Parent = Parent;
            this.ErrorStack = Parent.ErrorStack;
            this.setUniqid();  
        }
        catch(e){
            console.log('Form_stage_create_row.construct() catch()',e);
            alert('Application error occurred! Contact with Administrator!');
        }
    }
    setValue(value){
        this.value=value;
    }
    setUniqid(){
        this.uniqid=Math.floor(Math.random() * 1000000).toString()+"_";
        console.log(this.uniqid);
    }
    setErrorField(){
        var row = this.Html.getRow();
            row.classList.add('mt-1');
            row.setAttribute('id',this.uniqid+'row_error_field');
        var col=this.Html.getCol(12);
            this.ele.error = document.createElement('div');
            col.appendChild(this.ele.error);
            row.append(col);
        this.ele.main.append(row);
    }
    setMainEle(ele){
        console.log('Form_stage_create_row.setMainEle()');
        console.log(ele);
        this.ele.main = ele;
    }
    get(){
        return this.ele;
    }
    set(ele){        
        this.setMainEle(ele);
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
        console.log('Form_stage_create_row.checkErrors()');
        try{
            if(self.ErrorStack.check()){
                console.log('Form_stage_create_row.checkErrors() errors exists');
                this.ele.error.classList.add('alert','alert-danger');
                this.ele.error.setAttribute('role','alert');
                self.Html.removeChilds(self.ele.error);
                self.ele.error.innerHTML = self.ErrorStack.getHtmlWithMask(self.uniqid);
            }
            else{
                console.log('Form_stage_create_row.checkErrors() no errors');
                self.ele.error.classList.remove('alert','alert-danger');
                self.ele.error.removeAttribute('role');
                self.Html.removeChilds(self.ele.error);
            }
        }
        catch(e){
            console.log('Form_stage_create_row.checkErrors()',e);
            alert('Application error occurred! Contact with Administrator!');
        }  
    }
}
/*
 * T,I,S
 */