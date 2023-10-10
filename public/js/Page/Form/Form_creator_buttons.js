class Form_creator_chosen_list {
    link = {
        'main':new Object()
        ,'list':new Object()
    }
    chosen_list = new Object();
    counter = 0;
    response = new Object();
    Parent = new Object();
    
    constructor(){
        console.log('Form_creator_chosen_list.constructor()');
        this.Html = new Html();
        
    }
    reset(){
        /*
         * CLEAR chosen data row
         */
        this.response = new Object();
        this.chosen_list = new Object();
        this.counter = 0;
    }
    setList(main_ele){
        console.log('Form_creator_chosen_list.setList()');
        var row_label=this.Html.getRow();
            row_label.classList.add("bg-info");
        var col_label=this.Html.getCol(12);
            row_label.append(col_label);
        var row_data=this.Html.getRow();
        var col_data=this.Html.getCol(12);
            row_data.append(col_data);
        
        var h=document.createElement('h5');
            h.classList.add('text-left','font-weight-normal','text-white','pl-0','pr-0','pt-1','pb-0');
            h.append(document.createTextNode("Wybrane bloki formularza:"));
            
            col_label.append(h);
            
            this.link['list']=col_data;  //this.link['list']
            
            main_ele.append(row_label,row_data);  //dynamic_chosen
            this.link['main']=main_ele;

    }
    setResponse(response){
        console.log('Form_creator_chosen_list.setResponse()');
        this.response = response;
    }
    setParent(Parent){
        this.Parent = Parent;
    }
    getChosenDataList(){
        return this.chosen_list;
    }
    add(prop){//self,prop,counter
        console.log('Form_creator_chosen_list.add() prop - ');//,prop,self.response.stage[prop]
        console.log(this);
        console.log(prop);
        //return true;
        var row=this.Html.getRow();
            row.style.cursor='pointer';
            row.classList.add('mt-1');
            
            this.chosen_list[this.counter]={
                'counter':this.counter
                ,'ele':row
                ,'prop':prop
            };
            this.addRow(row,this,prop,this.counter);
            this.link['list'].append(row);
            this.counter++;
            console.log(this.chosen_list);
    }
    addRow(row,self,prop,counter){
        console.log('Form_creator_chosen_list.addRow() prop - ');//,prop,self.response.stage[prop]
        var col=this.Html.getCol(12);
        var span_bullet=document.createElement('span'); //&bull; &nbsp;
            span_bullet.classList.add('text-info');
            span_bullet.append(document.createTextNode("\u2022\u00A0"));
        var span_label=document.createElement('span');
            span_label.classList.add('text-dark');
            span_label.append(document.createTextNode("["+self.response.stage[prop].id+"]\u00A0"),document.createTextNode(self.response.stage[prop].title));
            
            row.onmouseover = function (){
                this.classList.remove("bg-white");
                this.classList.add("bg-primary");
                span_label.classList.remove("text-dark");
                span_label.classList.add("text-white");
                span_bullet.classList.remove('text-info');
                span_bullet.classList.add("text-white");
               
            };
            row.onmouseleave = function (){
                this.classList.remove("bg-primary");
                this.classList.add("bg-white");
                span_label.classList.remove("text-white");
                span_label.classList.add("text-dark");
                span_bullet.classList.remove("text-white");
                span_bullet.classList.add('text-info');
            };
        var button_remove = self.Html.removeButton();
            button_remove.classList.add('btn-sm','float-right');
            button_remove.onclick = function(){
                try{
                    console.log("counter - ",counter);
                    console.log("chosen_list[counter]\r\n",self.chosen_list[counter]);
                    console.log("list\r\n",self.link['list']);
                    self.chosen_list[counter].ele.remove();
                    delete self.chosen_list[counter];
                    console.log("after delete chosen_list[counter]\r\n",self.chosen_list);
                }
                catch(e){
                    console.log('Form_creator_chosen_list.addRow() catch() button remove onclick()');
                    console.error(e);
                    self.Parent.setError("Application error occurred! Contact with Administrator!");//Filled_form_table
                }
                
            };
            col.append(span_bullet,self.getMoveUp(self,prop,counter),self.getMoveDown(self,prop,counter),span_label,button_remove);
            row.append(col);
    }
    getMoveUp(self,prop,counter){
        var span=document.createElement('span');
        var i=document.createElement('i');
            i.classList.add('fa','text-dark','text-center','fa-long-arrow-up');
            i.setAttribute('aria-hidden','true');
            i.style.cursor='pointer';
            i.onmouseover = function (){
                this.classList.remove("text-dark");
                this.classList.add("text-white");
            };
            i.onmouseleave = function (){
                this.classList.remove("text-white");
                this.classList.add("text-dark");
            };
            i.onclick = function(){
                try{
                    self.moveUp(self,prop,counter);
                }
                catch(e){
                    console.log('Form_creator_chosen_list.getMoveUp() catch() i onclick()');
                    console.error(e);
                    self.Parent.setError("Application error occurred! Contact with Administrator!");//Filled_form_table
                }
            };
            span.append(i);
            return span;
    }
    getMoveDown(self,prop,counter){
        var span=document.createElement('span');
        var i=document.createElement('i');
            i.classList.add('fa','text-dark','text-center','fa-long-arrow-down','mr-1','ml-1');
            i.setAttribute('aria-hidden','true');
            i.style.cursor='pointer';
            i.onmouseover = function (){
                this.classList.remove("text-dark");
                this.classList.add("text-white");
            };
            i.onmouseleave = function (){
                this.classList.remove("text-white");
                this.classList.add("text-dark");
            };
            i.onclick = function(){
                try{
                    self.moveDown(self,prop,counter);
                }
                catch(e){
                    console.log('Form_creator_chosen_list.getMoveDown() catch() i onclick()');
                    console.error(e);
                    self.Parent.setError("Application error occurred! Contact with Administrator!");//Filled_form_table
                }
            };
            span.append(i);
            return span;
    }
    moveDown(self,prop,counter){
        console.log('Form_creator_chosen_list.moveDown()'); 
        console.log(self);
        console.log("prop - ",prop);
        console.log("counter - ",counter);
        console.log("counter string - ",counter.toString());
        console.log("BEFORE swap list\r\n",self.link['list']);
        console.log("BEFORE swap chosen_list\r\n",self.chosen_list);
        var after=new Object();
        var add_to_list = function(after,counter_row,chosen_list){
            console.log('add_to_list',after,chosen_list);
            after[counter_row]=chosen_list;
            console.log('add_to_list() after',after);
        };
        var no_add_to_list = function(after,counter_row,chosen_list){
            console.log('no_add_to_list',after);
            
        };
        var add = no_add_to_list;
        
        for(const counter_row in self.chosen_list){
            
            console.log("row - ",counter_row);
            //before[i] = self.chosen_list[counter_row];
            if(counter.toString()===counter_row){
               console.log('FOUND!');
               /*
                * SET TO AFTER ADD
                */
               add = add_to_list;
               /*
                * SKIP ITERATION
                */
               continue;
            }
            /*
             * ADD OR NO
             */
            add(after,counter_row,self.chosen_list[counter_row]);
            /*
             * CHANGE TO NO AFTER ADD
             */
            add = no_add_to_list;

        }
        console.log("after - ",after);
        for(const i in after){
            console.log(i);
            console.log(after[i]);
            if(after[i].prop===prop){
                console.log(after[i].prop);
                console.log('AFTER HAVE THE SAME prop - NOTHING TO DO!');
                break;
            }
            else{
                /*
                * REMOVE HTML CHILDS
                */
                self.Html.removeChilds(after[i].ele);
                self.Html.removeChilds(self.chosen_list[counter].ele);
                /*
                 * ADD NEW HTML ROWS - addRow(row,self,prop,counter);
                 */
                self.addRow(after[i].ele,self,prop,after[i].counter);
                self.addRow(self.chosen_list[counter].ele,self,after[i].prop,counter);
                /*
                * SWAP prop
                */
                self.chosen_list[counter].prop=after[i].prop;
                self.chosen_list[after[i].counter].prop=prop;

                console.log("after swap list\r\n",self.link['list']);
                console.log("after swap chosen_list\r\n",self.chosen_list);
            }
            break;
        }
        
    }
    moveUp(self,prop,counter){
        console.log('Form_creator_chosen_list.moveUp()'); 
        //console.log(self);
        console.log("prop - ",prop);
        console.log("present data\r\n",self.chosen_list[counter]);
        console.log("counter - ",counter);
        console.log("counter string - ",counter.toString());
        
        var before=new Object();
        var i=0;
        for(const counter_row in self.chosen_list){
            
            console.log("row - ",counter_row);
            before[i] = self.chosen_list[counter_row];
            if(counter.toString()===counter_row){
                console.log('FOUND FINISH!');
                /*
                 * REMOVE LAST ELEMENT BECAUSE IS THE SAME AS NOW
                 */
                delete before[i];
                i--;
                break;
            }
            i++;
        }
        console.log('Form_creator_chosen_list.moveUp() before:'); 
        console.log("before all - ",before);
        console.log(i);
        
        if(i===-1){
            console.log('FIRST AT THE LIST - NOTHING TO DO!');
            return false;
        } 
        console.log("before last - ",before[i]);
        if(before[i].prop===prop){
            console.log(before[i].prop);
            console.log('BEFORE HAVE THE SAME prop - NOTHING TO DO!');
            return false;
        }
        console.log('PRESENT',self.chosen_list[counter]);
        console.log('BEFORE',before[i]);
        console.log('BEFORE STAGE DATA:',self.response.stage[before[i].prop]);
        console.log("list\r\n",self.link['list']);

        /*
         * REMOVE HTML CHILDS
         */
        self.Html.removeChilds(before[i].ele);
        self.Html.removeChilds(self.chosen_list[counter].ele);
        
        console.log("after list\r\n",self.link['list']);
        /*
         * ADD NEW HTML ROWS - addRow(row,self,prop,counter);
         */
        self.addRow(before[i].ele,self,prop,before[i].counter);
        self.addRow(self.chosen_list[counter].ele,self,before[i].prop,counter);
        /*
         * SWAP prop
         */
        self.chosen_list[counter].prop=before[i].prop;
        self.chosen_list[before[i].counter].prop=prop;
        console.log("after swap list\r\n",self.link['list']);
        console.log("after swap chosen_list\r\n",self.chosen_list);
    }
}