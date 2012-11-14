<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<%
	String instanceId = request.getParameter("instanceId");
%>
<title>加入监控</title>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript">
var instanceId = "<%=instanceId%>";
$(document).ready(function() {
	if(opener && opener.parent && opener.parent.parent && opener.parent.parent.setNotChange){
	  opener.parent.parent.setNotChange();
	}
	SimpleBox.renderAll();
	 
	$("#closeId").bind("click", function() {
		window.close();
	});
	
	function refreshMonitorPage() {
		if (opener.parent.opener.name == 'monitorList') {
			opener.parent.opener.location.href = "/pureportal/monitor/monitorList.action?instanceId=" + instanceId;
		}
	}
	
	refreshMonitorPage();
})
</script>
</head>
<body class="pop-window">

<page:applyDecorator name="popwindow"  title="加入监控">
  
  <page:param name="width">500px</page:param>
  <page:param name="height">100px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
  <page:param name="content">
     <s:if test="result == 2">
       <div style="padding:5px;margin:10px;"></h1>
        <SPAN class="promp-win-ico promp-win-ico-alert"><SPAN class="txt" style="margin-top:5px;">产品监控的资源数量已超过限额，请联络摩卡软件获取购买支持更多数量License的信息。</SPAN></SPAN>
       </div>
     </s:if>
     <s:else>
	  <div id="standbyResourceTable" class="grid-black">
			<div class="roundedform-top">
				<div class="top-right">
					<div class="top-min">
						<table class="hundred">
							  <thead>
									<tr>
											<th colId="IPAddress"  style="display:">
												<div class="theadbar">
													<div class="theadbar-name">
														<span style="color:#fff;font-weight:bolder;">IP地址</span>
													</div>
												</div>
											</th>
										
											<th colId="name"  style="display:">
												<div class="theadbar">
													<div class="theadbar-name">
														<span style="color:#fff;font-weight:bolder;">名称</span>
													</div>
												</div>
											</th>
									
											<th colId="resourceLevel2" style="width:50px">
												<div class="theadbar">
													<div class="theadbar-name">
														<span style="color:#fff;font-weight:bolder;">结果</span>
													</div>
												</div>
											</th>
										</tr>
								 </thead>
						 </table>
					</div>
				</div>
			</div>
			<div class="roundedform-content" style="height:100%;">
											
				<table class="hundred" ><tbody rowsable="4">
						<tr class="white">
							
							<td colId="IPAddress">
								<span>${resourceInstance.ip}</span>
							</td>
														
							<td colId="name" style=";" title="<s:property value="resourceInstance.name"/>">
								<span><s:property value="resourceInstance.name" /></span>
							</td>
					
							<td colId="id" style="width:50px">
								<s:if test="result == 0">
								<span class="ico ico-right"/>
								</s:if>
								<s:else>
								<span class="ico ico-false"/>
								</s:else>
							</td>
							
						</tr>
				</tbody></table>
			</div>
			<div class="roundedform-bottom">
				<div class="bottom-right">
					<div class="bottom-min"></div>
				</div>
			</div>		
		</div>
	  
	  	<div>
	  		<br/>
	  		<span>&nbsp;&nbsp;&nbsp;&nbsp;注：若策略启用失败，系统将自动重试。</span>
	  		<br/><span>&nbsp;</span>
	  	</div>
	  	
	  	</s:else>
  </page:param>
</page:applyDecorator>

</body>
</html>