<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<decorator:usePage id="linestylepanel" />


 <page:applyDecorator name="blackpanel">  
 		<page:param name="id">linestylepanel</page:param>
       <page:param name="content">
<%
	if(linestylepanel.getProperty("headother")!=null){
		out.print(linestylepanel.getProperty("headother"));
	}
%>

<!-- 线粗细-->


<div id="linestyle_panel" style="width:130px">
<table id="linestyleTable" style="width:130px">
<% for(int i=1;i<5;i++){ %> <tr><td><a value="style<%=i %>" num="<%=i+6 %>" class="drawline drawline-<%=i+6 %>"></a></span></td></tr> <% } %>
</table>
</div>

<%
	if(linestylepanel.getProperty("footother")!=null){
		out.print(linestylepanel.getProperty("footother"));
	}
%>
       </page:param>
     </page:applyDecorator>
<script type="text/javascript">
	var LineStylePanel = function(){
			var linestylepanel = new winPanel({
			    id:"linestylepanel",
			    isautoclose:false,
			    isDrag:false
			},{
				winpanel_DomStruFn:"blackLayerLoad_winpanel_DomStruFn"
			});			  
	
			var as = $("#linestyleTable a"); 
			//isClose点击颜色后是否关闭
			var isClose = false;
			var clickAfter = null;
			var currentSize = null;
		    function bodyClick(event){
	             var pos = linestylepanel.getPosition();
	             var x = pos.left+linestylepanel.getWidth();
	             var y  = pos.top+linestylepanel.getHeight();
	             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
	            	 	return;
	           	 }
	             $("body").unbind("click",bodyClick);                    
	             linestylepanel.hidden();
			}	

	        //绑定颜色按钮次数
			as.bind("click",function(){
				var $a = $(this);
				setCurrentSize($a);
				if(isClose){
					linestylepanel.hidden();
					 $("body").unbind("click",bodyClick); 
				}
				if(clickAfter){
					clickAfter(LineStylePanel.getSize());
				}
			});

	        //设置当前线条
			function setCurrentSize($a){
				if($.isString($a)){
					$a = $("#lineSizeTable a[value='"+$a+"']");
				}
				
				var num = $a.attr("num");
				if(currentSize!=null){
					var lastnum = currentSize.attr("num");
					currentSize.removeClass("drawline-"+lastnum+"-on");
				}
				$a.addClass("drawline-"+num+"-on");
				currentSize = $a;
			}
			
		return {
			init:function(conf){
				setCurrentSize(conf.style);
				this.setPosition(conf);
				this.setClose(conf.isClose);
				this.setClickAfterListeners(conf.clickAfter);
			},
			setClose:function(c){
				isClose = c;
			},
			setClickAfterListeners:function(callback){
				clickAfter = callback;
			},
			setPosition:function(conf){
				linestylepanel.setPosition(conf.x,conf.y);
			},
			show:function(){
				linestylepanel.show();
				 setTimeout(function(){
			        	$("body").bind("click",bodyClick);
		        },1000);					
			},
			close:function(){
				linestylepanel.hidden();
				$("body").unbind("click",bodyClick); 
			},
			getSize:function(){
				return currentSize.attr("value");
			}
		};
	}();


	
</script>

