
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


function default_menuContext_DomStruFn(conf,mvc){
      var self = this;
     
     var $top = $('<div class="menulist-top-l"><div class="menulist-top-r"><div class="menulist-top-m">上部圆角修饰</div></div></div>');
     
     self.$content = $('<div class="menulist-middle-m"></div>');
     var $middle =$('<div class="menulist-middle-l"></div>').append($('<div class="menulist-middle-r"></div>').append(self.$content));
     
     var $bottom = $('<div class="menulist-bottom-l"><div class="menulist-bottom-r"><div class="menulist-bottom-m">上部圆角修饰</div></div></div>');
     
     self.$all = $('<div class="menulist"></div>');
     if(conf.width){
    	 self.$all.css("width",conf.width+"px");
     }
     self.$all.append($top).append($middle).append($bottom).css("top",conf.y+"px").css("left",conf.x+"px").css("position","absolute").css("z-index","999").hide();
     

		self.duojimenus = null;
     $("body").append(self.$all);
     
     
          self.addMenuItems = function(items){
          	  
            var uls = [];
            var $ul = null;
            self.$content.find("*").unbind();
            self.$content.hide();
            self.$content.html("");
            $ul = $('<ul></ul>');
         //  var duojimenus = null;
            for(var i=0,len = items.length;i<len;i++){
                  var item = items[i];
                  for(var j=0,jlen=item.length;j<jlen;j++){
                    var $li = $('<li></li>');
					if(item[j].childMenu){
						item[j].text+='<a class="list-m-arrow"></a>';
					}
                    var $divtext; 
                    if(item[j].disable===false){
                    	var titleString = "";
                    	if(item[j].disablePrompt && typeof(item[j].disablePrompt) === "string"){
                    		titleString= " title=\"" +item[j].disablePrompt+"\" ";
                    	}
                    	$divtext = $('<div class="list"><div><div><div class="list-m-disable" style="padding-left:5px;" ' + titleString + '>'+item[j].text+'</div></div></div></div>');
                    }else{
                    	$divtext = $('<div class="list"><div class="list-l"><div class="list-r"><div class="list-m">'+item[j].text+'</div></div></div></div>');
                    }
                    $li.append($divtext);
                    $li.attr("id",item[j].id);
                    if(item[j].disable===false){
                    	//.
                    }else{
                    	if(item[j].listeners && item[j].listeners.click){  //菜单选项个性设置事件
                    		$li.bind("click",item[j].listeners.click);
                    	}
                    	if(item[j].listeners && item[j].listeners.mouseover){  //
                    		$li.bind("click",item[j].listeners.mouseover);
                    	}
                    	if(conf.listeners && conf.listeners.click && (!item[j].listeners || !item[j].listeners.click)){  //按钮统一设置一个事件
                    		$li.bind("click",{id:item[j].id},itemClick);
                    	}
                    }
					
                    $li.bind("mouseover",function(){
                    	var it = item[j];
						return function(){
							if(self.duojimenus){
								self.duojimenus.hide();
							}
							var $div = $(this);
	                    	if( it.childMenu && !self.duojimenus ){
	                    		it.childMenu.x = 0;
								it.childMenu.y = 0;
	                    		self.duojimenus = self.duojimenu( it.childMenu , mvc );
	                    	}
							if(self.duojimenus &&  it.childMenu){
								var offset = $div.offset();
								var menusLength = it.childMenu.menus[0].length;
								self.duojimenus.position( offset.left + $div.width() + 12 , offset.top ,menusLength);
								self.duojimenus.addMenuItems(it.childMenu.menus);
							}
	                    }
                    }()).bind("click",function(){
							self.hide();
						});
                   
//			$li.bind("mouseover",mouseover).bind("mouseout",mouseout);
                    $divtext.bind("mouseover",mouseover).bind("mouseout",mouseout);
                    
                    
                    $ul.append($li);
                  }
                  if(i+1==len){
                    $ul.addClass("last");
                  }else{
                	  $ul.append('<li class="line"></li>');
                	  
                  }
            }
            self.$content.append($ul);
            self.$content.show();
            self.display();
            self.$all[0].focus(); 
            function itemClick(event){
                if(event.data.id){
                    conf.listeners.click(event.data.id);
                }
            }
            function mouseover(){
            	 var $div = $(this);
				 $div.find('a').addClass("list-m-arrow-on").removeClass('list-m-arrow');
				 $div.addClass("list-on").removeClass("list");
            }
            function mouseout(){
            	var $div = $(this);
				$div.find('a').addClass("list-m-arrow").removeClass('list-m-arrow-on');
            	$div.addClass("list").removeClass("list-on");
            }
            
        	 setTimeout(function(){
        	 	  	$("body").bind("click",self.bodyClick);
        	      },1000);
         }
 
}

function ico_menuContext_DomStruFn(conf){
  var self = this;
   self.$all = $('<div class="buttonmenu"></div>');
   
   if(conf.width){
	   
	   self.$all.css("width",conf.width+"px");
   }
   
   self.$all.css("top",conf.y+"px").css("left",conf.x+"px").css("position","absolute").css("z-index","999").hide();
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
      function itemClick(event){
           if(event.data.id){
                 conf.listeners.click($.trim(event.data.id));
           }
      }       
 	 setTimeout(function(){
 	  	$("body").bind("click",self.bodyClick);
      },1000);
   }
   
}
CFNC.registDomStruFn("ico_menuContext_DomStruFn",ico_menuContext_DomStruFn);


function checkbox_menuContext_DomStruFn(conf){
	 var self = this;
	 self.$all = $('<div class="buttonmenu-checkbox"></div>')
	 if(conf.width){
		 self.$all.css("width",conf.width+"px");
	 }
	 
	 
	 self.$all.css("top",conf.y+"px").css("left",conf.x+"px").css("position","absolute").css("z-index","999").hide();
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
	                     $li.attr("id",item[j].id);
	                     var checked="";
	                     if(item[j].checked){
	                    	 checked="checked";
	                     }
	                     var $checkspan = $('<span class="checkbox"><input name="" type="checkbox" '+checked+' value="'+item[j].id+'" /></span>')
	                     var $textspan = $('<span class="txt">'+item[j].text+'</span>');
	                     $li.append($checkspan).append($textspan);
	                     //if(item[j].listeners && item[j].listeners.click){  //菜单选项个性设置事件
	                       //  $li.bind("click",item[j].listeners.click);
	                     //}
	                     //if(conf.listeners && conf.listeners.click && (!item[j].listeners || !item[j].listeners.click)){  //按钮统一设置一个事件
	                       //$li.bind("click",{id:item[j].id},itemClick);
	                     //}
	                     $ul.append($li);                    
	               $ul.append($li);
	             }
	             self.$all.append($ul);
	        }
	       self.$all.show();
	       self.display();
	       function itemClick(event){
	            if(event.data.id){
	                  conf.listeners.click($.trim(event.data.id));
	            }
	       }       
	  	 setTimeout(function(){
	  	  	$("body").bind("click",self.bodyClick);
	       },1000);		
	 }
	 
	 self.getChecks = function(){
		 var checkbox = self.$all.find("input[type='checkbox']:checked");
		 var checkboxid = [];
		 for(var i=0,len = checkbox.length;i<len;i++){
			 checkboxid.push(checkbox[i].value);
		 }
		 return checkboxid;
	 }
	 self.getunChecks = function(){
		 var checkbox = self.$all.find("input[type='checkbox']:not(:checked)");
		 var checkboxid = [];
		 for(var i=0,len = checkbox.length;i<len;i++){
			 checkboxid.push(checkbox[i].value);
		 }
		 return checkboxid;
	 }
}
CFNC.registDomStruFn("checkbox_menuContext_DomStruFn",checkbox_menuContext_DomStruFn);

/**
 * 黑色下拉菜单
 * @param conf
 */
function balck_menuContext_DomStruFn(conf){
	var self = this;
	var width = conf.width;
	var gapWidth = conf.gapWidth;
	self.$all = $('<div class="btn-m-list" style="z-index: 998; margin-top: 6px; width: '+width+'px; top: 12px; left: -1px;"></div>');
	self.$all.append('<div class="jiekou" style="width: 62px;"/>');
	
	
}


function defatul_menuContext_DomCtrlFn(conf){
     var self = this;
     self.items = [];
	 if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth){
	     self.docHeight= document.documentElement.clientHeight; //浏览器可见区域高度
	     self.docWidth = document.documentElement.clientWidth; //浏览器可见区域宽度
	 }
	 
	
	
     self.display = function(){
       self.$all.css("display","inline-block");
     }
     self.hide = function(){
		 if(self.duojimenus){self.duojimenus.hide();}
    	if(conf.listeners && conf.listeners.close){
    		conf.listeners.close();
    	}
    	if(self.bodyClick){
    		
    		$("body").unbind("click",self.bodyClick);
    	}
       self.$all.css("display","none");
     }
     self.clear = function(){
         self.$all.find("*").unbind();
         $("body")[0].removeChild(self.$all[0]);
     }
     self.isShow = function(){
    	 return self.$all.css("display")!="none";
     }
     self.position = function(x,y){
    	 var scrollTop = document.body.scrollTop 
    	 var scrollLeft = document.body.scrollLeft 
         var menuHeight = self.getHeight();
    	 var menuWidth = self.getWidth();
    	 var menuAllH = y - scrollTop +menuHeight;
    	 var menuAllW = x - scrollLeft + menuWidth;
    	 if(menuAllH > self.docHeight){
      	   y = y -(menuAllH - self.docHeight );
         }
    	 if(menuAllW > self.docWidth){
    		 x = x -(menuAllW - self.docWidth );
    	 }
    	 
    	 
    	 
    	 
    	 
        self.$all.css("top",y+"px").css("left",x+"px");
     }
     self.getX = function(){
       return self.$all.position().left;
     }
     self.getY = function(){
       return self.$all.position().top;
     }
     self.setX = function(x){
       self.position(x,self.getY());
     }
     self.setY = function(y){
       self.position(self.getX(),y);
     }
     self.getWidth = function(){
    	 return self.$all.width();
     }
     self.getHeight = function(){
    	 return self.$all.height();
     }
     self.setWidth = function(width){
    	 self.$all.width(width);
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
     self.bodyClick = function(event){
    	 var left = self.getX();
    	 var top = self.getY();
         var x = left +self.getWidth();
         var y  = top + self.getHeight();
         if(event.pageX>=left && event.pageX<=x && event.pageY >=top && event.pageY <=y){
        	 	return;
         }
         self.hide();
         $("body").unbind("click",self.bodyClick);
     }	
}



function default_menuContext_ComponetFn(conf){
	//self.isChild = conf.isChild;
}

function duojimnue(conf,mvc){
		var self = this;
		self.duojimenu = function(conf,mvc){
			var c = $.extend({isChild:true,x : 0,y : 0,width:150,plugins:[duojimnue]},conf);
			var childmenu =  new MenuContext(c,mvc);
			childmenu.setParent( self);
			return childmenu;
		}
		self.setParent = function(parent){
			self.parentMenu = parent;
		}
		var left = 0;
		function round(menu){
			if(menu.parentMenu){
				left += menu.getWidth();
				round(menu.parentMenu);
			}else{
				left + menu.getWidth() + menu.$all.position.x;
			}
		}
		 self.position = function(x,y,menusLength){
			 var topHeight = 16,bottomHeight=16,lineHeight=21;
	    	 var scrollTop = document.body.scrollTop;//文档上部被盖住的长度
	    	 var scrollLeft = document.body.scrollLeft;//文档左侧盖住的长度
			 round(self);
	         var menuHeight = self.getHeight();//当前菜单的高度
	         if(menusLength !== undefined){
	        	 menuHeight = menusLength * lineHeight + topHeight + bottomHeight + 10;
	         }
	    	 var menuWidth = self.getWidth();	//当前菜单的宽度
	    	 var menuAllH = y - scrollTop + menuHeight; //当前菜单的高度
	    	 var menuAllW = x - scrollLeft + menuWidth;//整个菜单的宽度
	    	 //alert(menuAllH +"#"+ self.docHeight);
	    	 if(menuAllH > self.docHeight){
	      	   y = y - (menuAllH - self.docHeight );
	         }
	
	    	 if(menuAllW > self.docWidth){
	    		 if(self.parentMenu){
	    			 x = x - self.getWidth() - self.parentMenu.getWidth() + 8;
	    		 }else{
	    			 x = x - (menuAllW - self.docWidth ); 
	    		 }
	    	 }else{
			 		 if(left > self.docWidth){
						x-=self.parentMenu.$all.width() - self.getWidth();
					}
			 }
	    	 
	        self.$all.css("top",y+"px").css("left",x+"px");
     }
		//return self.duojimenu(conf,mvc);
}
$.apply(MenuContext,Componet);