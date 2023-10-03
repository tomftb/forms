class Form_stage_department{    
    Html = new Object();
    Prototype = new Object();
    ele = new Object();
    select = new Object();
    value = "";

    title = new Object();
    help = new Object();
    error = new Object();
    input = new Object();
    
    uniqid = '';
    type='department';
    department_list=new Array();
    runError = 'setError';
    Utilities = new Object();
    /*
     * FORM STAGE DEPARTMENT ID
     */
    department_id=0;
    
    constructor(Parent,ele){
        try{
            console.log("Form_stage_department.construct()");
            this.Parent = Parent;
            /*
             * Prototype
             */
            this.Prototype = new Form_stage_prototype(Parent,ele);
            this.Html=new Html();
            this.Prototype.unsetBorder();
            this.Prototype.setUniqid(this.type);
            this.Prototype.setFields();
            this.Utilities = new Utilities();
        }
        catch(e){
            console.error("Form_stage_department.construct() catch()\r\n",e);
            Parent.setError(e);
        }
    }
    setDepartmentList(department_list){
        this.department_list=department_list;
    }
    addStageDepartment(department_id,department_name){
        console.log("Form_stage_department.addStageDepartment()");
        console.log(this.department_list,department_id,department_name);
        this.department_id=department_id;
        if(!this.department_list.hasOwnProperty(department_id)){
            this.Parent.setError('Brak uprawnienia zmiany etapu dla działu `'+department_name+'`!');
            return false;
        }
        if(this.department_list[department_id]!==department_name){
            this.department_list[department_id]+=" ("+department_name+")";
            return true;
        }
    }
    getValue(){
        console.log("Form_stage_department.getValue()\r\n",this.select.value);
        return this.select.value;
    }
    getName(){
        console.log("Form_stage_department.getName()\r\n",this.department_list[this.select.value]);   
        return this.department_list[this.select.value];
    }
    set(){
         console.log("Form_stage_department.set()");
        try{
            this.setInput();
        }
        catch(e){
            console.error("Form_stage_department.set()\r\n",e);
            this.Parent.setError('Application error occurred! Contact with Administrator!');
        }
        try{
            this.setInputData();
            /*
             * RUN ERROR IF EXSITS
             */
            this[this.runError]('Użytkownik nie jest przypisany do żadnego działu.');
            this.Prototype.checkErrors(this.Prototype);
        }
        catch(e){
            console.error("Form_stage_department.set() catch()\r\n",e);
            this.setError(e);
        }
    }
    setInput(){
        console.log('Form_stage_department.setInput()');
        var row=this.Html.getRow();
        var col_1=this.Html.getCol(1);
        var col_2=this.Html.getCol(11);
            row.append(col_1,col_2);
            this.input = row;
        this.Prototype.ele.input.append(row);
        this.setHelpField();
    }
    setInputData(){
        console.log('Form_stage_department.setInputData()');
        this.input.childNodes[0].appendChild(this.getTitleField());
        this.input.childNodes[1].appendChild(this.getInputField());
    }
    getTitleField(){
        var text=document.createTextNode('Dział:');
            this.title=document.createElement('h3');
            this.title.classList.add('text-center','font-weight-bold','text-dark');//text-danger
            this.title.appendChild(text);
        return this.title;
    }
    getInputField(){
        this.select = this.Html.select('form-control','department');
        this.select.setAttribute('aria-label',"Department select" );
        this.runError='setError';//noError
        for (const prop in this.department_list){
            var option=document.createElement('option');  
                option.append(document.createTextNode(this.department_list[prop]));
                option.value=prop;
                if(prop===this.department_id){
                    option.setAttribute('selected','');
                }
                this.select.appendChild(option);
                this.runError='noError';
        }
        return this.select;
    }
    setHelpField(){
        console.log("Form_stage_department.setHelpField()\r\n"); 
        var row=this.Html.getRow();
        var col_1=this.Html.getCol(1);
        var col_2=this.Html.getCol(11);
        var text=document.createTextNode('Wskaż dział z listy.');     
            this.help=document.createElement('small');
            this.help.setAttribute('id','departmentHelp');
            this.help.classList.add('form-text','text-muted');
            this.help.appendChild(text);
            col_2.appendChild(this.help);
            row.append(col_1,col_2); 
        this.Prototype.ele.input.append(row);
    }
    setError(msg){
        console.log("Form_stage_department.setError()\r\n", this.title,"\r\n",this.select); 
        this.Prototype.setError(this.Prototype,'_notselected',msg);
        this.title.classList.remove('text-dark');
        this.title.classList.add('text-danger');
        this.select.classList.add('border-danger');
        //this.Prototype.checkErrors();
    }
    noError(msg){
        console.log('Form_stage_department.noError()'); 
        this.Prototype.unsetError(this.Prototype,'_notselected');
        this.title.classList.remove('text-danger');
        this.title.classList.add('text-dark');
        this.select.classList.remove('border-danger');
    }
}