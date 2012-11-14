<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<decorator:usePage id="colorpanel" />
 
<%
	String [] ColorHex=new String[]{"00","33","66","99","CC","FF"};
	String [] SpColorHex=new String []{"FF0000","00FF00","0000FF","FFFF00","00FFFF","FF00FF"};
	String colorTable="";
	for (int i=0;i<2;i++){
		for (int j=0;j<6;j++){
			colorTable=colorTable+"<tr height=\"12\">";
			if (i==0){
				colorTable=colorTable+"<td width=\"13\" value=\""+ColorHex[j]+ColorHex[j]+ColorHex[j]+"\" style=\"background-color:#"+ColorHex[j]+ColorHex[j]+ColorHex[j]+";border:1px solid #000\">";
			} else{
				colorTable=colorTable+"<td width=\"13\" value=\""+SpColorHex[j]+"\" style=\"background-color:#"+SpColorHex[j]+";border:1px solid #000\">";
			} 
			for (int k=0;k<3;k++){
				for (int l=0;l<6;l++){
					colorTable=colorTable+"<td width=\"13\" value=\""+ColorHex[k+i*3]+ColorHex[l]+ColorHex[j]+"\" style=\"background-color:#"+ColorHex[k+i*3]+ColorHex[l]+ColorHex[j]+";border:1px solid #000\">";
				}
			}
		}
	}
%>
 <page:applyDecorator name="blackpanel">  
 		<page:param name="id">colorPanel</page:param>
       <page:param name="content">
<%
	if(colorpanel.getProperty("headother")!=null){
		out.print(colorpanel.getProperty("headother"));
	}
%>

<!-- 调色板  -->
<div id="color_panel" style="width:267px;">
 <table id="colorTable1" width="267" border="0" cellspacing="0" cellpadding="0" style="border:1px #000000 solid;border-bottom:none;border-collapse: collapse" bordercolor="000000">
 	<tr height=30>
 		<td colspan=21 bgcolor=#cccccc>
		  <table cellpadding="0" cellspacing="1" border="0" style="border-collapse: collapse">
			<tr>
				<td width="3"></td>
				<td><input type="text" id="DisColor" size="6" disabled style="margin-top:5px;border:solid 1px #000000;background:#ffff00"></td>
				<td width="3"></td><td><input type="text" id="HexColor" size="7" readonly style="margin-top:5px;border:inset 1px;font-family:Arial;" value="#000000"></td>
			</tr>
		  </table>
		</td>
</table>
<table id="colorTable" width="267" border="1" cellspacing="0" cellpadding="0" style="border-collapse: collapse; border:1px solid #000000;cursor:hand;" >
<%=colorTable %>		
</table>
</div>
<%
	if(colorpanel.getProperty("footother")!=null){
		out.print(colorpanel.getProperty("footother"));
	}
%>
       </page:param>
     </page:applyDecorator>
<script type="text/javascript">


	var ColorPanel = function(){
		var colorpanel = new winPanel({
		    id:"colorPanel",
		    isautoclose:false,
		    isDrag:false
		},{
			winpanel_DomStruFn:"blackLayerLoad_winpanel_DomStruFn"
		});			  
		var $dis = $("#DisColor");
		var $hex = $("#HexColor");

		var tds = $("#colorTable td"); 
		//isClose点击颜色后是否关闭
		var isClose = false;
		var clickAfter = null;

	    function bodyClick(event){
	             var pos = colorpanel.getPosition();
	             var x = pos.left+colorpanel.getWidth();
	             var y  = pos.top+colorpanel.getHeight();
	             if(event.pageX>=pos.left && event.pageX<=x && event.pageY >=pos.top && event.pageY <=y){
	            	 	return;
	           	 }
	             $("body").unbind("click",bodyClick);                    
	             colorpanel.hidden();
	    }	

			
		   
        //绑定颜色按钮次数
		tds.bind("click",function(){
			var $td = $(this);
			var color = "#"+$td.attr("value");
			setBackColor($dis,color);
			$hex.val(color);
			if(isClose){
				colorpanel.hidden();
				 $("body").unbind("click",bodyClick); 
			}
			if(clickAfter){
				clickAfter(ColorPanel.getColor());
			}
			
		});

		
		function setBackColor (obj,colorVal){
			obj.css("backgroundColor",colorVal);
		}
		return{
				init:function(conf){
					setBackColor($dis,conf.color);
					$hex.val(conf.color);
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
					colorpanel.setPosition(conf.x,conf.y);
				},
				show:function(){
					colorpanel.show();
					 setTimeout(function(){
				        	$("body").bind("click",bodyClick);
			        },1000);					
				},
				close:function(){
					colorpanel.hidden();
					$("body").unbind("click",bodyClick); 
				},
				getColor:function(){
					var val =$hex.val();
					val = val.substring(1,val.length); 
					return val;
				}
		};

	}();

	
	
</script>

