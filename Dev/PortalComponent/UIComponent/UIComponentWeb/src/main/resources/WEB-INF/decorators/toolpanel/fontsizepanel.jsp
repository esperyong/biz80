<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<decorator:usePage id="fontsizepanel" />


 <page:applyDecorator name="blackpanel">  
 		<page:param name="id">fontsizePanel</page:param>
       <page:param name="content">
<%
	if(fontsizepanel.getProperty("headother")!=null){
		out.print(fontsizepanel.getProperty("headother"));
	}

	String fontsizekind = fontsizepanel.getProperty("fontsizekind") ;
	
%>

<!-- 线粗细-->


<div id="fontsizepanel" style="width:75px">
<select id="fontsizeselect" size="8" style="width:75px">
<%
	String[] fontsizes = fontsizekind.split(",");
	for(int i=0;i<fontsizes.length;i++){
		String fontsize = fontsizes[i];
	%>
		<option value="<%=fontsize %>"><%=fontsize %></option>
	 <%	
	} %>
	</select>
</div>

<%
	if(fontsizepanel.getProperty("footother")!=null){
		out.print(fontsizepanel.getProperty("footother"));
	}
%>
       </page:param>
     </page:applyDecorator>
<script type="text/javascript">
	var FontSizePanel = function(){
			var fontsizepanel = new winPanel({
			    id:"fontsizePanel",
			    isautoclose:false,
			    isDrag:false
			},{
				winpanel_DomStruFn:"blackLayerLoad_winpanel_DomStruFn"
			});			  
	
			//isClose点击字号后是否关闭
			var isClose = false;
			var clickAfter = null;
			var currentSize = null;
		    function bodyClick(event){
	             var pos = fontsizepanel.getPosition();
	             var x = pos.left+fontsizepanel.getWidth();
	             var y  = pos.top+fontsizepanel.getHeight();
	             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
	            	 	return;
	           	 }
	             $("body").unbind("click",bodyClick);                    
	             fontsizepanel.hidden();
			}	

		    var $select = $("#fontsizeselect");
	        //绑定选中字号
			$select.bind("click",function(){
				if(isClose){
					fontsizepanel.hidden();
					 $("body").unbind("click",bodyClick); 
				}
				if(clickAfter){
					clickAfter(FontSizePanel.getSize());
				}
			});

	        //设置当前线条
			function setCurrentSize(size){
				$select.val(size);
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
				fontsizepanel.setPosition(conf.x,conf.y);
			},
			show:function(){
				fontsizepanel.show();
				 setTimeout(function(){
			        	$("body").bind("click",bodyClick);
		        },1000);					
			},
			close:function(){
				fontsizepanel.hidden();
				$("body").unbind("click",bodyClick); 
			},
			getSize:function(){
				return $select.val();
			}
		};
	}();


	
</script>

