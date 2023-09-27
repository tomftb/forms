class Form_stage_create_department{    
    Html = new Object();
    Prototype = new Object();
    ele = new Object();
    select = new Object();
    value = "";

    title = new Object();
    help = new Object();
    error = new Object();

    uniqid = '';
    type='department';
    department_list=new Array();
    runError = 'setError';
    
    constructor(Parent,ele,department_list){
        try{
            console.log('Form_stage_create_department.construct()');
            this.Parent = Parent;
            this.department_list=department_list;
            /*
             * Prototype
             */
            this.Prototype = new Form_stage_prototype(Parent,ele);
            this.Html=new Html();
            this.Prototype.unsetBorder();
            this.Prototype.setUniqid(this.type);
            this.Prototype.setFields();
            this.setInput();
            /*
             * RUN ERROR IF EXSITS
             */
            this[this.runError]();
            this.Prototype.checkErrors(this.Prototype);
        }
        catch(e){
            console.log('Form_stage_create_department.construct() catch()',e);
        }
    }
    getValue(){
        return this.select.value;
    }
    getName(){
        console.log(this.department_list,this.select.value);
        for (const prop in this.department_list){
            if(this.department_list[prop].i===this.select.value){
                return this.department_list[prop].n;
                break;
            }
        }
        console.log("Department `"+this.select.value+"` not found!");
        throw 'Application error occurred! Contact with Administrator!';
    }
    setInput(){
        console.log('Form_stage_create_department.setInput()');
        var row=this.Html.getRow();
        var col_1=this.Html.getCol(1);
        var col_2=this.Html.getCol(11);
            col_1.appendChild(this.getTitleField());
            col_2.appendChild(this.getInputField());
            row.append(col_1,col_2);
            console.log(this.Prototype.ele);
        this.Prototype.ele.input.append(row);
        this.setHelpField();
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
                option.innerText=this.department_list[prop].n;//assignDataToField(d[property],n);
                option.setAttribute("value",this.department_list[prop].i);
                this.select.appendChild(option);
                this.runError='noError';
        }
        return  this.select;
    }
    setHelpField(){
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
    setError(){
        console.log('Form_stage_create_department.setError()'); 
        this.Prototype.setError(this.Prototype,'_notselected','Użytkownik nie jest przypisany do żadnego działu.');
        this.title.classList.remove('text-dark');
        this.title.classList.add('text-danger');
        this.select.classList.add('border-danger');
    }
    noError(){
        console.log('Form_stage_create_department.noError()'); 
        this.Prototype.unsetError(this.Prototype,'_notselected');
        this.title.classList.remove('text-danger');
        this.title.classList.add('text-dark');
        this.select.classList.remove('border-danger');
    }
}