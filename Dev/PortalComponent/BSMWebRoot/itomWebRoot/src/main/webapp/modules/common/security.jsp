<%String currentUserId = null;
 String[] userDomainId = null;
 
 currentUserId = "user-000000000000001";

 String portalDomainId = request.getParameter("domainId");
 
 String errorMessge =null;// com.mocha.bsm.itom.SystemValidate.loginValidate(request,currentUserId,portalDomainId);
 if(errorMessge == null){
   userDomainId = (String[])session.getAttribute("portalDomainId");
 }
 if(userDomainId==null){
 userDomainId = new String[1];
 userDomainId[0] = portalDomainId;
 }
 
 String path = request.getContextPath();
 String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
    
 com.mocha.bsm.itom.common.I18 i18n = com.mocha.bsm.itom.common.I18Factory.getI18();
 String theme_path = com.mocha.bsm.itom.ItpmConfig.get("theme_path");

 String imgRootPath = path + theme_path + "/image" + i18n.path();
 
 String cssRootPath = path + theme_path + "/css";
 
 String jsRootPath = path + theme_path + "/js"; 
 
 String flashPath = path + theme_path + "/flash/";
 
 String musicPath = path + theme_path + "/music/"; 

 if(errorMessge != null){
 	//session.invalidate();%>
	<script type="text/javascript">
		function getFirstTopWindow(theWindow){
			if(theWindow.parent && theWindow != theWindow.parent ){
				return getFirstTopWindow(theWindow.parent);
			}
			return theWindow;		
		}
		
		function getFirstOpenerWindow(theWindow){
		try{
			while(theWindow.opener && theWindow != theWindow.opener){
				var nexttheWindow = theWindow.opener;
				if(theWindow != window) {
					theWindow.close();
				}
				theWindow = nexttheWindow;
			}
		}catch(e){}
			return theWindow;
		}
		
		function getFirstWindow(theWindow){
		try{
			if(theWindow.opener && theWindow != theWindow.opener){
				var theOpenerWindow = getFirstOpenerWindow(theWindow);				
				return getFirstWindow(theOpenerWindow)
			} else if(theWindow.parent && theWindow != theWindow.parent){
				theWindow = getFirstTopWindow(theWindow);
				return getFirstWindow(theWindow)
			}else{
				return theWindow;
			}
		}catch(e){}
		}
		
		function goToFirst() {
			window.showModalDialog('<%=basePath %>/mochabsm/modules/system/window.jsp?promptType=longAlert&prompt=<%=errorMessge%>',window,'dialogWidth:419px;dialogHeight:165px;help:no;center:yes;resizable:no;status:no;scroll:no');
			var isCloseThis = false;
			var topWindow = getFirstTopWindow(window);
			
			if(topWindow.opener){
				isCloseThis = true;
			}
			var rootWindow = getFirstWindow(window);
			try{
			rootWindow.location.href = "/";	
			}catch(e){}
			if(isCloseThis){
			  topWindow.close();
			}
		}
		goToFirst();
		
		
	</script>
<%
com.mdcl.mocha.bpm.portal.common.util.WebUtil.clearCookies(request, response);
return;
}
%>
