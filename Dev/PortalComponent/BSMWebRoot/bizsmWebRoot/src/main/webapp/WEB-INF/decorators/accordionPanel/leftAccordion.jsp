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
<div id="<decorator:getProperty property="id" />" style="width:<decorator:getProperty property="width"/>">

	<%
		String currentIndex = panel.getProperty("currentIndex");
		int current = Integer.parseInt(currentIndex);
		String height = "0px";
		for(int i=0;i<leftPanelCount;i++){
			String display = "none";
			String open = "close";
			if(current==i){
				display="block";
				open="open";
				height = panel.getProperty("height");
			}else{
				display="none";
				open="close";
				height="0px";
			}
	%>
		<div class="left-panel-<%=open %>" style="width:100%">
			<div class="left-panel-l" index="<%=i %>" >
				<div class="left-panel-r">
					<div class="left-panel-m">
						<span class="left-panel-title"><%=panel.getProperty("panelTitle_"+i) %></span>
					</div>	
				</div>
			</div>
			<div class="left-panel-content" style="height:<%=height %>;display:block;" display="<%=display %>"><%=panel.getProperty("panelContent_"+i) %></div>
		</div>	
	
	<%			
		}
	%>
</div>
