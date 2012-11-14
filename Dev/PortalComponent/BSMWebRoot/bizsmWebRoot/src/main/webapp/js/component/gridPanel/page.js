
var Pagination = function(){
  function innerPagination(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru:mvc.pagination_DomStruFn ? mvc.pagination_DomStruFn  : "default_pagination_DomStruFn",
                    domCtrl:mvc.pagination_DomCtrlFn ? mvc.pagination_DomCtrlFn : "defatul_pagination_DomCtrlFn",
                    compFn:mvc.pagination_ComponetFn ? mvc.pagination_ComponetFn : "default_pagination_ComponetFn"
                  });  
  }
  CFNC.registDomStruFn("default_pagination_DomStruFn",default_pagination_DomStruFn);
  CFNC.registDomCtrlFn("defatul_pagination_DomCtrlFn",defatul_pagination_DomCtrlFn);
  CFNC.registComponetFn("default_pagination_ComponetFn",default_pagination_ComponetFn);
  
  
  return innerPagination;
}();


function default_pagination_DomStruFn(conf){
  var self = this;
  var applyId = conf.applyId;
  
  self.$page  = $("#"+applyId).addClass("page").append(self.$pagegroup);
  
  
  
  self.init = function(count,current){
    
        self.$page.find("*").unbind();
        self.$page.empty();
        self.btns = [];
        self.count = count;
        var $pagegroup = $('<div class="page-group"></div>');
        var start = 0,end = 0;
        
        //
        if(current!=1){
          var $first = $('<span value="1" title="首页" class="page-ico page-ico-first"></span>');
          var $prev = $('<span value="'+(current-1)+'" title="上一页" class="page-ico page-ico-prev"></span>');     
          $pagegroup.append($first);
          $pagegroup.append($prev);
          self.btns.push($first);
          self.btns.push($prev);
        }
        var $pages = $('<ul></ul>');
        $pagegroup.append($pages);
        if(current!=count){
          var $next = $('<span value="'+(current+1)+'" title="下一页" class="page-ico page-ico-next"></span>');
          var $last = $('<span value="'+count+'" title="尾页" class="page-ico page-ico-last"></span>');    
          $pagegroup.append($next);
          $pagegroup.append($last);
          self.btns.push($next);
          self.btns.push($last);
        }     
        
        if(current==1){
            start = 1;
            end = count > 10 ? 10 : count;
        }
        
        //如果当前是最后一页
        if(current==count){
          end = count;
          start = count <=10 ? 1 : count-10;  
        }
        
        if(start==0){  //当前不是第一页
           start = current-5 > 0 ? current-5 : 1;
        } 
        if(end==0){
           end = start + 10 > count ? start+(count-start) : start+9;
           if(end==count){
             start = end-10 <= 0 ? 1 : end-10 ;
           }
           if(count<=10){
             end=count;
           }
        }      
        
        var cls = null;
        
        if(start!=1){
        	$pages.append($("<li>...</li>"));
        }
        
        for(;start<=end;start++){
           var $li = $('<li value="'+start+'"></li>');
             $li.append($('<a>'+start+'</a>'));
             if(start==current){
               $li.addClass("on");
             }else{
               self.btns.push($li);
             }
             $pages.append($li);
        }
        if(end!=count){
        	$pages.append("<li>...</li>");
        }
        self.$input = $('<input type="text"/>');
        $pagegroup.append("<span>跳转到</span>");
        $pagegroup.append(self.$input);
        self.$pageBtn = $('<span  class="page-ico page-ico-go"></span>');
        $pagegroup.append(self.$pageBtn);
    
    
        self.$page.append($pagegroup);  
    }
    
  
}

function defatul_pagination_DomCtrlFn(conf){
  var self = this;
  var pageClick = null;
  if(conf.listeners && conf.listeners.pageClick){
    pageClick = conf.listeners.pageClick;
  }
  self.bindClick = function(count){
      for(var i=0,len = self.btns.length;i<len;i++){
          var btn = self.btns[i];
          btn.bind("click",{count:count},click);
      }
      self.$pageBtn.bind("click",btnClick);
      self.$input.bind("keyup",function(event){
        if(event.keyCode==13){
          btnClick();
        }else{
          checkPageVal();
          
        }
      })
  }
  
  function click(event){
      if(event.data.count){
         var value = $(this).attr("value");
         self.pageing(event.data.count,parseInt(value));
         if(pageClick){
           pageClick(value);
         }
      }
  }
  
  function btnClick(){
    if(checkPageVal()){
      var pageVal = self.$input.val();
       self.pageing(self.count,pageVal);
         if(pageClick){
           pageClick(pageVal);
         }       
    }
  }
  function checkPageVal(){
    var pageVal = self.$input.val();
      if(isNaN(pageVal)){
         self.$input.val("");
         return false;
      }else{
         if(parseInt(pageVal)> self.count){
           self.$input.val("");
           return false;
         }
      } 
      return true;   
  }
  
}

function default_pagination_ComponetFn(conf){
  var self = this;
  self.pageing = function(count,current){
    self.init(count,current);
    self.bindClick(count,current);
  }
  
}
$.apply(Pagination,Componet);