<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONString"%>
<%@page import="org.apache.struts2.json.JSONResult"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="gridpage" />
<%	
	String gridhead = gridpage.getProperty("gridhead") ;
	String gridcontent = gridpage.getProperty("gridcontent") ;
	String width = gridpage.getProperty("width") ;
	String height = gridpage.getProperty("height") ;
	JSONArray gridHeadArray = JSONArray.fromObject(gridhead);
	JSONArray gridContentArray = JSONArray.fromObject(gridcontent);
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>Insert title here</title>
</head>
<body>
<div id="<%=gridpage.getProperty("id") %>" class="<%=gridpage.getProperty("tableCls") %>" style="width:<%=gridpage.getProperty("width")%>">
	<div class="roundedform-top">
		<div class="top-right">
			<div class="top-min">
				<table class="hundred">
					  <thead>
						     <tr>
								<%
									for (int i = 0; i < gridHeadArray.size(); i++) {
										Object o = gridHeadArray.get(i);
										JSONObject jsonObject = JSONObject.fromObject(o);
										String text = "";
										if(jsonObject.get("text")!=null){
											text = (String) jsonObject.get("text");
										}
								%>						     
							      	<th>
							      		<div class="theadbar">
											<div class="theadbar-name"><%=text %></div>
										</div>
									</th>
								<%
									}						
								%>									
							</tr>
					 </thead>
				 </table>
			</div>
		</div>
	</div>
	<div class="roundedform-content" style="height:<%=height %>;">
		<table class="hundred" ><tbody>
			<%
				for (int i = 0; i < gridContentArray.size(); i++) {
					Object o = gridContentArray.get(i);
					JSONArray trArray = JSONArray.fromObject(o);
					String background = "gray";
					if(i%2==0){
						background="white";
					}
			%>
				<tr class="<%=background %>">
			<%
					for(int j=0;j<trArray.size();j++){								
						JSONObject jsonObject = JSONObject.fromObject(trArray.get(j));
						String text = (String) jsonObject.get("text");
						String value = (String) jsonObject.get("value");
						
			%>
						<td value="<%=value %>"><span><%=text %></span></td>
			<%			
					}
			%>
				</tr>
			<%
				}						
			%>	
		</tbody></table>
	</div>
	<div class="roundedform-bottom">
		<div class="bottom-right">
			<div class="bottom-min"></div>
		</div>
	</div>		
</div>


 
</body>
</html>