<!-- WEB-INF\content\location\define\create-location.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>新建物理位置</title>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/validationEngine.jquery.css" rel="stylesheet" type="text/css" media="screen" title="no title" charset="utf-8" />
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine-cn.js" type="text/javascript"></script>
<script src="${ctxJs}/jquery.validationEngine.js" type="text/javascript"></script>
<script src="${ctxJs}/location/dialogResize.js"></script>
<script type="text/javascript">

<s:if test="#request.succeed == true">
	// 新建区域完成，刷新父页面
	window.returnValue="刷新区域树";
	window.close();
</s:if>
	
	//表单验证
	$(document).ready(function() {
		$("#addForm").validationEngine({
			promptPosition:"centerRight", 
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false
		});
		$.validationEngineLanguage.allRules.duplicateLocationName = {
		  "file":"${ctx}/location/check/locationcheck.action?locationId=",
		  "alertTextLoad":"<font color='red'>*</font> 正在验证，请等待",
		  "alertText":"<font color='red'>*</font> 同级区域／子区域名称重复"
		}
		$("#closeId").click(function (){
			window.close();
		});
		
		$("#submit").click(function (){
			$("#addForm").submit();
		});
		
		$("#cancel").click(function(){
			window.close();
		});
	});
</script>
</head>

<body >
<page:applyDecorator name="popwindow"  title="新建位置">
	
	<page:param name="topBtn_index_1">1</page:param>
	<page:param name="topBtn_id_1">closeId</page:param>
	<page:param name="topBtn_css_1">win-ico win-close</page:param>
	
	<page:param name="bottomBtn_index_1">1</page:param>
	<page:param name="bottomBtn_id_1">submit</page:param>
	<page:param name="bottomBtn_text_1">确定</page:param>
	
	<page:param name="bottomBtn_index_2">2</page:param>
	<page:param name="bottomBtn_id_2">cancel</page:param>
	<page:param name="bottomBtn_text_2">取消</page:param>
	
	<page:param name="content">
		<s:form id="addForm" action="/location/define/location!createLocation.action">
		<s:hidden name="location.parentId"></s:hidden>
			<ul class="fieldlist-n">
				<li><span class="field">区域名称：</span>
					<s:textfield name="location.name" cssClass="validate[required,length[0,50],noSpecialStr,ajax[duplicateLocationName]]"></s:textfield><span class="red">*</span></li>
				<li><span class="field">区域类型：</span>
					<s:select name="location.type"  value="location.type" list="locationTypeList" listKey="key" listValue="%{getText(value)}"></s:select>
				<li><span class="field">备注：</span>
					<s:textarea name="location.remarks" cssClass="validate[required,length[0,200]]" ></s:textarea>
				</li>
			</ul>
		</s:form>
	</page:param>
</page:applyDecorator>
</body>
</html>