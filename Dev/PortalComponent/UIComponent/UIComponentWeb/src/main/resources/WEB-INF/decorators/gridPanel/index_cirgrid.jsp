<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
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
		boolean gridJsonError = false;
		if(height==null){
			height="auto";
		}
		
		
		String lineHeight = gridpage.getProperty("lineHeight");//行高
		if(lineHeight == null || "".equals(lineHeight)){
			lineHeight = "20px";
		}
		
		
		String linenum = gridpage.getProperty("linenum");//显示行数
		if(linenum==null || "".equals(linenum)){
			linenum = "20";	
		}		
		JSONArray gridHeadArray = null;
		JSONArray gridContentArray = null;
		try{
			if(null == gridhead || "".equals(gridhead)){
				gridhead = "[]";
			}
			gridHeadArray = JSONArray.fromObject(gridhead);
		}catch(Throwable e){
			gridHeadArray = new JSONArray();
		}
		try{
			if(null == gridcontent || "".equals(gridcontent)){
				gridcontent = "[]";
			}
			gridContentArray = JSONArray.fromObject(gridcontent);
		}catch(Throwable e){
			gridContentArray = new JSONArray();
			gridJsonError = true;
		}
		List<String> colIds = new ArrayList<String>();
		
		Map<String,String> hideColMap = new HashMap<String,String>();
	
%>
<div id="<%=gridpage.getProperty("id") %>" class="<%=gridpage.getProperty("tableCls") %>">
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
										String colId = "";
										String hidden ="";
										if(jsonObject.get("colId")!=null){
											colId = jsonObject.get("colId").toString();
											text = jsonObject.get("text")!= null ? jsonObject.get("text").toString() : "";
											if(jsonObject.get("hidden")!=null){
												hidden = "none";
												hideColMap.put(colId,colId);
											}
											colIds.add(colId);
										}
								%>
									<th colId="<%=colId %>"  style="display:<%=hidden %>">
										<div class="theadbar">
											<div class="theadbar-name">
												<span style="float:left;color:#fff;font-weight:bolder;display:inline-block;width:100%"><%=text %></span>
											</div>
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
									<%
									int ilen = gridContentArray.size();//行数
									%>
		<table class="hundred"><tbody rowsable="<%=ilen%>" lineHeight="<%=lineHeight %>">
						<%
							
							int column = 0;			
							boolean isOdd = true;
							for (int i = 0; i < ilen; i++) {
								JSONObject jo = JSONObject.fromObject(gridContentArray.get(i));
								String background = "";
								if(isOdd){
									background = "white"; isOdd = false;
								}else{
									background = "gray"; isOdd = true;
								}
						%>
							<tr class="<%=background %>" style="height:<%=lineHeight %>" lineHeight="<%=lineHeight %>">
						<%
								String display = "";
								column = colIds.size();
								for(int j=0;j<column;j++){
									String colId = colIds.get(j);
									String text = "";
									if(jo.get(colId)!=null){
										text=jo.get(colId).toString();
									}
									display = hideColMap.get(colId)!=null ? "display:none" :"";
						%>
								<td colId="<%=colId %>" style="<%=display %>;"><span style="width:100%"><%=text %></span></td>
						<%									
								}
						%>
							</tr>
						<%
							}					
						   //如果指定可以显示空白行，并且当前有数据的行数不为0
							if(linenum!=null && ilen != 0){
								String background = "";
								int nums = Integer.parseInt(linenum);
								if(nums-ilen>0){
									for(int i=0;i<nums-ilen;i++){
										if(isOdd){
											background = "white"; isOdd = false;
										}else{
											background = "gray"; isOdd = true;
										}							
							%>
								<tr class="<%=background %>" style="height:<%=lineHeight %>" lineHeight="<%=lineHeight %>">
							<%
											for(int j=0;j<gridHeadArray.size();j++){
												JSONObject jsonObject = JSONObject.fromObject(gridHeadArray.get(j));
												String colId = colIds.get(j);
							%>
									<td colId="<%=colId %>"></td>
							<%				
											}
							%>
								</tr>
							<%
									}
								}
							}
						   	
						   	if(gridJsonError || (ilen == 0) ){
						   		
						   		if(height!=null){
						   			if(height.indexOf("%")==-1 && !"auto".equals(height)){
							   			String strH = height.replaceAll("px","");
							   			height = Integer.parseInt(strH)-50+"px";
						   			}
						   		}
							   	%>
							   	<tr nodate="nodate">
						          <td class="nodata" height="<%=height %>" align="center">
									 <span class="nodata-l">
									 	  <span class="nodata-r">
									    	   <span class="nodata-m"><span class="icon"><%=gridJsonError ? "表格内容格式错误":"当前无数据" %></span></span>
									      </span>
									 </span>					       
								  </td>
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
