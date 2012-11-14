			//为JQuery添加插件
			;(function($){
				$.extend({
					isString:function(val){
						return Object.prototype.toString.call(val) === "[object String]";
					},
					getFnName:function(fn){
						return fn.toString().match( new RegExp( "^function\\s+([^\\s\\(]+)", "i" ) )[ 1 ];
					},
					apply:function(orial,target){
						for(var t in target){
							if(!orial.prototype[t]){
								orial.prototype[t]=target[t];
							}
						}
					},
			        loadPage:function(id,url,type,param,callback){ 
			            $.ajax({ 
			              url:url,
			              cache:false,
			              dataType:"html",
			              data:param,
			              type:type?type:"post",
			              success:function(data){
			                var $div = null;
			                if($.isString(id)){
			                  $div = $("#"+id);
			                }else{
			                  $div = id;
			                }
			                $div.find("*").unbind();
			                $div.html("");
			                $div.append(data);
			                if(callback){
			                  callback();
			                }
			              }
			            
			            });
			          }
				});
			})(jQuery);
			
			if(!window.CFNC && !window.Componet){
				
				
				//Component FN Category Container 组件功能类别容器  
				window.CFNC= function(){
					var views={};
					var ctrls={};
					var mods={};
					return {
						registDomCtrlFn:function(name,v){   //注册组件操作组件Dom的方法功能函数
						if(!views[name]) views[name]=v;
					},
					getDomCtrlFn:function(name){
						return views[name];
					},
					registComponetFn:function(name,c){  //注册组件操作功能的方法函数
						if(!ctrls[name]) ctrls[name]=c;						
					},
					getComponetFn:function(name){
						return ctrls[name];
					},
					registDomStruFn:function(name,m){  //注册组件构建组件Dom的方法功能函数
						if(!mods[name])	 mods[name]=m;
					},
					getDomStruFn:function(name){
						return mods[name];
					}				
					};
				}();
				
				
				//由是MVC实现方，规定配置KEY
				/*
				 * 内部属性  this.compent 子组件集
				 *         this.plugin  插件
				 */			
				window.Componet = {
						
						addPlugin:function(plugin){
					this.plugins.push(plugin)
				},
				initPlugin:function(conf){
					for(var i=0;i<this.plugins.length;i++){
						this.plugins[i].call(this,conf);
					}
				},
				init:function(conf,mvc){
					this.plugins = [];
					if(conf.plugins){
						for(var i=0;i<conf.plugins.length;i++){
							this.addPlugin(conf.plugins[i]);
						}
					}
					if (CFNC.getDomStruFn(mvc.domStru))	CFNC.getDomStruFn(mvc.domStru).call(this,conf,mvc);
					if (CFNC.getDomCtrlFn(mvc.domCtrl))	CFNC.getDomCtrlFn(mvc.domCtrl).call(this,conf,mvc);
					if (CFNC.getComponetFn(mvc.compFn))	CFNC.getComponetFn(mvc.compFn).call(this,conf,mvc);
					this.initPlugin(conf,mvc);
				}
				};			
			}
			
			