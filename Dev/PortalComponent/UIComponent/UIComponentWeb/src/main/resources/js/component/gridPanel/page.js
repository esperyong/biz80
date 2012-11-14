
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
  self._isAll = false;


  self.init = function(count,current){
    if(count==0){
    	self.$page.hide();
    }else{
    	self.$page.show();
    }
        self.$page.find("*").unbind();
        self.$page.empty();
        self.btns = [];
        self.count = count;
        self.current = current;
        if(count==0){
        	return;
        }

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
        var showPageNum = 10;
        if(current > 99 && current < 1000){
        	showPageNum = 7;
        }else if(current >= 1000){
        	showPageNum = 5;
        }
        /*
        if(current > 99 && current < 1000){
        	showPageNum = 7;
        }else if(current < 10000){
        	showPageNum = 5;
        };*/
        if(current == 1){
            start = 1;
            end = count > showPageNum ? showPageNum : count;
        }

        //如果当前是最后一页
        if(current == count){
          end = count;
          start = count <= showPageNum ? 1 : count - showPageNum + 1;
        }

        if(start == 0){  //当前不是第一页
        	var t = Math.round(showPageNum/2);
           start = current - t > 0 ? current - t : 1;
        }

        if(end == 0){
           end = start + showPageNum > count ? start+(count-start) : start + showPageNum - 1;
           if(end==count){
             start = end - showPageNum + 1 <= 0 ? 1 : end - showPageNum + 1;
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
           if(start>99){
        	   $li.css({'padding-right':'2px','padding-left':'2px','width':'25px'});
           }
           	 // 修改分页缺陷 将<a>替换为<span> 绑定 mouseover、mouseout事件
             $li.append($('<span style="width:25px;">'+start+'</span>'));
             $li.bind('mouseover', {isNeedStyle:1}, setPageBtnStyle);
             $li.bind('mouseout', {isNeedStyle:-1}, setPageBtnStyle);
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
        $pagegroup.append("<span>跳转到： </span>");
        $pagegroup.append(self.$input);
        self.$pageBtn = $('<span  class="page-ico page-ico-go"></span>');
        $pagegroup.append(self.$pageBtn);
        if(conf.showAll || self._isAll){
			var $showAll = $("<span><input type='checkbox'></span><span>全部选中</span>");
			$showAll.find("input").click(function(){
					self._isAll = $(this).attr("checked");
					conf.showAllCallback && conf.showAllCallback(self._isAll);
			}).attr("checked",self._isAll);
			self.$page.append($showAll);
		}

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
	  if(count==0) return;
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
    	 var value =  parseInt(pageVal);
    	 
         if(!value || value === 0  || value > self.count){
           self.$input.val("");
           return false;
         }
      }
      return true;
  }

}

function default_pagination_ComponetFn(conf){
  var self = this;
  /*
   * 设置分页方法
   */
  self.pageing = function(count,current,isAll){
	  if(arguments.length == 3){
		  self._isAll = isAll;
	  }
	  self.init(count,current);
	  self.bindClick(count,current);
  }

}

/*
 * 设置分页按钮的选中样式
 * isNeedStyle - 1 需要设置样式
 *             - -1 不需要设置样式
 */
function setPageBtnStyle(event){
	if(event.data.isNeedStyle == 1){
        $(this).addClass('mover');
     }else if(event.data.isNeedStyle == -1){
    	 $(this).removeClass('mover');
     }

}

$.apply(Pagination,Componet);