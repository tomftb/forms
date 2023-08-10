class Error
{
    error=true;
    div='';
    divId='';
    action = 'throwNoError';
    msg='Application error occurred!';
    //static action = 'throwError';
    constructor() {
        console.log('Error::constructor()');
    }
    throwNoError(){
        console.log('Error.throwNoError()');
    }
    throwError(){
        console.log('Error.throwError()');
        throw this.msg;
    }
    checkStatusExist(d){
        console.log('Error.checkStatusExist()');
        if (!d.hasOwnProperty("status")) {
            throw 'Key `status` not exist';
        }
    }
    checkStatusResponse(d){
        console.log('Error.checkStatusResponse()');
        /*
         * d => data
         * d['status'] => status
         */
        //console.log(this);
        //console.log(typeof(d['status']));
        this.msg='Application error occurred!';
        if (d.hasOwnProperty("info")) {
            this.msg=d['info'];
        }
        if(d['status']===1){
            this.show();
            this.error=true;
            this[this.action]();
        }
        else if(d['status']===0){
            this.clear();
            this.error=false;
        }
        else{
            console.log('Error.checkStatusResponse()\nwrong status:\n',d['status']);
            this.show('Application error occurred!');
            this.error=true;
            this[this.action]();
        }
        return this.error;
    }
    checkInfoResponse = function (d)
    {
        console.log('Error::checkInfoResponse()');
        if(d['info']==='undefined')
        {
            console.log('Error::checkInfoResponse() => wrong info => '+d['info']);
            alert('Error::ERROR OCCURED!');
        }
        else if(d['info']==='')
        {
            /*
             * check type if POST, close modal, if get do nothing
             */
            console.log('INFO EMPTY'); 
        }
        else
        {
            console.log(d['info']);
            //Error.parseType(d);
        }
    }
    clearError = function (){
        this.error=false;
    }
    set(id){
        console.log('Error::set(id)');
        this.divId=id;
        //console.log(Error.divId);
    }
    show(){
        console.log('Error::show(value)');
        console.log(this.msg);
        /* TO DO -> create virtual div*/
        this.getDiv();
        //console.log(Error.div);
        this.div.innerHTML=this.msg;
        this.div.classList.remove("d-none");
        this.div.classList.add("d-block");
    }
    clear = function (){
        console.log('Error::clear()');
        this.getDiv();
        this.div.innerText='';
        this.div.classList.add("d-none");
        this.div.classList.remove("d-block");
    }
    getDiv(){
        this.div=document.getElementById(this.divId);
        //console.log(Error.div);
    }
    setField(field){
        console.log('Error.setField()');
        //console.log(field);
        this.div=field;
    }
}

