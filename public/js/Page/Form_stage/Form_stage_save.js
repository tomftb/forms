class Form_stage_save{
    
    Parent = new Object();

    constructor(Parent){
        console.log('Form_stage_save.construct()');
        //console.log(Parent);
        //console.log(Parent.FormData);
        this.Parent = Parent;
        try{
            var fd = new FormData();
                fd.append('data',JSON.stringify(Parent.FormData));
                //console.log(fd);
            this.save(fd);
        }
        catch(e){
            console.log("Form_stage_save.construct() catch()",e);
            this.Parent.setError('Application error occurred! Contact with Administrator!');
        }
    }
    save(fd){
        console.log('Form_stage_save.save()');
        //console.log(fd);
        this.Parent.Xhr.setOnError({'o':this.Parent,m:'setError'});
        //console.log(this.Parent);
        //return true;
        /*
         * RUN XHR
         */
        this.Parent.Xhr.run({
                    t:'POST'
                    ,u:this.Parent.router+'saveFormStage'
                    ,c:true
                    ,d:fd
                    ,o:this
                    ,m:'updateData'
        });
    }
    updateData(response){
        console.log('Form_stage_save.updateData()');
        console.log(response);
        try {
            /*
             * PARSE RESPONSE
             */
            this.response = this.Parent.Parse.getSimpleJson(response);
                console.log(this.response);
                this.Parent.updateData(this.response);
                this.Parent.setSuccess('Zapis się powiódł');
        }
        catch (e) {
            console.error("Form_stage_save.updateData() response catch()\r\n",e);
            this.Parent.setError(e);
            //this.Parent.setError('Application error occurred! Contact with Administrator!');
            return false;
        }
        try{
            /*
             * UPDATE FORM DATA
             */
        }
        catch(e){
            console.log('Form_stage_save.updateData() update catch()',e);
            this.Parent.setError('Application error occurred! Contact with Administrator!');
            return false;
        }
    }
}