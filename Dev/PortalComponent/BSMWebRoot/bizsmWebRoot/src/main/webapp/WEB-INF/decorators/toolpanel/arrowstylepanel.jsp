<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<decorator:usePage id="arrowstylepanel" />

 <page:applyDecorator name="blackpanel">  
 		<page:param name="id">arrowstylepanel</page:param>
       <page:param name="content">
<%
	if(arrowstylepanel.getProperty("headother")!=null){
		out.print(arrowstylepanel.getProperty("headother"));
	}
%>

<!-- 线粗细-->
<div id="arrowstyle_panel" style="width:130px">
<table id="arrowstyleTable" style="width:130px">
<% for(int i=1;i<5;i++){ %> 
<tr>
	<td>
		<a value="style<%=i%>" num="<%=i%>" class="drawline drawline-arrow-0<%=i%>"></a></span>
	</td>
</tr> 
<% } %>
</table>
</div>

<%
	if(arrowstylepanel.getProperty("footother")!=null){
		out.print(arrowstylepanel.getProperty("footother"));
	}
%>
       </page:param>
     </page:applyDecorator>
<script type="text/javascript">
	var ArrowStylePanel = function(){
			var arrowstylepanel = new winPanel({
			    id:"arrowstylepanel",
			    isautoclose:false,
			    isDrag:false
			},{
				winpanel_DomStruFn:"blackLayerLoad_winpanel_DomStruFn"
			});			  
	
			var as = $("#arrowstyleTable a"); 
			//isClose点击颜色后是否关闭
			var isClose = false;
			var clickAfter = null;
			var currentSize = null;
		    function bodyClick(event){
	             var pos = arrowstylepanel.getPosition();
	             var x = pos.left+arrowstylepanel.getWidth();
	             var y  = pos.top+arrowstylepanel.getHeight();
	             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
	            	 	return;
	           	 }
	             $("body").unbind("click",bodyClick);                    
	             arrowstylepanel.hidden();
			}	

	        //绑定颜色按钮次数
			as.bind("click",function(){
				var $a = $(this);
				setCurrentSize($a);
				if(isClose){
					arrowstylepanel.hidden();
					 $("body").unbind("click",bodyClick); 
				}
				if(clickAfter){
					clickAfter(ArrowStylePanel.getSize());
				}
			});

	        //设置当前线条
			function setCurrentSize($a){
				if($.isString($a)){
					$a = $("#arrowstyleTable a[value='"+$a+"']");
				}
				
				var num = $a.attr("num");
				if(currentSize!=null){
					var lastnum = currentSize.attr("num");
					currentSize.removeClass("drawline-arrow-"+lastnum+"-on");
				}
				$a.addClass("drawline-arrow-"+num+"-on");
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
				arrowstylepanel.setPosition(conf.x,conf.y);
			},
			show:function(){
				arrowstylepanel.show();
				 setTimeout(function(){
			        	$("body").bind("click",bodyClick);
		        },1000);					
			},
			close:function(){
				arrowstylepanel.hidden();
				$("body").unbind("click",bodyClick); 
			},
			getSize:function(){
				return currentSize.attr("value");
			}
		};
	}();


	
</script>

