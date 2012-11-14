
var MenuContext = function(){
  function innerMenuContext(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru:mvc.menuContext_DomStruFn ? mvc.menuContext_DomStruFn  : "default_menuContext_DomStruFn",
                    domCtrl:mvc.menuContext_DomCtrlFn ? mvc.menuContext_DomCtrlFn : "defatul_menuContext_DomCtrlFn",
                    compFn:mvc.menuContext_ComponetFn ? mvc.menuContext_ComponetFn : "default_menuContext_ComponetFn"
                  });  
  }
  CFNC.registDomStruFn("default_menuContext_DomStruFn",default_menuContext_DomStruFn);
  CFNC.registDomCtrlFn("defatul_menuContext_DomCtrlFn",defatul_menuContext_DomCtrlFn);
  CFNC.registComponetFn("default_menuContext_ComponetFn",default_menuContext_ComponetFn);
  
  
  return innerMenuContext;
}();


function default_menuContext_DomStruFn(conf){
      var self = this;
     
     var $top = $('<div class="menulist-top-l"><div class="menulist-top-r"><div class="menulist-top-m">上部圆角修饰</div></div></div>');
     
     self.$content = $('<div class="menulist-middle-m"></div>');
     var $middle =$('<div class="menulist-middle-l"></div>').append($('<div class="menulist-middle-r"></div>').append(self.$content));
     
     var $bottom = $('<div class="menulist-bottom-l"><div class="menulist-bottom-r"><div class="menulist-bottom-m">上部圆角修饰</div></div></div>');
     
     self.$all = $('<div class="menulist"></div>');
     self.$all.append($top).append($middle).append($bottom).css("top",conf.y+"px").css("left",conf.x+"px").css("position","absolute").css("z-index","10000000000000").hide();
     
     $("body").append(self.$all);
     
     
          self.addMenuItems = function(items){
            var uls = [];
            var $ul = null;
            self.$content.find("*").unbind();
            self.$content.hide();
            self.$content.html("");
            for(var i=0,len = items.length;i<len;i++){
                  $ul = $('<ul></ul>');      
                  var item = items[i];
                  for(var j=0,jlen=item.length;j<jlen;j++){
                    var $li = $('<li></li>');
                    $li.text(item[j].text);
                    $li.attr("id",item[j].id);
                    if(item[j].listeners && item[j].listeners.click){  //菜单选项个性设置事件
                        $li.bind("click",item[j].listeners.click);
                    }
                    if(conf.listeners && conf.listeners.click && (!item[j].listeners || !item[j].listeners.click)){  //按钮统一设置一个事件
                      $li.bind("click",{id:item[j].id},itemClick);
                    }
                    $ul.append($li);
                  }
                  if(i+1==len){
                    $ul.addClass("last");
                  }
                 self.$content.append($ul);
            }
            self.$content.show();
            self.display();
            self.$all[0].focus(); 
            function itemClick(event){
                if(event.data.id){
                    conf.listeners.click(event.data.id);
                }
            }
            
         }
 
}

function ico_menuContext_DomStruFn(conf){
  var self = this;
   self.$all = $('<div class="buttonmenu"></div>');
   self.$all.css("top",conf.y+"px").css("left",conf.x+"px").css("position","absolute").hide();
   $("body").append(self.$all);
   self.addMenuItems = function(items){
        var $ul = null;
       self.$all.find("*").unbind();
       self.$all.hide();
       self.$all.html("");
       for(var i=0,len = items.length;i<len;i++){
              $ul = $('<ul></ul>');      
              var item = items[i];
            for(var j=0,jlen=item.length;j<jlen;j++){
                    var $li = $('<li></li>');
                    $li.text(item[j].text);
                    $li.attr("id",item[j].id);
                    $li.addClass(item[j].ico);
                    if(item[j].listeners && item[j].listeners.click){  //菜单选项个性设置事件
                        $li.bind("click",item[j].listeners.click);
                    }
                    if(conf.listeners && conf.listeners.click && (!item[j].listeners || !item[j].listeners.click)){  //按钮统一设置一个事件
                      $li.bind("click",{id:item[j].id},itemClick);
                    }
                    $ul.append($li);                    
              $ul.append($li);
            }
            self.$all.append($ul);
       }
      self.$all.show();
      self.display();
      self.$all[0].focus(); 
      function itemClick(event){
           if(event.data.id){
                 conf.listeners.click($.trim(event.data.id));
           }
      }       
   }
   
}
CFNC.registDomStruFn("ico_menuContext_DomStruFn",ico_menuContext_DomStruFn);
function defatul_menuContext_DomCtrlFn(conf){
     var self = this;
     self.items = [];

     self.display = function(){
       self.$all.css("display","inline-block");
     }
     self.hide = function(){
       self.$all.css("display","none");
     }
     self.clear = function(){
         self.$all.find("*").unbind();
         $("body")[0].removeChild(self.$all[0]);
     }
     self.position = function(x,y){
        self.$all.css("top",y+"px").css("left",x+"px");
     }
     self.getX = function(){
       return self.$all.position().x;
     }
     self.getY = function(){
       return self.$all.position().y;
     }
     self.setX = function(x){
       self.position(x,self.getY());
     }
     self.setY = function(y){
       self.position(self.getX(),y);
     }
     var flag =true;
     function mouseout(){
       flag = false;
       setTimeout(function(){
         if(!flag){
           self.hide();
         }
       },1000)
     }
     function mouseover(){
       flag=true;
     }
     //self.$all.bind("mouseout",mouseout).bind("mouseover",mouseover)
     //self.$all.find("*").bind("mouseout",mouseout).bind("mouseover",mouseover);
     self.$all.bind("blur",function(){
       self.hide();
     });
}

function default_menuContext_ComponetFn(conf){
  
  
  
  
}
$.apply(MenuContext,Componet);