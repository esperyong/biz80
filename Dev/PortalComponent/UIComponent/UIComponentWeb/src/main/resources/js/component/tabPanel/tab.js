/*
 * {
 * 	width:tabPanel宽度
 *  tabBarWidth:tabPanel按钮宽度
 * }
 */
 var tabBarWidth = 0;

var TabPanel = function(){
  function innerTabPanel(conf,cfncconf){
    cfncconf = cfncconf ? cfncconf :{};
    $.extend(conf,cfncconf);
    this.init(conf,{domStru:cfncconf.Tabpanel_DomStruFn ? cfncconf.Tabpanel_DomStruFn  : "default_tabpanel__DomStruFn",
                    domCtrl:cfncconf.Gridpanel_DomCtrlFn ? cfncconf.default_tabpanel_DomCtrlFn : "default_tabpanel_DomCtrlFn",
                    compFn:cfncconf.Gridpanel_ComponetFn ? cfncconf.defatule_tablepanel_ComponetFn : "defatule_tablepanel_ComponetFn"
                  });    
  }
  CFNC.registDomStruFn("default_tabpanel__DomStruFn",default_tabpanel__DomStruFn);
  CFNC.registDomCtrlFn("default_tabpanel_DomCtrlFn",default_tabpanel_DomCtrlFn);
  CFNC.registComponetFn("defatule_tablepanel_ComponetFn",defatule_tablepanel_ComponetFn);
  
  return innerTabPanel;
}();


/**
 * 初始化定义结构
 * this.$tab  tab最外层
 * this.$tabBarcage  tab页签外出整体
 * this.$tabBar   tab页签UL
 * this.count  //页签个数
 * this.tabs：{}  key:index,value :{index页签索引,$tabHead页签$li,$tabA页签显示文字}
 * this.tabsById:key:id,value：{index页签索引,$tabHead页签$li,$tabA页签显示文字}
 * this.$tabContents: key:index,value:$显示区域
 */
function default_tabpanel__DomStruFn(conf){
	  var self = this;
	  self.$tab = $("#"+conf.id); //tab
	  self.$tabBarcage = $(self.$tab.children("div:first").children("div:first"));
	  self.$tabBar = $(self.$tabBarcage.children("div:first").children("ul:first"));
	  
	  
	  //初始化tab页签
	  var tabItems = self.$tabBar.children("li");
	  self.tabs = [];  //{inde:索引,$tabHead:tab页签整体,$tabA:tab页签内容}
	  self.tabsById = {};
	  self.count = tabItems.length
	  for(var i=0; i<self.count; i++){
	      var $li = $(tabItems[i]).css("position","relative");
	      var $a = $li.find("a");
	      var id = $li.attr("id");
	      var obj = {index:i+1,id:id,text:$a.text(),$tabHead:$li,$tabA:$a};
	      //self.tabs.push(obj);
	      self.tabs[i+1] = obj;
	      self.tabsById[id] = obj;
	  }
	  
	  //初始化tab显示区域
	  self.$tabContents = [];
	  var tabContents = self.$tab.children("div:gt(0)");  //第2个以后的div都是tab的显示区域
	  for(var i=0;i<tabContents.length;i++){
		  self.$tabContents.push($(tabContents[i]));
	  }
}




/**
 * 组件Dom操作部分
 * this.currentId 当前显示的TabId
 * this.currentIndex 当前显示的TabIndex
 */
function default_tabpanel_DomCtrlFn(conf){
   var self = this;
   var currentClass="nonce";  //当前选中的样式
   self.currentId="";
   self.currentIndex="";
   
   //设置当前Tab页签
   self.setCurrentItem = function(){
		this.$currentTabItem.addClass(currentClass);
		self.currentId=this.$currentTabItem.attr("id");
		return this;
   };
   

    //清楚当前Tab页签
   self.clearCurrentItem = function(){
	   if(this.$currentTabItem){
		   this.$currentTabItem.removeClass(currentClass);
	   }
		return this;
   };
   
   
   
    //判断制定页签是否为当前Tab页签
   self.isCurrentItem = function($tabItem){
        return $tabItem.hasClass(currentClass);   
   }
   //设置当前显示区域显示
   self.setContentDisplay = function(){
   	   if(this.$currentContent){
   	   		this.$currentContent.css("display",""); 
   	   	 }
   		
		return this;
   }
   //隐藏当前显示区域
   self.hiddenCurrentContent = function(){
	   this.$currentContent && this.$currentContent.css("display","none");
   		if(conf.isclear){  //如果配置信息中设定删除之前的
   			this.$currentContent.find("*").unbind();
   			this.$currentContent.empty();
   		}
		return this;
   }
   
   
   
   
   self.setTabBarLeft_leftWidth = function(left){
	  	self.setTabBarLeft(left);
   }
   //设置tabBar左坐标为0
   self.setTabBarLeft0 = function(){
	   self.setTabBarLeft(0);
   }
   //设置TabPanel宽度
   self.setWidth = function(value){
   		this.$tab.width(value);
   }
   //设置TabBar宽度，他要比TabPanel窄
   self.setTabBarWidth = function(value){
   		this.$tabBarcage.width(value);
   		tabBarWidth = value;
   }   
   
   //移动TabBar
   self.moveBar = function(setp){
   		var left = parseInt(this.$tabBar.css("left"));
		left = left+setp;
   		this.$tabBar.css("left",left+"px");
		return left;
   }
   
   self.setTabBarLeft = function(left){
	   this.$tabBar.css("left",left+"px");
   }
   
   //当前Tab标签左移宽度
   self.getTabBarLeft = function(){
   		return this.$tabBar.position().left;
   }
   
   
   self.removeChild = function($parent,$child){
	    $parent[0].removeChild($child[0]);
   }
   
   if(conf.width){
   		this.setWidth(conf.width);
   }
   if(conf.tabBarWidth){
   		this.setTabBarWidth(conf.tabBarWidth)
   }
   this.setTabBarLeft0();
   
     
   
   
}

/**
 * 组件功能部分
 * this.$currentTabItem 当前选中的LI JQ对象
 * 
 */
function defatule_tablepanel_ComponetFn(conf){
	var temp = this;
    this.currentTabItem = null;  //当前Tab页签
	var listeners = conf.listeners ? conf.listeners : {};
	
	/*
	 * 更改Tab页签文字
	 * param:index:(String:Tab的ID/num:Tab索引)
	 *       text:新的显示文本 
	 *  如果传入的是字符串，则根据ID查找页签，如果传入的是数字，则根据索引查找页签
	 * */
	this.setTabText = function(index,text){
    	if($.isString(index)){
    		temp.tabsById[index].$tabA.text(text);
    	}else{
    		temp.tabs[index].$tabA.text(text);
    	}
    	$(temp.$tabBar.children("li")[index-1]).find("a").text(text);
    };
    
    this.getTabText = function(index){
    	if($.isString(index)){
    		return temp.tabsById[index].$tabA.text();
    	}else{
    		return temp.tabs[index].$tabA.text();
    	}   	
    }
      
    /*
     * Tab加载内容
     * param:index:(String:Tab的ID/num:Tab索引)
     *       conf:ajax请求的参数对象
     *       isChange:是否更改页签
     * */
   
    this.loadContent = function(index,conf,isChange){
	   	conf = conf ?  conf : {};
	   	if(isChange){
	   		temp.change(index); 
	   	}
	   	$.loadPage(temp.$tabContents[index-1],conf.url,conf.type,conf.param,conf.callback);  
    };
	
    /*
     * 内部方法
     * index,目标索引 逻辑索引，比数组索引+1
     * */
    temp.change = function(index){
    	  	//如果显示区域不只有一个，则隐藏当前
    	  	if(temp.$tabContents.length!=1){
    	  		temp.hiddenCurrentContent();
    	  		temp.$currentContent = temp.$tabContents[index-1];
    	  	}
    	temp.clearCurrentItem();
			temp.currentIndex = index;
			temp.currentId = temp.tabs[index].id;
			temp.$currentTabItem = temp.tabs[index].$tabHead;  //li
			temp.setCurrentItem().setContentDisplay();   	  
      }
	
	//tab 可能是数组，或是tab对象
	temp.bindItemClick = function(tab,event){
		var tabs = !$.isArray(tab) ? [tab] : tab;
		for(var i=0;i<tabs.length;i++){
			var tb = tabs[i];
			temp.bind(tb.$tabHead,{
				"click":function(){
					var fntb = tb;
					return function(){
							if(event){
								if(event.changeBefore && event.changeBefore(fntb)===false){
									return;	
								}
								if(event.change){
									event.change(fntb);
								}
								temp.change(fntb.index);
							}

							if(event && event.changeAfter){
								event.changeAfter(fntb);
							}
					};					
				}()
			});
		}
	};
	
	temp.bind = function($obj,listeners){
		for(var key in listeners){
			$obj.bind(key,listeners[key]);
		}
	};
	
	


	

	
	//绑定tab页签事件
	for(var i=0;i<=temp.tabs.length;i++){
		var tab= temp.tabs[i];
		if(!tab) continue;
		if(temp.isCurrentItem(tab.$tabHead)){
			temp.currentId = tab.id;
			temp.currentIndex = tab.index;
			temp.$currentTabItem = tab.$tabHead;
			if(temp.$tabContents.length==1){
				temp.$currentContent = temp.$tabContents[0];
			}else{
				temp.$currentContent = temp.$tabContents[tab.index-1];
			}
		}
		temp.bindItemClick(tab,listeners);
	}
}



$.apply(TabPanel,Componet);










//按钮插件
function defaultToolsPlugin(conf){
	
   var temp = this;
   var moveInterval = null;
   var listeners = conf.listeners ? conf.listeners : {};
   
  //总宽度-tab签宽度=隐藏了的跨度
  function getScrollWidth(){
	  	var left = 0;//最后一个
		for(var key in temp.tabs){
			left += (temp.tabs[key].$tabHead.width()+4);
		}
		var cha =  left - temp.$tabBarcage.width();  //tab页签全部宽度总和-包含他们的外层宽度
	  	return cha < 0 ? 0 : cha;  //tab页签宽度过宽
  }

  function getTabBarWidth(){
  		return temp.$tabBarcage.width();
  }

  //获取所有Tab页签宽度总和+4
  function getBarWidthCount(other){
	  	var left = 0;
		for(var key in temp.tabs){
			left += (temp.tabs[key].$tabHead.width()+other);
		}	  
		return left;
  }
  
  //工具栏
  temp.$tools={};
  temp.addToolDom = function(conf){
	  	var titleText = "";
	  	if(conf.title){
	  		titleText = " title='" + conf.title + "' ";
	  	}
  		var $tool = $('<a class="'+conf.cls+' right" ' + titleText + ' href="javascript:void(0)"></a>');
		temp.$tabBarcage.parent().append($tool);
		temp.$tools[conf.id]=$tool;
		return $tool;
  };
  temp.removeToolDom = function(conf){
  	   var $tool = temp.$tools[conf.id];
	   this.removeChild($tab,$tool);
  };

 	//添加工具
	temp.addTool = function(conf){
		var $tool = temp.addToolDom(conf);
		temp.bind($tool,conf.listeners);
	};
	
	//移除工具
	temp.removeTool = function(conf){
		var $tools = temp.tools[conf.id];
		$tools.unbind();
		temp.removeToolDom();
	}; 
  	


	//添加
	temp.addTab = function(conf){
		var tabitem = addTabItemDom(conf);
		temp.bindItemClick(tabitem,listeners);
		temp.clearCurrentItem();
		temp.$currentTabItem = tabitem.$tabHead;
		temp.currentId = tabitem.id;
		temp.currentIndex = tabitem.index;
		
		if(getScrollWidth()>0){
			//用tab页签总宽度-它的包装容器宽度，差就是要左移的像素数
			temp.setTabBarLeft(-(getBarWidthCount(4)-getTabBarWidth()));
			rightBtnOn();leftBtnOff();
		}
		
		if(conf.isaddConent){
			var $content = $('<div class="tab-content" style="width:'+conf.width+'px"></div>');
			temp.$tab.append($content);
			temp.$tabContents.push($content);
		}		
	};
	
	
	  //添加一个Tab页签
	addTabItemDom = function(conf){
			$li = $('<li id="'+conf.id+'" class="nonce"></li>').css("position","relative");
			$a = $('<a href="#">'+conf.text+'</a>');
			var $div = $('<div class="tab-l"></div>').append($('<div class="tab-r"></div>').append($('<div class="tab-m"></div>').append($a)));
			temp.$tabBar.append($li.append($div));
			temp.count = temp.count+1;
			var tabitem = {id:conf.id,index: temp.count,$tabHead:$li,$tabA:$a};  //添加一个tab页签，将tab页签总数加1
			temp.tabs[temp.count]=tabitem;
			temp.tabsById[conf.id] = tabitem;
			temp.$tabBar.width(temp.$tabBar.width() + $li.width());
			return tabitem;
	};
	
	
	/*
	 * 删除制定Tab页签 
	 * */
	temp.removeTab= function(mark){
		var index = removeTabItemDom(mark);
		index--;
		temp.$tab = $("#"+conf.id); //tab
		temp.$tabBarcage = $(temp.$tab.children("div:first").children("div:first"));
		temp.$tabBar = $(temp.$tabBarcage.children("div:first").children("ul:first"));
		temp.$tabBar = $(temp.$tabBarcage.children("div:first").children("ul:first"));
		refreshTabItems(temp,index);//参数 : temp ： 页签对象 ,index ： 被删除的 页签索引 ;
	    if(temp.count!=0){
	    	temp.change(temp.count);
		}
	};
	
	//删除某个非头或尾的标签，要重新初始化 页签集合对象并重新绑定点击事件
	//By KangQiang 
	refreshTabItems = function (tabItems,index){
		  var temp = tabItems;
		  //初始化tab页签
		  var tabItems = temp.$tabBar.children("li");
		  temp.tabs = [];  //{inde:索引,$tabHead:tab页签整体,$tabA:tab页签内容}
		  temp.tabsById = {};
		  temp.count = tabItems.length;
		  for(var i=0; i<temp.count; i++){
		      var $li = $(tabItems[i]).css("position","relative");
		      var $a = $li.find("a");
		      var id = $li.attr("id");
		      var obj = {index:i+1,id:id,text:$a.text(),$tabHead:$li,$tabA:$a};
		      temp.tabs[i+1] = obj;
		      temp.tabsById[id] = obj;
		      if((i+1) >= index){
		      	obj.$tabHead.unbind("click");
		      	temp.bindItemClick(obj,listeners);
		      }
		      if((i+1) == temp.count)
		      	obj.$tabHead.trigger('click');
		  }
	};
	
	 
	
	removeTabItemDom = function(mark){
		var tabitem = null;
		var index = null;
		var m = null;
		var id = null;
		if($.isString(mark)){
			tabitem = temp.tabsById[mark];
			id=mark;
			index = tabitem.index;
		}else{
			tabitem = temp.tabs[mark];
			id = tabitem.id;
			index = mark;
		}
		if(tabitem){
			tabitem.$tabHead.remove();
			temp.$tabBar.width(temp.$tabBar.width() - tabitem.$tabHead.width());
			delete temp.tabsById[id];
			for(index++;index<=self.count;){
				var t =  temp.tabsById[index];
				if(t){
					temp.index-=1;
					temp.$tabs[index-1] = t;
				}
			}
		}
		return index;
	};
	


	
	//移动按钮样式
	var moveToolCls={
			leftcls:"tab-ico tab-ico-left",
			offleftcls:"tab-ico tab-ico-left-off",
			rightcls:"tab-ico tab-ico-right",
			offrightcls:"tab-ico tab-ico-right-off"
	};
	
	function checkLeftBtn($btn){
		if($btn.hasClass(moveToolCls.offleftcls)){
			leftBtnOff();
			return true;
		}
	}
	
	function checkRightBtn($btn){
		if($btn.hasClass(moveToolCls.offrightcls)){
			$btn.removeClass(moveToolCls.offrightcls);
			$btn.addClass(moveToolCls.rightcls);
			return true;
		}		
	}
	

	function leftBtnOff(){
		temp.$tools["left"].removeClass(moveToolCls.leftcls).addClass(moveToolCls.offleftcls);
	}
	function rightBtnOff(){
		temp.$tools["right"].removeClass(moveToolCls.rightcls).addClass(moveToolCls.offrightcls);
	}
	function leftBtnOn(){
		temp.$tools["left"].removeClass(moveToolCls.offleftcls).addClass(moveToolCls.leftcls);
	}
	function rightBtnOn(){
		temp.$tools["right"].removeClass(moveToolCls.offrightcls).addClass(moveToolCls.rightcls);
	}
	function leftIsOff(){
		return temp.$tools["left"].hasClass(moveToolCls.offleftcls);
	}
	
	
	var movetool =[{
						id:"right",
						cls:moveToolCls.offrightcls,
						title:"右移",
						listeners:{
						"mousedown":function(){
							var $btn = $(this);
							moveInterval = setInterval(function(){
															if (temp.$tabBar.position().left >= 0) {
																clearInterval(moveInterval);
																rightBtnOn();leftBtnOff();
																temp.setTabBarLeft0();
															}else{
																temp.moveBar(20);
																rightBtnOn();leftBtnOn();
																//if(temp.$tabBar.width() <= tabBarWidth)
																	//temp.$tabBar.width(tabBarWidth);
																//else
																temp.setTabBarLeft0();
																temp.$tabBar.width(tabBarWidth);
																
															}
														},10)
						},
						"mouseup":function(){
							clearInterval(moveInterval);
							if (temp.$tabBar.position().left >= 0) {
								rightBtnOn();leftBtnOff();
							}else{
								rightBtnOn();leftBtnOn();
							}
						//	temp.setTabBarLeft0();
						}
					}
												
	 			},{
					id:"left",
					cls:moveToolCls.leftcls,
					title:"左移",
					listeners:{
							"mousedown":function(){
								if(leftIsOff()) return;
								moveInterval = setInterval(function(){
										var scrollWidth = getScrollWidth();
										if(temp.getTabBarLeft() < - scrollWidth|| (temp.getTabBarLeft() ==0 && scrollWidth<=0)){
											clearInterval(moveInterval);
											rightBtnOff();leftBtnOn();
											
										}else{
											temp.moveBar(-20);
											//alert(temp.$tabBar.width());
											leftBtnOn();rightBtnOn();
											//temp.setTabBarLeft_leftWidth(-getScrollWidth());
											temp.$tabBar.width(tabBarWidth + getScrollWidth());
											
										}
									},10);
							},
							"mouseup":function(){
								clearInterval(moveInterval);
								if(leftIsOff()) return;
								var scrollWidth = getScrollWidth();
								if((temp.getTabBarLeft() ==0 && scrollWidth<=0)){
									rightBtnOff();leftBtnOn();
								}else{
									rightBtnOn();leftBtnOn();
								}
							}
						}
				 }];
				
				
				
	if(conf.tools && $.isArray(conf.tools)){
		
		conf.tools = movetool.concat(conf.tools);
	}	
	
	
	
	for(var i=0;i<conf.tools.length;i++){
		var tf = conf.tools[i];
		temp.addTool(tf);
	}
						
}


