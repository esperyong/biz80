<%@page import="java.util.ArrayList"%>
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
<decorator:usePage id="tabpage" />
<%	

	String cls = tabpage.getProperty("cls")==null  ? "tab-grounp" :tabpage.getProperty("cls"); 
	String tabHander = tabpage.getProperty("tabHander") ;
    String width = tabpage.getProperty("width");
    String tabBarWidth = tabpage.getProperty("tabBarWidth");
    String height = tabpage.getProperty("height");
    
   
    String contentWidth = "";
    if(width !=null ){
	    if(width.indexOf("px")==-1 && width.indexOf("%")==-1){
	    	width = width+"px";
	    }else{
	    	contentWidth = width.replaceAll("px","");
	    	contentWidth = contentWidth.replaceAll("%","");
	    }
    }
    
    if(tabBarWidth != null){
	    if(tabBarWidth.indexOf("px") == -1 && tabBarWidth.indexOf("%") == -1){
	    	tabBarWidth = tabBarWidth+"px";
	    }
    }
    
    if(height != null){
	    if(height.indexOf("px") ==-1 && height.indexOf("%")==-1){
	    	height = height+"px";
	    }
    	
    }
    
    
    
	
	try{
		contentWidth = String.valueOf(Integer.parseInt(contentWidth)-3);
	}catch(Exception e){
	};
	
	String current = tabpage.getProperty("current");
	
	boolean isunknow = tabpage.getProperty("content") !=null ? true:false;
	
	JSONArray tabHeaderArray = JSONArray.fromObject(tabHander);
	
	String [] contents = tabpage.getPropertyKeys();
	int contentsCount =0;
	for(int i=0;i<contents.length;i++){
		if(contents[i].indexOf("content")!=-1){
			contentsCount++;
		}
	}
	List<JSONObject> blackbuttons = null;
	String blackButton = tabpage.getProperty("blackButton");	
	if(blackButton != null){
		blackbuttons = new ArrayList<JSONObject>();
		JSONArray blackButtonArray = JSONArray.fromObject(blackButton);
		for(int i=0;i<blackButtonArray.size();i++){
			JSONObject jsonObject = JSONObject.fromObject( blackButtonArray.get(i));
			blackbuttons.add(jsonObject);
		}
	}
	
	List<JSONObject> rightbuttons = null;
	String rightButton = tabpage.getProperty("rightButton");	
	if(rightButton != null){
		rightbuttons = new ArrayList<JSONObject>();
		JSONArray rightButtonArray = JSONArray.fromObject(rightButton);
		for(int i=0;i<rightButtonArray.size();i++){
			JSONObject jsonObject = JSONObject.fromObject( rightButtonArray.get(i));
			rightbuttons.add(jsonObject);
		}
	}
	
	String background = tabpage.getProperty("background");	
	if(background==null){
		background = "#000";
	}
	
%>
<div id="<decorator:getProperty property="id"/>" class="tab" style="width:<%=width %>;height:<%=height %>">
 <div  class="<%=cls %>" style="width:<%=width %>">
	 <div class="tab-mid" style="width:<%=tabBarWidth %>">
    	 	<div class="tab-foot">
      			<ul style="position:relative;">
      			<%
	      			for (int i = 0; i < tabHeaderArray.size(); i++) {
	      				Object o = tabHeaderArray.get(i);
						JSONObject jsonObject = JSONObject.fromObject(o);
						String currentCls="";
						if(current.equals(""+(i+1))){
							currentCls = "class=\"nonce\"";
						}
				%>
      				<li <%=currentCls %> id="<%=jsonObject.get("id") %>" style="display:<%=jsonObject.get("display")%>;"> 
      					<div class="tab-l">
      						<div class="tab-r">
      							<div class="tab-m">
      								<a href="javascript:void(0)" ><%=jsonObject.get("text") %></a>
      							</div>
      						</div>
      					</div>
      				</li>
				<%		
	      			}
      			%>
      			</ul>
    		</div>
	</div>	
	
	
	<%
		String otherButton = tabpage.getProperty("otherButton");	
		if(otherButton!=null){
			out.print(otherButton);
		}
	%>
	
 	<%
	 	if(blackbuttons!=null){
	 		for(int i=0;i<blackbuttons.size();i++){
	 			JSONObject jo = blackbuttons.get(i);
	 %>
	 	<span class="black-btn-l right" id="<%=jo.get("id") %>"><span class="btn-r"><span class="btn-m"><a><%=jo.get("text") %></a></span></span></span>
	 <%
	 		}
	 	}
 		
 	%>
 	
 	<%
	 	if(rightbuttons!=null){
	 		for(int i=0;i<rightbuttons.size();i++){
	 			JSONObject jo = rightbuttons.get(i);
	 			String title = org.apache.commons.lang.StringUtils.isNotBlank((String)jo.get("title"))? "title="+jo.get("title"): "";
	 			String text = org.apache.commons.lang.StringUtils.isNotBlank((String)jo.get("text"))?  (String)jo.get("text"): "";
	 %>
		<div class="f-right tab-btn" ><a id="<%=jo.get("id") %>" <%=title%> style="color: #fff; margin-left:5px; vertical-align:middle;cursor: pointer;"><span class="<%=jo.get("ico") %>"></span><%=text%></a></div>	 
	 <%
	 		}
	 	}
 		
 	%>
</div>

    		<%
    			if(isunknow){
    				String content = tabpage.getProperty("content") ;
    		%>
    				<div class="tab-content" style="width:<%=width %>"><%=content %></div>
    		<%		 
    			}else{
    				for(int i=1;i<=contentsCount;i++){
	    				String content = tabpage.getProperty("content_"+i) ;
	    				String currentContent = "none";
						if(current.equals(""+(i))){
							currentContent="block";
						}    				
    				
    		%>
    			<div class="tab-content" style="display:<%=currentContent %>;width:<%=width %>;background:<%=background %>"><%=content %></div>
    		<%
    				}
    			}
    		%>
</div>