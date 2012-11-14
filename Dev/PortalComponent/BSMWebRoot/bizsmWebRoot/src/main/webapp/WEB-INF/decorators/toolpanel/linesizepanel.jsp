<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<decorator:usePage id="linesizepanel" />


 <page:applyDecorator name="blackpanel">  
 		<page:param name="id">linesizePanel</page:param>
       <page:param name="content">
<%
	if(linesizepanel.getProperty("headother")!=null){
		out.print(linesizepanel.getProperty("headother"));
	}
%>

<!-- 线粗细-->
<div id="linesize_panel" style="width:170px">
<table id="lineSizeTable" style="width:170px">
<%
	String[] lineSize = new String[]{"0.75","1","2.25","3","4.5","6"};
	for(int i=0;i<lineSize.length;i++){
		String linesize = lineSize[i];
	%>
		<tr>
			<td>
				<span style="float:left"><%=linesize %>磅</span>
				<span style="float:right">
					<a style="display:inline-block" value="<%=linesize %>" num="<%=i+1 %>" class="drawline drawline-<%=i+1 %>"></a>
				</span>
			</td>
		</tr>
	 <%	
	} %>
</table>
</div>

<%
	if(linesizepanel.getProperty("footother")!=null){
		out.print(linesizepanel.getProperty("footother"));
	}
%>
       </page:param>
     </page:applyDecorator>
<script type="text/javascript">
	var LinesizePanel = function(){
			var linesizepanel = new winPanel({
			    id:"linesizePanel",
			    isautoclose:false,
			    isDrag:false
			},{
				winpanel_DomStruFn:"blackLayerLoad_winpanel_DomStruFn"
			});			  
	
			var as = $("#lineSizeTable a"); 
			//isClose点击颜色后是否关闭
			var isClose = false;
			var clickAfter = null;
			var currentSize = null;
		    function bodyClick(event){
	             var pos = linesizepanel.getPosition();
	             var x = pos.left+linesizepanel.getWidth();
	             var y  = pos.top+linesizepanel.getHeight();
	             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
	            	 	return;
	           	 }
	             $("body").unbind("click",bodyClick);                    
	             linesizepanel.hidden();
			}	

	        //绑定颜色按钮次数
			as.bind("click",function(){
				var $a = $(this);
				setCurrentSize($a);
				if(isClose){
					linesizepanel.hidden();
					 $("body").unbind("click",bodyClick); 
				}
				if(clickAfter){
					clickAfter(LinesizePanel.getSize());
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
				setCurrentSize(conf.size);
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
				linesizepanel.setPosition(conf.x,conf.y);
			},
			show:function(){
				linesizepanel.show();
				 setTimeout(function(){
			        	$("body").bind("click",bodyClick);
		        },1000);					
			},
			close:function(){
				linesizepanel.hidden();
				$("body").unbind("click",bodyClick); 
			},
			getSize:function(){
				return currentSize.attr("value");
			}
		};
	}();


	
</script>

