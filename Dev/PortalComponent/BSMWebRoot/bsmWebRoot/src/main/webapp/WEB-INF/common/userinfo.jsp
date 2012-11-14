<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mocha.bsm.system.CurrentUser" %>
<%@ page import="com.mocha.bsm.system.LoginInfo" %>
<%@ page import="com.mocha.bsm.system.NoLoginedUserException" %>
<%@ page import="com.mocha.bsm.admin.client.IUserClientMgr" %>
<%@ page import="com.mocha.bsm.admin.client.IRoleClientMgr" %>
<%@ page import="com.mocha.bsm.admin.client.IPageClientMgr" %>
<%@ page import="com.mocha.bsm.service.proxy.ServiceProxy" %>
<%@ page import="com.mocha.bsm.admin.client.UserPojo" %>

<%
	String userId = null;   //当前登陆用户ID
	String domainId = null; //当前登陆用户域ID
	String domainPageName = null; 
	boolean isAdmin = false;//是否admin用户
	boolean isConfigMgrRole = false;//是否配置管理员
	boolean isSystemAdmin = false;
	IRoleClientMgr roleMgr = (IRoleClientMgr) ServiceProxy.getService(IRoleClientMgr.class);
	IUserClientMgr userMgr = (IUserClientMgr) ServiceProxy.getService(IUserClientMgr.class);
	IPageClientMgr pageMgr = (IPageClientMgr) ServiceProxy.getService(IPageClientMgr.class); 
	try {
	  CurrentUser currentUser = LoginInfo.getCurrentUser(request);
	  if(currentUser != null){
	    userId = currentUser.getUserID();
	    UserPojo userPojo = userMgr.getUserByID(userId);
	    if(null != userPojo){
		    int userType = userPojo.getType();
		    if(UserPojo.S_TYPE_ADMIN == userType){
		    	isSystemAdmin = true;
		    	isAdmin = true;
		    }
	    }
	    if(!isAdmin){
	    	isAdmin = IUserClientMgr.DEFAULT_USER.equals(userId);
	    }
	    isConfigMgrRole = roleMgr.isContainConfigMgrRole(userId);
	    domainId = currentUser.getDomainID();
	  }
	  domainPageName = pageMgr.getDomainPageName();
	} catch (Throwable e) {
		// TODO:用户未登录，跳转到登陆页面
	}
%>
<script type="text/javascript">
	var userId = "<%=userId%>";
	var domainId = "<%=domainId%>";
	var isAdmin = <%=isAdmin%>;
	var domainPageName = "<%=domainPageName%>";
	var isConfigMgrRole = <%=isConfigMgrRole%>;
	var isSystemAdmin = <%=isSystemAdmin%>;
</script>
