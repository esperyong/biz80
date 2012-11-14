<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="panel" />
<%
	String [] keys = panel.getPropertyKeys();

	int leftPanelCount = 0;
	for(int i=0;i<keys.length;i++){
		String key = keys[i];
		if(key.indexOf("panelIndex")!=-1){
			leftPanelCount++;
		}
	}
%>
<div id="<decorator:getProperty property="id" />" >

	<%
		String currentIndex = panel.getProperty("currentIndex");
		int current = Integer.parseInt(currentIndex);
		String height = "0px";
		String padding = "0px";
		String overflow = "visible";
		for(int i=0;i<leftPanelCount;i++){
			String display = "none";
			String open = "close";
			if(current==i){
				display="block";
				open="open";
				
			}else{
				display="none";
				open="close";
				//height="0px";
			}
			height = panel.getProperty("height");
			padding = panel.getProperty("padding_"+i);
			if(!("").equals(panel.getProperty("panelOverFlow_"+i))){
				overflow = panel.getProperty("panelOverFlow_"+i);
			}
	%>
	<div class="tree-panel-<%=open %>" style="width:<decorator:getProperty property="width"/>" index="<%=i %>">
		<div class="tree-panel-top" index="<%=i %>">
		   <div class="<%=panel.getProperty("panelIco_"+i) %>"></div>
		   <span class="tree-panel-title"><%=panel.getProperty("panelTitle_"+i) %></span>
		</div>
		<div class="tree-panel-content" style="width:<decorator:getProperty property="width"/>;height:<%=height %>;overflow:<%=overflow%>;padding:<%=padding%>;" state="<%="collect".equals(display)?"collect":"expend"%>"><%=panel.getProperty("panelContent_"+i) %></div>
	</div>
	
		<%			
		}
	%>

	
</div>
