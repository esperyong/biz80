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
		if(key.indexOf("topBtn_Index")!=-1){
			leftPanelCount++;
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>

<div id="<decorator:getProperty property="id" />" style="<decorator:getProperty property="width"/>">
	<div class="left-panel-open">
		<div class="left-panel-l" index="0" style="width:100%">
			<div class="left-panel-r">
				<div class="left-panel-m">
					<span class="left-panel-title">标题部分</span>
				</div>	
			</div>
		</div>
		<div class="left-panel-content" style="height:200px;display:block;">内容</div>
	</div>

</div>






</div>
</body>
</html>