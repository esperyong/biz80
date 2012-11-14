	var myLayout;
	;$(function(){
		// this layout could be created with NO OPTIONS - but showing some here just as a sample...
		// myLayout = $('body').layout(); -- syntax with No Options
 

		
		myLayout = $('body').layout({
 
		//	enable showOverflow on west-pane so popups will overlap north pane
			west__showOverflowOnHover: true
		//	reference only - these options are NOT required because are already the 'default'
		,	closable:				true	// pane can open & close
		,	resizable:				true	// when open, pane can be resized 
		,	slidable:				true	// when closed, pane can 'slide' open over other panes - closes on mouse-out
 
		//	some resizing/toggling settings
		,	north__slidable:		false	// OVERRIDE the pane-default of 'slidable=true'
		,	north__togglerLength_closed: '100%'	// toggle-button is full-width of resizer-bar
		,   north__closable:        true
		,	north__spacing_closed:	0		// big resizer-bar when open (zero height)
		,   north__spacing_open:0
		,	south__resizable:		false	// OVERRIDE the pane-default of 'resizable=true'
				// no resizer-bar when open (zero height)
		,	south__spacing_closed:	15		// big resizer-bar when open (zero height)
		,   south__spacing_open:15
		,   south__togglerLength_open:107
		,   south__togglerLength_closed:107
		,   south__initClosed:true
		,   south__onopen_end:function(){
				MenuToolRLBtn.changUlChange();
				MenuToolRLBtn.checkOverFlow();
		}
		//	some pane-size settings
		,	west__minSize:			100
		,   west__spacing_open:8
		,   west__spacing_closed:8
		,   west__togglerLength_open:36
		,   west__togglerLength_closed:36
		,	east__size:				300
		,	east__minSize:			200
		,	sliderTip:"展开"
		,	east__maxSize:			Math.floor(screen.availWidth / 2) // 1/2 screen width
		});
		
		//myLayout.addCloseBtn('.ui-layout-south', 'south');
					var mtb = MenuToolBar.getInstance({id:"menuToolBar"});
						mtb.expend();
						MenuToolRLBtn.init();
	});
	
	var MenuToolRLBtn ={
			init:function(){
				this.$menubar_lbtn = $("#menubar_lbtn");
				this.$menubar_rbtn = $("#menubar_rbtn"); 
				this.$toolbar_content = $("#toolbar_content");
				this.$main_menubar = $("#main_menubar");
				this.$ul=$("#menuToolBar");
				var lis = this.$ul.children("li");
				this.$lis = [];
				this.timeout = 0;
				for(var i=0,len = lis.length;i<len;i++){
					this.$lis.push($(lis[i]));
				}
				var self = this;
				this.$menubar_lbtn.bind("click",function(){
					self.leftBtn();
				}).bind("mousedown",function(){
					self.timeout  = setInterval(function(){
						self.leftBtn("to");
					},100);
				}).bind("mouseup",function(){
					clearInterval(self.timeout);
				});
				this.$menubar_rbtn.bind("click",function(){
					self.rightBtn();
				}).bind("mousedown",function(){
					self.timeout  = setInterval(function(){
						self.rightBtn("to");
					},100);
				}).bind("mouseup",function(){
					clearInterval(self.timeout);
				});
				
				this.$firstLi = this.$lis[0];
				this.$lastLi = this.$lis[this.$lis.length-1];
			},
			changUlChange:function(){
				var width = 0;
				for(var i=0,len = this.$lis.length;i<len;i++){
					var $li = this.$lis[i];
					width += $li.width()+18;
				}
				this.$toolbar_content.width(width);
				var mw = this.$main_menubar.width();
				if(width<mw){
					this.$toolbar_content[0].style.left=(mw/2-width/2)+"px";
				}
				
			},
			addUlWidth:function(width){
				this.$toolbar_content.width(this.$toolbar_content.width()+width);
			},
			checkOverFlow:function(to){
				if(this.$toolbar_content.position().left<0){
					this.$menubar_lbtn.show();
				}else{
					this.$menubar_lbtn.hide();
					if(!to){
						clearInterval(this.timeout);
					}
				}
				if(this.$toolbar_content.width()>this.$main_menubar.width()){
						this.$menubar_rbtn.show();
				}else{
					this.$menubar_rbtn.hide();
					if(!to){
						clearInterval(this.timeout);
					}
				}
			},
			leftBtn:function(to){
				var left = this.$toolbar_content.position().left;
				left+=5;
				this.$toolbar_content[0].style.left=left+"px";
				this.checkOverFlow(to);
			},
			rightBtn:function(to){
				var left = this.$toolbar_content.position().left;
				left-=5;
				this.$toolbar_content[0].style.left=left+"px";
				this.checkOverFlow(to);
				//if(this.$firstLi.position().left<0){return;}
			}
	};
	
	
	var MenuToolBar={
			getInstance:function(conf){
				var items = [];
				var expendItem = null;
				return new function(){
					var lis = $("#"+conf.id).children("li");
					for(var i=0;i<lis.length;i++){
						var $li = new MenuItem(lis[i],this);
						if($(lis[i]).attr("current")=="true"){
							expendItem = $li;
						}
						items.push($li);
					}
					
					
					this.getExpendItem = function(){
						return expendItem;
					}
					this.setExpendItem = function($item){
						expendItem = $item;
					}
					this.expend= function(){
						 var innerThis = this;
						 var flag = true;
						 for(var i=0;i<lis.length;i++){
						 	var $child = $(lis[i]);
							var right = parseInt($child.css("marginRight"));
							if(++right>7){
								flag = false;
							}
							right+=2;
							$child.css("marginRight",right+"px");
						 }
						if(flag){
							setTimeout(function(){innerThis.expend();},1);	
						}
					}
				}();				
			},animal:false
		}
		
		var MenuItem = function(liHTML,bar){
			var toolbar = bar;
			this.$li = $(liHTML);
			this.$subitme = this.$li.children(".sub_option_menu");
			var innerThis = this;
			this.expendState = false;//false表示收缩，true表示展开
			this.$li.children("div:first-child").click(function(){
				if(MenuToolBar.animal) return;
				
				if(innerThis.expendState) return;
				MenuToolBar.animal = true;
				var ei = toolbar.getExpendItem();					
				if(innerThis.$li.attr("notExpend")=="true"){
					if(innerThis.$li.attr("isclick")){
//							window.location.href = "/pureportal/index_out.jsp?current="+innerThis.$li.attr("id");
						if(innerThis.$li.attr("target")){
							 window.open(innerThis.$li.attr("url"));
							 toolbar.setExpendItem(null);
			         MenuToolBar.animal = false;
			         if(ei)  ei.collect();
						}else{
							var url = innerThis.$li.attr("url");
							if(url.indexOf("?current=")!=-1){
								window.location.href = innerThis.$li.attr("url")
							}else{
							  window.location.href = url+'?current='+innerThis.$li.attr("id");
							}
						}
						return;
					}
					toolbar.setExpendItem(null);
					MenuToolBar.animal = false;
					if(ei)	ei.collect();					
				}else{
          if(innerThis.$li.attr("target") && innerThis.$li.attr("url")){
            window.open(innerThis.$li.attr("url"));
            toolbar.setExpendItem(null);
            MenuToolBar.animal = false;
          }
					innerThis.expend(ei);
					toolbar.setExpendItem(innerThis);
				}
			});
			this.$subitme.find("li  a").click(function(){
  				$(".sub_option_menu li a").removeClass("on");
  				var a = $(this);
  				
  				a.addClass("on");
  				a.get(0).blur();
  				
			});
		}
		MenuItem.prototype={
			expend:function(pre){			
				this.expendState = true;
				var innerthis = this;
				var width = parseInt(this.$li.width());
				width+=20;				
				if(width<=463){
					this.$li.width(width);
					if(pre){
						var prewidth = parseInt(pre.$li.width());
						if(prewidth>50){
							prewidth-=20;
						} 
						pre.$li.width(prewidth);
						pre.$subitme.css("display","none");
					}
					setTimeout(function(){
						innerthis.expend(pre);
					},10);
				}else{
				  innerthis.$subitme.css("display","block").css("marginLeft","0px");
					MenuToolBar.animal = false;
					this.expendState = false;
						MenuToolRLBtn.changUlChange();
						MenuToolRLBtn.checkOverFlow();
				}
			},
			collect:function(){
				this.expendState = false;
				var innerthis = this;
				var width = parseInt(this.$li.width());
				width-=20;
				this.$subitme.css("display","none");
				if(width>=50){
					this.$li.width(width);
					setTimeout(function(){
						innerthis.collect();	
					},10);
				}else{
					MenuToolBar.animal = false;
						MenuToolRLBtn.changUlChange();
						MenuToolRLBtn.checkOverFlow();
				}				
				
				
			}
		} 	   
		

var Index = {
			height:document.documentElement.clientHeight-68,
			collectNorth:function(callback){
				myLayout.panes.center.css("overflow","hidden");
				myLayout.close('north');
				if(callback){
				callback();	
				}
				myLayout.panes.center.css("overflow","auto");
			},
			expendNorth:function(callback){
				
				myLayout.panes.center.css("overflow","hidden");
				myLayout.open('north');
				if(callback){
					callback();	
				}
				myLayout.panes.center.css("overflow","auto");
			},
			centerHeight:function(){
				return myLayout.panes.center.height();
			},
			centerWidth:function(){
				return myLayout.panes.center.width();
			}
		}

