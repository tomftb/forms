class Form_stage{

    router='';
    appUrl='';
    Xhr = new Object();
    Form_stage_list = new Object();
    Form_stage_create = new Object();
    Form_stage_show = new Object();
    Form_stage_remove = new Object();
    Form_stage_hide = new Object();
    Parse = new Object();
    response;

    constructor(app_url,router){
        console.log('Form_stage.constructor()'); 
        this.appUrl=app_url; 
        this.router=router;
        this.Xhr=new Xhr2();
        this.Parse=new Parse();
        /*
         * FORM STAGE TABLE
         */
        this.Form_stage_list = new Form_stage_list(app_url,router);
        /*
         * FORM STAGE MODAL
         */
        this.Form_stage_create=new Form_stage_create(router,app_url,this.Form_stage_list); 
        /*
         * 
         * FORM STAGE REMOVE
         */
        this.Form_stage_remove = new Form_stage_remove(router,app_url,this.Form_stage_list); 
        /*
         * 
         * FORM STAGE HIDE
         */
        this.Form_stage_hide = new Form_stage_hide(router,app_url,this.Form_stage_list); 
    }
    loadDefaultList(){
        console.log('Form_stage.loadDefaultList()');
        /*
         *  INITIALISE PARENT MODAL LINKS
         */
        this.Form_stage_create.init();
        //this.Form_stage_show.init();
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
                    u:this.router+'getFormStageDefaults',
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
             * SET USER DATA
             */
            this.Form_stage_create.setProperty(this.response);
            //this.Form_stage_show.setProperty(this.response);
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
    showStage(response){
        console.clear();
        console.log('Form_stage.showStage()');  
        //console.log(response);
        /*
         * FORM STAGE MODAL
         */
        this.Form_stage_create.show(response);
    }
    editStage(response){
        console.log('Form_stage.editStage()');  
        console.log(response);
        
    }
    removeStage(response){
        console.log('Form_stage.removeStage()');  
        //console.log(response);
        try{            
            this.Form_stage_remove.init(); 
            this.Form_stage_remove.remove(response);
        }
        catch(e){
            console.error("Form_stage.removeStage()",e);
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
        }
    }
    hideStage(response){
        console.log('Form_stage.hideStage()');  
        console.log(response);
        try{
            this.Form_stage_hide.init(); 
            this.Form_stage_hide.hide(response);
        }
        catch(e){
            console.error("Form_stage.hideStage()",e);
            this.Form_stage_list.setError('Application error occurred! Contact with Administrator!');
        }
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