			//为JQuery添加插件
			;(function($){
				var DeferScript = null;
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
			        loadPage:function(id,url,type,param,callback, isRemoveValiTip){ 
						
						isRemoveValiTip = isRemoveValiTip || true;	
						if(isRemoveValiTip === true){
							$(".formError").remove();
						}//默认loadpage的时候移除所有的错误验证提示
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
			          },
			          newLoadPage:function(id,url,type,param,success,isRemoveValiTip,timeout,error){ 
						isRemoveValiTip = isRemoveValiTip || true;	
						if(isRemoveValiTip === true){
							$(".formError").remove();
						}//默认loadpage的时候移除所有的错误验证提示
			            $.ajax({ 
			              url:url,
			              cache:false,
			              dataType:"html",
			              data:param,
			              type:type?type:"post",
			              timeout:timeout?timeout:120000,
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
			                if(success){
			                  success();
			                }
			              },error:function(data){
			                   if(error){
			                      error();
			                   }
			              }
			            });
			          },
			          loadJs:function(name){
			        	  if(!DeferScript){
			        		  DeferScript = {};
			        		  var scripts = $("script[type='text/deferjavascript']");
					        	 
				        	  for(var i=0,len = scripts.length;i < len;i++){
				        		  var $script = $(scripts[i]); 
				        		  var name = $script.attr("name");
				        		  DeferScript[name] = {};
				        		  DeferScript[name].src = $script.attr("src");;
				        		  DeferScript[name].isload = false;
				        		  
				        	  }
			        	  }
			        	  if(DeferScript[name]) new Error("script name error");
			        	  if(DeferScript[name].isload===true){
			        		  return;
			        	  }
			        	  var script = document.createElement("script");
			        	  script.type = "text/javascript";
			        	  script.src = DeferScript[name].src;
			        	  document.getElementsByTagName("head")[0].appendChild(script);
			        	  DeferScript[name].isload = true;
			          }
				});
			})(jQuery);
			(function($){
			    $.fn.lazybind = function(event, fn, timeout, abort){
			        var timer = null;
			        $(this).bind(event, function(e){
			            var param = {self:this,event:e}; 
			            timer = setTimeout(function(){fn(param)}, timeout);
			        });
			        if(abort == undefined){
			            return;
			        }
			        $(this).bind(abort, function(){
			            if(timer != null){
			                clearTimeout(timer);
			            }
			        });
			    };
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
			};
			$(function(){
				$('input[nospace="true"]').keydown(function(event){
					if(event.keyCode==32){
						var k = $(this).val();
						$(this).val(k.replace(/\s/ig,""));
						return false;
					}
				});
			});
			
			