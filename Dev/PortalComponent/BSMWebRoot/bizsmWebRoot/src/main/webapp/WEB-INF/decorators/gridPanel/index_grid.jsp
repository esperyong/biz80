<%@ page language="java" contentType="text/html; charset=utf-8"    pageEncoding="utf-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="net.sf.json.JSONArray"%>
<%@page import="net.sf.json.JSONObject"%>
<%@page import="net.sf.json.util.JSONBuilder"%>
<%@page import="net.sf.json.JSONString"%>
<%@page import="org.apache.struts2.json.JSONResult"%>
<%@taglib prefix="decorator"	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="gridpage" />
<%	
	String gridhead = gridpage.getProperty("gridhead") ;
	String gridcontent = gridpage.getProperty("gridcontent") ;
	String width = gridpage.getProperty("width") ;
	
	String height = gridpage.getProperty("height") ;
	if(height==null){
		height = "auto";
	}
	
	
	
	String lineHeight = gridpage.getProperty("lineHeight");//行高
	if(lineHeight == null || "".equals(lineHeight)){
		lineHeight = "20px";
	}
	
	
	String linenum = gridpage.getProperty("linenum");//显示行数
	if(linenum==null || "".equals(linenum)){
		linenum = "20";	
	}
	
	JSONArray gridHeadArray = JSONArray.fromObject(gridhead);
	JSONArray gridContentArray = JSONArray.fromObject(gridcontent);
	List<String> colIds = new ArrayList<String>();
	
	Map<String,String> hideColMap = new HashMap<String,String>();
	
%>
 <div id="<%=gridpage.getProperty("id") %>" class="<%=gridpage.getProperty("tableCls") %>" style="width:<%=gridpage.getProperty("width")%>">
		<div class="formhead">
			<table>
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
									colId = (String) jsonObject.get("colId");
									text = jsonObject.get("colId")!= null ? (String)jsonObject.get("text") : "";
									if(jsonObject.get("hidden")!=null){
										hidden = "none";
										hideColMap.put(colId,colId);
									}
									colIds.add(colId);
								}
						%>
							<th colId="<%=colId %>"  style="display:<%=hidden %>">
								<div class="theadbar">
									<div class="theadbar-name" style="padding-right:0px">
										<span style="width:100%"><%=text %></span>
									</div>
								</div>
							</th>
						<%
							}						
						%>
					</tr>
				</thead></table>
		</div>
		<div class="formcontent" style="height:<%=height%>">
			<table>
				<%
									int ilen = gridContentArray.size();//行数
									%>
				<tbody rowsable="<%=ilen%>">
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
							<tr class="<%=background %>">
						<%
								String display = "";
								column = colIds.size();
								for(int j=0;j<column;j++){
									String colId = colIds.get(j);
									String text =jo.get(colId).toString();
									display = hideColMap.get(colId)!=null ? "display:none" :"";
						%>
								<td colId="<%=colId %>" style="<%=display %>;">
									<span style="width:100%"><%=text %></span>
								</td>
						<%									
								}
						%>
							</tr>
						<%
							}					
						//空白行
							if(linenum!=null && ilen != 0){
								String background = "";
								int nums = Integer.parseInt(linenum);
								if(nums-ilen>0){
									for(int i=0;i<nums-ilen;i++){
										if(isOdd){
											background = "white";
											isOdd = false;
										}else{
											background = "gray";
											isOdd = true;
										}					
										
										%>
										<tr class="<%=background %>" style="height:<%=lineHeight %>">
									<%
												for(int j=0;j<gridHeadArray.size();j++){
														Object o = gridHeadArray.get(j);
														JSONObject jsonObject = JSONObject.fromObject(o);
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
						
									if(ilen==0){
								   		if(height!=null){
								   			if(height.indexOf("%")==-1 && !"auto".equals(height)){
									   			String strH = height.replaceAll("px","");
									   			height = Integer.parseInt(strH)-50+"px";
								   			}
								   		}										
									%>
									   	<tr>
								          <td class="nodata" height="<%=height %>" align="center">
											 <span class="nodata-l">
											 	  <span class="nodata-r">
											    	   <span class="nodata-m"> <span class="icon">当前无数据</span> </span>
											      </span>
											 </span>					       
										  </td>
								        </tr>									
									
									<%	
										
										
										
									}
						%>
									
				</tbody>
			</table>
		</div>
  </div>
