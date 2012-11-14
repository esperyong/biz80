<%--
	modules/index.jsp
	author: wangtao@mochasoft.com.cn
	Description: 服务水平管理 - 主页
--%>
<%@page import="com.mocha.bsm.system.SystemContext"%>
<%@ page language="java" contentType="text/html;charset=UTF-8" errorPage="/modules/common/error.jsp"%>
<jsp:directive.page import="com.mocha.dev.ReqRes"/>
<jsp:directive.page import="com.mocha.bsm.itom.mgr.XmlCommunication"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.xml.WorkFormTypeVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.PageUtil"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="com.mocha.bsm.itom.view.UserDomainManage"/>
<jsp:directive.page import="com.mocha.bsm.itom.vo.UserDomainVO"/>
<jsp:directive.page import="com.mocha.bsm.itom.common.IConsts"/>
<jsp:directive.page import="com.mocha.bsm.itom.util.UserDomainHelper"/>
<jsp:directive.page import="java.util.Map"/>
<jsp:directive.page import="java.util.Iterator"/>
<jsp:directive.page import="com.mocha.bsm.itom.adapter.AdapterUtil"/>
<%@ include file="/modules/common/security.jsp"%>
<%
   ReqRes rr = new ReqRes(request, response);
   rr.encoding("UTF-8").nocache().security();
   String userdomainId = rr.param("userdomainId", null);
   List userDomainList = UserDomainManage.getInstance().getUserDomainListByDomainId(userDomainId);
   List workform_list = new ArrayList();

   if(!"-1".equals(portalDomainId)) {
   		workform_list = XmlCommunication.getInstance().query_workform_list(currentUserId, userDomainId[0]);
   }else if("-1".equals(portalDomainId) && userDomainList != null && userDomainList.size() > 0) {
   		if(rr.empty(userdomainId)) {
      		UserDomainVO domainVo = (UserDomainVO)userDomainList.get(0);
      		workform_list = XmlCommunication.getInstance().query_workform_list(currentUserId, domainVo.getUserDomainId());
   		}else {
   	   		workform_list = XmlCommunication.getInstance().query_workform_list(currentUserId, userdomainId);
   		}
   }
   
  /*
   WorkFormTypeVO workformvo = new WorkFormTypeVO();
   workformvo.setId("1");
   workformvo.setName("test");
   workformvo.setType(com.mocha.bsm.itom.common.IConsts.S_INCCIDENT);
   WorkFormTypeVO workformvo1 = new WorkFormTypeVO();
   workformvo1.setId("1-1");
   workformvo1.setName("test1");
   workformvo1.setType(com.mocha.bsm.itom.common.IConsts.S_INCCIDENT);
   WorkFormTypeVO workformvo2 = new WorkFormTypeVO();
   workformvo2.setId("1-2");
   workformvo2.setName("test2");
   workformvo2.setType(com.mocha.bsm.itom.common.IConsts.S_INCCIDENT);
   List list = new ArrayList();
   list.add(workformvo1);
   list.add(workformvo2);
   workformvo.setChildren(list);
   workform_list.add(workformvo);*/
%>
<HTML>
<HEAD>
<TITLE></TITLE>

<SCRIPT language=JavaScript src="<%=jsRootPath%>/common.js"></SCRIPT>
<script src="<%=jsRootPath %>/checkForm.js"></script>
<script type="text/javascript" src="<%=jsRootPath%>/loading.js"></script>
<script type="text/javascript">
/*
var g_loading = new Loading("<span class='word-blue'><%=i18n.key("data.submit.wait")%></span>",300,200,"yes",true,790,500,180,20);
function doStart(){
  g_loading.start();
}
function doStop(){
  g_loading.stop();
}
doStop();
*/

//alert('userdomainId:'+'<%=userdomainId%>');
</script>
</HEAD>
<BODY>
<style>
<!--
.table-bgline-bottom-gray {
	border-bottom-width: 1px;
	border-bottom-style: solid;
	border-bottom-color: #EAEAEA;
}
.mouseBeOffMe {
border-top:    1px  solid #b1b5b9;
border-bottom: 1px  solid #b1b5b9;
border-left:   1px  solid #b1b5b9;
border-right:  1px  solid #b1b5b9;
}

.mouseBeOnMe {
border-top:    0px  solid #b1b5b9;
border-bottom: 1px  solid #b1b5b9;
border-left:   1px  solid #b1b5b9;
border-right:  1px  solid #b1b5b9;
}
.zi1 {
	font-size: 12px;
	color: #3364AE;
	text-decoration: none;
}
.workform_mg{
	width:98%;
	
	margin:0 auto;
}
.workform_mg .wf_top_l{
	height:26px;
	background:url(<%=imgRootPath %>/main_head.png) 0px 0px no-repeat;
	padding-left:12px;
}
.workform_mg .wf_top_l .wf_top_r{
	background:url(<%=imgRootPath %>/main_head.png) right -52px no-repeat;
	padding-right:12px;
	height:26px;
}
.workform_mg .wf_top_l .wf_top_r .wf_top_m{
	background:url(<%=imgRootPath %>/main_head.png) 0px -26px repeat-x;
	height:26px;
	line-height:26px;
}
.workform_mg .wf_body{

}
.workform_mg .wf_body .wf_content{
	border: 0px 1px 1px 1px solid #cacaca;
	height:600px;
	padding:2px;
}
//-->
</style>
<div class="main-right" id="globalsettingmainright">
	<div class="manage-content">
		<div class="top-l">
			<div class="top-r">
				<div class="top-m"/>
			</div>
		</div>
		<div class="mid">
			<div class="h1">
				<span class="bold">当前位置：</span>
				<span>全局管理 / ITIL运维 / 工单设置</span>
			</div>
			<div class="panel-gray">
				<div class="panel-gray-top">
					<img src="<%=imgRootPath %>/kp-help-ico.GIF" width="13" height="13" align="absmiddle">&nbsp;<span class="zi1">帮助说明：当资源出现故障时，系统会根据工单触发策略自动触发流程，以向“ITIL运维”发送待办的形式提交给相关人员进行故障处理。</span>
				</div>
				<div class="panel-gray-content">
					<form name="loginForm" id="loginForm" action="" method="post" target="index_jsp">
						<div class="workform_mg">
							<div class="wf_top_l">
								<div class="wf_top_r">
									<div class="wf_top_m">
										<span class="zi" style="color:#ffffff;">所属<%=AdapterUtil.getDomainDisplayName()%>：</span>
	   			 						<select id="userDomain" name="userdomainId" class="zi" onchange="refreshIndex();">
        									<%
											Map<String, String> t_domainMap = UserDomainHelper.getAllDomain();
											for(Iterator<String> t_iter=t_domainMap.keySet().iterator(); t_iter.hasNext(); ){
												String t_domainId = t_iter.next();
												String t_domainName = t_domainMap.get(t_domainId);
										%>
												<option value=<%=t_domainId%>><%=t_domainName%></option>
										<%
											}
		
										%>
	   									</select>
									</div>
								</div>
							</div>
							<div class="wf_body">
								<div class="wf_content">
									<div style="width:20%;height:600px;overflow:auto;float:left;border-right:1px solid #cacaca;">
										<div><img src="<%=imgRootPath %>/kp-gongdancl.gif" width="22" height="22"><font class="zi">自动触发的工单列表</font></div>
										<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
											<%if(!rr.empty(workform_list)) {
												for(int i=0; i<workform_list.size(); i++) {
													WorkFormTypeVO vo = (WorkFormTypeVO)workform_list.get(i);
											%>
													<tr align="left">
														<td width="25">&nbsp;</td>
														<td width="13" height="22" align="left">
															<img src="<%=imgRootPath %>/zhankai.gif" name="showTree" id="<%=vo.getId() %>_true" width="10" height="9" <%if(!rr.equals(vo.getName(), "事故管理")) {%>style="display:none;"<%} %> onclick="DisplayYesOrNo(true, '<%=vo.getId() %>');" voId="<%=vo.getId() %>">
															<img src="<%=imgRootPath %>/plus.gif" name="showTree" id="<%=vo.getId() %>_false" width="10" height="11" <%if(rr.equals(vo.getName(), "事故管理")) {%>style="display:none;"<%} %> onclick="DisplayYesOrNo(false, '<%=vo.getId() %>');" voId="<%=vo.getId() %>"></td>
														<td colspan="2" style="line-height:22px;" height="22">&nbsp;<font class="zi" title="<%=vo.getName() %>"><%=PageUtil.ellipsisNvl(vo.getName(), 125) %></font></td>
													</tr>
		            								<%if(!rr.empty(vo.getChildren())) {
		            									List children = vo.getChildren();
		            									for(int j=0; j<children.size(); j++) {
		            										WorkFormTypeVO child = (WorkFormTypeVO)children.get(j);
		            								%>
		            										<tr align="left"  id="<%=vo.getId() %>_tr" <%if(!rr.equals(vo.getName(), "事故管理")) {%>style="display:none;"<%} %>>
					              								<td width="25">&nbsp;</td>
					              								<td width="10">&nbsp;</td>
														<td height="22"><img style="float:left;margin-top:5px;" src="<%=imgRootPath %>/news_bullet.gif" width="15" height="10"><font id = "<%=child.getId() %>"  class="zi" style='cursor:hand;' onclick="changeRightPage2('/bsmitom/modules/itpm/strategy/strategy_list.jsp','<%=child.getId() %>','<%=child.getName() %>','<%=child.getType() %>');" title="<%=child.getName() %>"><div style="height:22px;line-height:20px;float:left;"><%=child.getName()%></div></font>
														<img src="<%=imgRootPath %>/dot_12.gif" width="19" height="18" style="float:left;cursor:hand"  align="absmiddle" title="流程图" onclick="openProcessImage('<%=child.getId() %>');">
														</td>
					              								<td align="left"></td>
		            										</tr>
		            								<%} %>
		            								<%}}} %>
	            </table>
										
									</div>
									<div style="width:80%;height:600px;float:left;">
										<iframe id="index_right" name="index_right" width="100%" height="600" frameborder=0 valign="top" scrolling="no" src="<%=path %>/modules/common/blank.jsp"></iframe>
									</div>
									
								</div>
							</div>
						</div>
						
						

				
					</form>
				</div>
			</div>
		</div>
		<div class="bottom-l">
			<div class="bottom-r">
				<div class="bottom-m"/>
			</div>
		</div>
	</div>
</div>

<div id="queryresourcediv" class="pop-div ui-draggable" style="position:absolute; left:460px; top:120px; width:500px; z-index:3; display:none;">
	<div class="pop-top-l" style="cursor:none;">
		<div class="pop-top-r">
			<div class="pop-top-m">
				<span class="pop-top-title left">触发工单的资源</span>
			</div>
			<a title="关闭" class="win-ico win-close" onclick="document.getElementById('queryresourcediv').style.display = 'none';" />
		</div>
	</div>
	<div class="pop-middle-l">
		<div class="pop-middle-r">
			<div class="pop-middle-m">
				<div class="pop-content" style="position: static; overflow: hidden;">
					<div class="content" style="position: relative;">
						<iframe id="queryResoruceiframe" name="queryResoruceiframe" src="" width=100% height=410 frameborder=0 valign="top" scrolling="no" class="boder-all-blue"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="pop-bottom-l" style="position: relative;">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m"></div>
		</div>
	</div>
</div>

<!-- 提交到IFRAME-->
<IFRAME width=0 height=0  FRAMEBORDER=0  name="index_jsp"></IFRAME>
<div id="theEnd" style="position:relative"></div>
</BODY>
<script language="javascript">
function openProcessImage(workformId) {
	var itomDomainId = document.loginForm.userdomainId.value;
	openPreWindow("/bsmitom/modules/process_image.jsp?workformId="+workformId+"&userId=<%=currentUserId %>&itomDomainId="+itomDomainId,900,600,"processImage");
}
function changeRightPage(url,id) {
	document.getElementById('index_right').src = url;
	focusNodeFont(id);
	if(id != 'workform_Maintenance'){
		doStart();
	}
	//setHeight(getTotalHeight);
}
function changeRightPage2(url,id,name,workformType) {
	var itomDomainId = document.loginForm.userdomainId.value;
	document.getElementById('index_right').src = url+"?workformId="+id+"&workformName="+encodeURIComponent(name)+"&workformType="+workformType+"&itomDomainId="+itomDomainId;
	focusNodeFont(id);
	document.getElementById('queryresourcediv').style.display='none';
	//doStart();
}

function DisplayYesOrNo(flag, id) {
	if(flag) {
		document.getElementById(id+"_true").style.display="none";
		document.getElementById(id+"_false").style.display="";
		var array = document.getElementsByName(id+"_tr");
		if(array != undefined && array.length > 0) {
			for(i=0;i<array.length;i++){
				array[i].style.display="none";
			}
		}

	}else {
		document.getElementById(id+"_true").style.display="";
		document.getElementById(id+"_false").style.display="none";
		var array = document.getElementsByName(id+"_tr");
		if(array != undefined && array.length > 0) {
			for(i=0;i<array.length;i++){
				array[i].style.display="";
			}
		}
	}
}
function refreshIndex() {
	var doc = document;
	var t_showTrees = doc.getElementsByName('showTree');
	for(var i=0,len=t_showTrees.length; i<len; i++){
		var t_showTree = t_showTrees[i];
		DisplayYesOrNo(true, t_showTree.getAttribute('voId'));
	}
	doc.getElementById('queryresourcediv').style.display='none';
	var userdomainId = doc.getElementById('userDomain').value;
	doc.getElementById('index_right').src = '<%=path %>/modules/common/blank.jsp';
	//window.location.href = "index.jsp?userdomainId="+userdomainId+"&domainId=<%=portalDomainId %>";

}
</script>
<script>
<!--
function setHeight(theHeight,flag){
	if (theHeight > 550) {
		if("up_query" == flag){
			document.all["index_right"].height = theHeight - 13;
		}else{
			document.all["index_right"].height = theHeight + 35;
		}
	}else {
		document.all["index_right"].height = 600;
	}
	parent.changeleftheight(getTotalHeight());
	parent.refreshIframeHeight(getTotalHeight());
	//parent.setHeight(height);
}

function getTotalHeight(){
	var ele = document.getElementById("theEnd");
	// check it first.
	if (ele != null) { 	return ele.offsetTop; 	}
	return 0;
}
//-->
if(typeof(parent.changeleftheight) == 'function' && typeof(parent.refreshIframeHeight) == 'function'){
	parent.changeleftheight(getTotalHeight());
	parent.refreshIframeHeight(getTotalHeight());
}
</script>
</HTML>
