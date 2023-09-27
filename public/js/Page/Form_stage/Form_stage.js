class Form_stage{

    router='';
    appUrl='';
    Xhr = new Object();
    Form_stage_list = new Object();
    Form_stage_create = new Object();
    Department = new Object();
    Parse = new Object();
    response;

    constructor(app_url,router){
        console.log('Form_stage.constructor()'); 
        this.appUrl=app_url; 
        this.router=router;
        this.Xhr=new Xhr2();
        this.Department=new Department();
        this.Parse=new Parse();
        /*
         * FORM STAGE TABLE
         */
        this.Form_stage_list = new Form_stage_list(app_url,router);
        /*
         * FORM STAGE MODAL
         */
        this.Form_stage_create=new Form_stage_create(router,app_url,this.Form_stage_list); 
    }
    loadDefaultList(){
        console.log('Form_stage.loadDefaultList()');
        /*
         *  INITIALISE PARENT MODAL LINKS
         */
        this.Form_stage_create.init();
        /*
         * INITIALISE PARENT TABLE LINKS
         */
        this.Form_stage_list.init(); 
        this.Form_stage_list.setParent(this); 
        /*
         * SET TABLE LIST HEAD */
        this.Form_stage_list.setHead();
        /*
         * SET XHR ERROR
         */
        this.Xhr.setOnError({
            'o':this.Form_stage_list
            ,'m':'setError'
        }); 
        /*
         * RUN XHR
         */
        this.Xhr.run({
                    t:'GET',
                    u:self.router+'getFormStageDefaults',
                    c:true,
                    d:null,
                    o:this,
                    m:'setProperties'
        });
    }
    setProperties(response){
        console.log('Form_stage.setProperties()');
        try{
            this.response = this.Parse.getSimpleJson(response);
            console.log(this.response);
            /*
             * SET PERMISSIONS
             */
            this.Form_stage_list.setPermissions(this.response.user.perm);
            /*
             * SET TABLE BODY
             */            
            this.Form_stage_list.setBody(this.response.list);
            /*
             * SET DEPARTMENT - TURN OFF
             */
            /*
             * SET USER DATA
             */
            this.Form_stage_create.setProperty(this.response);
             //this.Form_stage_create.setDepartmentList(this.response.department);
        }
        catch (error){
            console.log(error);
            /*
             * SET TABLE ERROR HEAD
             */
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
        }
    }
    setShowStagesButton(ele){
        console.log('Form_stage.setShowStagesButton()');  
        //console.log(ele);
        var self=this;
        ele.onclick = function(){
            console.log(self);
            self.Form_stage_list.get(self);
        };
    }
    setAddStageButton(ele){
        console.log('Form_stage.setAddStageButton()');  
        //console.log(ele);
        var self=this;
            ele.onclick = function(){
                try{
                    console.log('Form_stage.setAddStageButton().onclick()');  
                    console.log(self.router);
                    console.log(self.Form_stage_create);
                    self.Xhr.run({
                        t:'GET',
                        u:self.router+'getFormStageCreate',
                        c:true,
                        d:null,
                        o:self.Form_stage_create,
                        m:'create'
                    });
                }
                catch (error){
                    console.log(error);
                    self.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
                }
            };
    }
    setFilterStagesButton(ele){
        console.log('Form_stage.setFilterStagesButton()');  
        //console.log(ele);
        var self=this;
        ele.onclick = function(){
            console.log(self);
        };
    }
    editStage(response){
        console.log('Form_stage.editStage()');  
        console.log(response);
    }
    removeStage(response){
        console.log('Form_stage.removeStage()');  
        console.log(response);
    }
    hideStage(response){
        console.log('Form_stage.hideStage()');  
        console.log(response);
    }
}
/*
 * LOAD
 */
try{
   var FormStage = new Form_stage(window.appUrl,window.appUrl+'/router.php?task=');
        window.addEventListener('load', function(){
            console.log('page is fully loaded');
            try{
                FormStage.loadDefaultList();
                FormStage.setShowStagesButton(document.getElementById("showStages"));
                FormStage.setAddStageButton(document.getElementById("addStage"));
                FormStage.setFilterStagesButton(document.getElementById("filterStages"));
            }
            catch (error){
                console.log(error);
                alert('Form_stage.load() Error occured!');
            }
        },false);
        window.addEventListener('resize', function(event) {/* TO DO */
            //console.log('Window resize',event);
           // console.log(window.innerWidth,window.innerHeight);
        }, true);
}
catch (e){
    console.log(e);
    alert('Something went wrong! Contact with administrator!');    
}