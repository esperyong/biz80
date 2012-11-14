<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%@ include file="/WEB-INF/common/userinfo.jsp" %>
<title>发现页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.countdown.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.blockUI.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript">
  var ctxpath = "${ctx}";
	function resizeFrameHeight() {
	  var ifm= document.getElementById("iframe_discovery");
	  var subWeb = document.frames ? document.frames["iframe_discovery"].document : ifm.contentDocument;
	  if(ifm != null && subWeb != null) {
	    ifm.height = subWeb.body.scrollHeight;
	  }
	  parent.resizeFrameHeight();
	};
</script>
<script type="text/javascript" src="${ctx}/js/discovery/handworkAdd.js" ></script>
</head>
<body>
<div class="loading" id="loading" style="display:none;">
  <div class="loading-l">
    <div class="loading-r">
      <div class="loading-m"><span class="loading-img"><s:text name="page.loading.msg" /></span></div>
   </div>
  </div>
</div> 
<form name="form1" id="form1" method="post" target="iframe_discovery">

<div id="find-right">
<div class="h1"><span class="title">单个添加</span></div>
<div class="h2"><div class="ico-title ico-title-explain">1.只能添加路由器、交换机、服务器等设备。2. 设备直接入资源库。3. 只能监控设备的可用性和响应时间。</div></div>
  <div>
	  <page:applyDecorator name="accordionPanel">
				<page:param name="id">panel_disc_domain</page:param>
				<page:param name="title">1.选择所属<%=domainPageName%></page:param>
				<page:param name="height"></page:param>
				<page:param name="width">690px</page:param>
				<page:param name="cls">fold</page:param>
				<page:param name="display"></page:param>
	
			  	<page:param name="content">
					<ul class="fieldlist">
						<li>
							<span class="" style="word-break:break-all;">所属<%=domainPageName%></span>：<span><s:select id="domainId" name="domainId" list="allDomainList" listKey="ID" listValue="name" ></s:select>
							<span class="red">*</span><span class="ico ico-what" title="待发现资源的所属<%=domainPageName%>，设置其管理权限。"></span></span>
						</li>
					</ul>
				</page:param>		  
	  </page:applyDecorator>
	  <page:applyDecorator name="accordionPanel">
				<page:param name="id">panel_disc_info</page:param>
				<page:param name="title">2.填写发现信息</page:param>
				<page:param name="height"></page:param>
				<page:param name="width">690px</page:param>
				<page:param name="cls">fold</page:param>
				<page:param name="display"></page:param>
	
			  	<page:param name="content">
					<ul class="fieldlist">
						<li><span class="field-middle">设备名称</span>：<input class="validate[required[设备名称],length[0,50,设备名称],noSpecialStr[设备名称]]" type="text" id="resourceName" name="resourceName" value="${resourceName}"/><span class="red">*</span>
						</li>
						<li><span class="field-middle">IP地址</span>：<input class="validate[required[IP地址],ipAddress]" type="text" id="ipAddress" name="ipAddress" value="${ipAddress}"/><span class="red">*</span>
						</li>
						<li><span class="field-middle">MAC地址</span>：<input class="validate[macAddress]" type="text" id="macAddress" name="macAddress" value="${macAddress}"/>
						</li>
						<li><span class="field-middle">设备类型</span>：<span><s:select list="parentGroupList" id="parentGroupId" name="parentGroupId" listKey="resourceCategoryGroupId" listValue="resourceGroupName"></s:select>
		  					<s:select list="groupList" id="groupId" name="groupId" isSynchro="1" listKey="resourceCategoryGroupId" listValue="resourceGroupName"></s:select>
		  				</span><span class="red">*</span></li>
						<li><span class="field-middle">备注</span>：<textarea class="validate[length[0,200,备注]]" id="remark" name="remark" value="${remark}" rows="8" cols="100"></textarea></li>
					</ul>
					<ul>
						<div class="t-right">
							<span class="black-btn-l" id="addSave"><span class="btn-r"><span class="btn-m"><a >添加</a></span></span></span>
						</div>
					</ul>
				</page:param>		  
	  </page:applyDecorator>
	  
	  <div id="div_disc_result" style="display:none">
			<page:applyDecorator name="accordionPanel">  
				<page:param name="id">panel_disc_addmonitor</page:param>
				<page:param name="title">3.添加及监控</page:param>
				<page:param name="height"></page:param>
				<page:param name="width">690px</page:param>
				<page:param name="cls">fold</page:param>
				<page:param name="display"></page:param>
				<page:param name="content">	  	
					<div class="fold-content">
					  	<div class="border-bottom">
							<div class="find-center"><img id="imgLoading" src="${ctx}/images/loading.gif" width="32" height="32" vspace="6" /><br />
					         		<span id="spLoading">0%</span></div>
					</div>
					<div class="h3">
						<div class="f-right">
							<span>耗用时间：<span id="compact">00:00:00</span></span>
							<!-- <span class="ico ico-excel"></span> -->
						</div>
						<span  class="bold">发现结果</span>
						<span id="sp_disc_result"></span>
					</div>
					 <iframe id="iframe_discovery" name="iframe_discovery" src="" scrolling="no"
						frameborder="0" marginheight="0" marginwidth="0" width="100%" onload="resizeFrameHeight();"></iframe>
					</div>
				</page:param>		  
			</page:applyDecorator>
	    
		  <div class="t-right">
				<span class="black-btn-l" id="sp_monitor" style="display:none;"><span class="btn-r"><span class="btn-m"><a>加入监控</a></span></span></span>
				<span class="black-btn-l" id="sp_continue" style="display:none;"><span class="btn-r"><span class="btn-m"><a>继续添加</a></span></span></span>
				<span class="black-btn-l" id="sp_finish" style="display:none;"><span class="btn-r"><span class="btn-m"><a>完成并退出</a></span></span></span>
		  </div>
    </div>
    
  </div>
</div>
</form>
</body>
</html>