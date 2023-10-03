class Form_stage_remove extends Modal{
    Html = new Object();
    id = 0 ;
    constructor(){
        super();
        console.log('Form_stage_create.construct()');
        this.Html = new Html();
    }
    setId(id){
        this.id = id;
    }
    getButton(){
        var self = this;
        var button  = this.Html.getButton('Wyświetl',['btn-info']);
            button.onclick = function(){
                console.log(self.id);
            };
        return button;
         
    }
}