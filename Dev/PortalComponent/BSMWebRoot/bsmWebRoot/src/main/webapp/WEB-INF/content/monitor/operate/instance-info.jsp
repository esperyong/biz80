<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>变更发现信息</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctx}/js/jquery.validationEngine.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/panel/panel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/grid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/gridPanel/indexgrid.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript" src="${ctx}/js/discovery/resource-discovery.js" ></script>
<script type="text/javascript">
$(document).ready(function() {
	<s:if test="success == true">
		window.close();
	</s:if>
	<s:else>
	$("#sp_cancel").bind("click", function() {
		window.close();
	});
	$("#sp_ok").bind("click", function() {
		var formObj = document.getElementById("form1");
		formObj.action = "instance-info-update!update.action?instanceId=${instanceId}";
		formObj.submit();
	});
	</s:else>
	$("#closeId").bind("click", function() {
		window.close();
	});
});
</script>
</head>
<body>
<input type="hidden" id="domainId" value="domn-000000000000001">
<page:applyDecorator name="popwindow"  title="变更发现信息">
  
  <page:param name="width">600px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
    
    <page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">sp_ok</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">sp_cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
  <page:param name="content">

	  <div class="pop-content ">
			<div class="content-padding">
				<div class="h2"><span class="ico ico-note-blue"></span>说明：当设备的发现信息变更时，请及时更新，否则将无法取值。 </div>
				<div id="panel_disc_info">
				<s:form id="form1" name="form1" method="post" enctype="multipart/form-data" >
						<s:iterator value="discInfoGroups" id="discInfos">
							<s:if test="discGroupId != null">
								<div class="h4">
									<s:property value="discGroupId"/>&nbsp;<s:property value="discGroupName"/>&nbsp;
								</div>
							</s:if>
							<ul class="fieldlist">
								<s:iterator value="discInfos" >
									<li>
										<span class="field"><s:property value="displayName"/></span>
										<span><s:text name="i18n.colon"/></span>
										${fieldHTML}
										<s:if test="notNull"><span class="red">*</span></s:if>
										<s:if test="helpInfo != null"><span class="ico ico-what" title="<s:property value="helpInfo"/>"></span></s:if>										
									</li>
								</s:iterator>
							</ul>
						</s:iterator>
				</s:form>
				</div>
			</div>
	  </div>  
	
	<!-- 
	<iframe id="iframe_discovery" name="iframe_discovery" src="" scrolling="no"	frameborder="0" 
			marginheight="0" marginwidth="0" width="100%" ></iframe>
	 -->
  </page:param>
</page:applyDecorator>



</body>
</html>
<script language=javascript>
function win_onLoad(){
	var width = document.body.offsetWidth;    
	var height = document.body.offsetHeight; 
	
	width = eval(width + 20);
	height = eval(height + 40);
	
	if (width > screen.width)
	width = screen.width;
	
	if (height > screen.height)
	height = screen.height;
	
	//alert(width);alert(height);
	window.resizeTo(width,height);
}
win_onLoad();
</script> 