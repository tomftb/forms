class Modal{
    link={
        'head':'',
        'body':'',
        'error':'',
        'footer':'',
        'adapted':'',
        'form':'',
        'main':'',
        'button':'',
        'buttonConfirm':'',
        'extra':'',
        'info':'',
        'close':''
    }
    Html;
    loadNotify='';
    exist = false;
    constructor() {
        //console.log('Modal::construct()'); 
        this.Html = new Html();
    }
    getModal(){
        //console.log('Modal::getModal()'); 
        //console.log(document.getElementById('AdaptedModal'));
        this.link['main'] = document.getElementById('AdaptedModal');
        //console.log( this.link['main']);
        if( this.link['main']!==null && this.link['main']!==undefined){
            //console.log('set true');
            this.exist=true;
        }
        else{
            //console.log('set false');
            this.exist=false;
        }
    }
    closeModal(){
        window.onbeforeunload = null;
        this.unsetExitKeys();
        $(this.link['main']).modal('hide');
        this.clearData();
    }
    /*
     * initialise
     * @returns void
     */
    init(){
        console.log('Modal.init()');
        this.setLink();
    }
    setLink(){
        console.log('Modal::setLink()');
        this.getModal();
        console.log(this.link['main']);
        if(!this.exist){ return false; };
        this.link['head']=this.link['main'].childNodes[0].childNodes[0].childNodes[0]; 
        this.link['body']=this.link['main'].childNodes[0].childNodes[0].childNodes[1];
        this.link['error']=this.link['main'].childNodes[0].childNodes[0].childNodes[1].childNodes[3];
        this.link['adapted']=this.link['main'].childNodes[0].childNodes[0].childNodes[1].childNodes[1].childNodes[0];
        this.link['button']=this.link['main'].childNodes[0].childNodes[0].childNodes[1].childNodes[2].childNodes[0].childNodes[0];
        this.link['extra']=this.link['main'].childNodes[0].childNodes[0].childNodes[1].childNodes[4];
        this.link['info']=this.link['main'].childNodes[0].childNodes[0].childNodes[2].childNodes[0];
        this.link['close']=this.link['main'].childNodes[0].childNodes[0].childNodes[0].childNodes[1].childNodes[0];
        /* 
        console.log(this.link['main']);
        console.log(this.link['close']);
        */
    }
    addLink(label,ele){
        this.link[label]=ele;
    }
    clearData(){
        //console.log('Modal::clearData()');
        this.Html.removeChilds(this.link['error']);
        this.Html.hideField(this.link['error']);
        this.Html.removeChilds(this.link['adapted']);
        this.Html.removeChilds(this.link['button']);
        this.Html.removeChilds(this.link['extra']);
        this.Html.removeChilds(this.link['info']);
        /* REMOVE CLOSE BTN ACTION */
        this.link['close'].removeAttribute('onclick');
        /* REMOVE ONCLICK ACTION ON MAIN MODAL CLOSE BTN ACTION */
        this.link['main'].removeAttribute('onclick');
        //console.log( this.link['close']);
        /* CLEAR HEAD */
        this.setHead('','');
    }
    setHead(title,color){
        /*
        console.log('Modal.setHead()');
        console.log(title);
        console.log(color);
         */
        this.link['head'].removeAttribute('class');
        this.link['head'].setAttribute('class','modal-header '+color);
        this.link['head'].childNodes[0].childNodes[0].innerHTML=title;
        //console.log(this.link['head']);
    }
    showLoad(){
        //console.log('Modal::showLoad()');
        if(this.loadNotify!==''){
            this.Html.showField(this.link['extra'],this.loadNotify);
        }
    }
    getShowLoad(){
        var self = this;
        var action = function(msg){
            console.log("Modal.getShowLoad()\r\n",msg);
            return self.showLoad(msg);
        };
        return action;
    }
    hideLoad(){
        //console.log('Modal::hideLoad()');
        if(this.loadNotify!==''){
            this.Html.hideField(this.link['extra']);
        }
    }
    getHideLoad(){
        var self = this;
        var action = function(msg){
            console.log("Modal.getShowLoad()\r\n",msg);
            return self.getHideLoad(msg);
        };
        return action;
    }
    setInfo(msg){
        //console.log('Modal::setInfo()');
        this.Html.removeChilds(this.link['info']);
        var textInfo=document.createElement('small');
            textInfo.setAttribute('class','text-left text-secondary ml-1');
            textInfo.append(document.createTextNode(msg.toString()));
            this.link['info'].appendChild(textInfo);
    }
    setError(msg){
        this.Html.removeClass(this.link['error'],['d-none','alert-success']);
        this.Html.addClass(this.link['error'],['alert-danger']);
        this.Html.removeChilds(this.link.error);
        this.link.error.append(document.createTextNode(msg.toString()));
    }
    getSetError(){
        var self = this;
        var action = function(msg){
            console.log("Modal.getSetError()\r\n",msg);
            return self.setError(msg);
        };
        return action;
    }
    unsetError(){
        this.Html.addClass(this.link['error'],'d-none');
        this.Html.removeChilds(this.link.error);
    }
    setSuccess(msg){
        this.Html.removeClass(this.link['error'],['d-none','alert-danger']);
        this.Html.addClass(this.link['error'],['alert-success']);
        this.Html.removeChilds(this.link.error);
        this.link.error.append(document.createTextNode(msg.toString()));
    }
    getSetSuccess(){
        var self = this;
        var action = function(msg){
            return self.setSuccess(msg);
        };
        return action;
    }
    setLoad(Xhr,appUrl){
        var self=this;
            this.loadNotify='<img src="'+appUrl+'/img/loading_60_60.gif" alt="load_gif">';
        var start = function(){
                self.showLoad(); 
            };
        var end = function(){
                self.hideLoad();
            };
        Xhr.setOnLoadStart(start);
        Xhr.setOnLoadEnd(end);
    }
    getSetLoad(){
        var self = this;
        var action = function(Xhr,appUrl){
            return self.setLoad(Xhr,appUrl);
        };
        return action;
    }
    setLoadError(){
        //console.log('ProjectItems::modalXhrError()');
         var xhrError={
            o:this,
            m:'setError'
        };
        return xhrError;
    }
    prepareModal(title,titleClass){
        console.log('Modal.prepareModal()');
        //this.Modal.setLink();
        
        window.onbeforeunload = function() {
            return "Opuścić okno bez zapisu?";
        };
        this.setExitKeys();
        this.setHead(title,titleClass);
        $(this.link['main']).modal({
            show:true,
            backdrop: 'static',
            keyboard: false  // to prevent closing with Esc button
        });
        this.link['close'].parentNode.removeAttribute('data-dismiss');
    }
    setExitKeys(){
        console.log('Modal.setExitKeys()');
        var self= this;
        var f5 = function (e){
            //console.log('f5');
            e = e || window.event;
           if( self.wasPressed ) return; 
            if (e.keyCode === 116) {
                 //alert("f5 pressed");
                
            }else {
                //alert("Window closed");
            }
        };
        document.onkeydown = function(){
            //console.log('onkeydown');
            f5();
        };
        document.onkeypress = function(){
            //console.log('onkeypress');
            f5();
        };
        document.onkeyup = function(){
            //console.log('onkeyup');
            f5();
        };
    }
    unsetExitKeys(){
        console.log('Modal.unsetExitKeys()');
        document.onkeydown =null;
        document.onkeypress = null;
        document.onkeyup = null;
    }
    setCloseModal(){
        console.log('Modal.setCloseModal()');
        /* CLOSURE */
        var self = this;
        var check = function (){
                //if(self.ErrorStack.check()){
                //    if (confirm('Opuścić okno bez zapisu?') === true) {
                 //       self.closeModal();
                //        return false;
                //    }
                //    else{ 
                 //       return false;
                 //   }
               // }
                //console.log('run');
                //console.log(run);
                if (confirm('Wyjść?') === true) {
                    self.closeModal();
                }
                else{}
        };
        this.link['close'].onclick = function (){
            /* TO DO */
            check();
        };
         /* SET CLOSE VIA MOUSE */
        this.link['main'].onclick = function (e){
            if(e.target.id === 'AdaptedModal'){
                //console.log('outside');
                check();
            }
            else {}
        };
    }
    showModal(){
        console.log('Modal.showModal()');
        //$('#AdaptedModal').modal('show');
        $(this.link['main']).modal({
            show:true,
            backdrop: 'static',
            keyboard: false  // to prevent closing with Esc button
        });
        this.link['close'].parentNode.removeAttribute('data-dismiss');
    }
}