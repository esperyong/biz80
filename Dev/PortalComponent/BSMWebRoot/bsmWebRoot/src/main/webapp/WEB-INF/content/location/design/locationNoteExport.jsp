<!-- WEB-INF\content\location\design\locationNoteExport.jsp -->
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<base target="_self">
<title>导入设备位置信息</title>
<link rel="stylesheet" href="${ctxCss}/validationEngine.jquery.css" 
	type="text/css" media="screen" title="no title" charset="utf-8" />
<link rel="stylesheet" href="${ctxCss}/common.css"
	type="text/css" />
	<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<script src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script src="${ctx}/js/component/cfncc.js"></script>
<script src="${ctx}/js/component/toast/Toast.js"></script>
<script type="text/javascript">
<s:if test="#request.succeed == true">
// 修改区域完成，刷新父页面
window.returnValue="${location.locationId}";
window.close();
</s:if>
	$(document).ready(function(){
		$("#uploadNoteForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		$("#next").click(function(){
			$("#uploadNoteForm").submit();
		});
		$("#closeId").click(function(){
			window.close();
		});

		$("input[name='noteType']").change(function(){
			if(this.checked){
				if(this.value=="coverMap"){
						$("#coverMapHelp").show();
						$("#newMapHelp").hide();
						$("#newMapName").hide();
						$("#mapName").val("none");
					}else{
						$("#coverMapHelp").hide();
						$("#newMapHelp").show();
						$("#newMapName").show();
						$("#mapName").val("");
						}
				}
		});
		$("#newMapName").hide();
		$("#mapName").val("none");

		$("#next").click(function(){
			$("#uploadNoteForm").submit();
		});
				
			
		
	});
	
	
</script>
</head>
<body> 
<page:applyDecorator name="popwindow"  title="导入物理位置拓扑">
	
	<page:param name="width">450px</page:param>
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">next</page:param>
	<page:param name="bottomBtn_text_1">导入</page:param>
	<page:param name="content">
<form name="uploadNoteForm" id="uploadNoteForm" action="${ctx}/location/design/locationExport!imports.action"
	 method="post" enctype="multipart/form-data">
	 <input type="hidden" name="locationId" value="${locationId }"></input>
<div id="oneDiv" style="background-color: black;color:#fff;">
	<ul class="panel-singleli">
		<li><img src="${ctx }/images/alpha-icon.gif" align="absmiddle">&nbsp;
		导入物理位置的拓扑图，可创建和覆盖整个区域。
		</li>
	</ul>
</div>
<div id="title0Div" class="panel-titlebg"><span></span><span>选择文件</span></div>
<!-- 
<div id="oneDiv">
	<ul class="panel-singleli">
		<li>	
		<input name="noteType" type="radio" value="coverMap" checked="checked"/>
		<span>覆盖当前区域</span>
		<input name="noteType" type="radio" value="newMap"/>
		<span>创建为新的区域</span>
		</li>
		<li id="coverMapHelp" style="color: red;">		
		覆盖当前区域将覆盖整个区域的结构及区域图，并清除关联设备，情慎重操作。
		</li>
		<li id="newMapHelp" style="color: red;display:none;">		
		创建新的区域将创建一个完整的区域及子区域，不包括关联设备。
		</li>
	</ul>
</div>
 -->	
<div id="oneDiv">
	<ul class="panel-multili" style="height: 55px;">
			<!-- 
			<li  id="newMapName"><span style="margin-left:3px;">区域名称：</span>
			<s:textfield name="mapName" cssClass="validate[required,length[0,50],custom[noSpecialStr]]"></s:textfield>
			<span class="red">*</span>
			</li>
			 -->
			<li style="margin-top:5px;">
			<span style="margin-left:3px;margin-right:6px;">选择文件：</span>
			<input id="uploadXmlFileName" name="uploadXmlFileName" type="text" class="validate[required]"  readonly="readonly" style="width:200px;"/>
			<span class="buttoncopy">       
		       <input type="file" name="uploadXml" id="uploadXml" value="" onKeyDown="DisabledKeyInput();" onchange="$('#uploadXmlFileName').val(this.value);" class="validate[required]"/>
		    </span>
			<span class="red">*</span>
		    </li>
	</ul>
</div>	
</form>
</page:param>
</page:applyDecorator>
</body>
</html>

