<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>诊断信息</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<style type="text/css">
  span.elli{width:320px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden; word-spacing:normal; word-break:normal; display:block;}  
</style>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script>
$(document).ready(function() {
	$("#sp_ok").bind("click", function() {
		window.close();
	});
	$("#closeId").bind("click", function() {
		window.close();
	});
})
</script>
</head>
<body class="pop-window">
<form id="form1" name="form1" method="post">
<page:applyDecorator name="popwindow"  title="诊断信息">
  
  <page:param name="width">100%</page:param>
  <page:param name="height">390px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">closeId</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  
  <page:param name="content">
	<div class="fold-content" style="overflow:hidden;">
	<s:if test="!resDiagResult.resultList.isEmpty">
	 	<table class="result">
			<thead>
				<tr>
					<th width="250">诊断内容</th>
					<th width="50">诊断结果</th>
					<th>处理建议</th>
				</tr>
			</thead>
			<tbody>
					<s:iterator value="resDiagResult.resultList">
						<s:if test="metricOfCannotGet == null">
							<tr>
								<td><s:property value="collectionMode"/></td>
								<td >
									<s:if test="ok">
										<span class="ico ico-right"></span>
									</s:if>
									<s:else>
										<span class="ico ico-false"></span>
									</s:else>
								</td>						
								<td><span class="elli" title="<s:property value="helpInfo"/>"><s:property value="helpInfo"/></span></td>
							</tr>
						</s:if>
					</s:iterator>
			</tbody>
		</table>
		<div>
			<ul class="margin3">
				<li class="margin3">
					<span class="bold">处理建议：</span>				
				</li>
				<li>
					<TEXTAREA class="textarea-border" ROWS="10" COLS="129" readonly>${resDiagResult.diagSuggestion}</TEXTAREA>
				</li>
			</ul>
		</div>
	</s:if>	
	<s:else>
		<div class="roundedform-content">
			<table class="hundred"  align="center" height="400px"><tbody><tr>
			<td class="nodata vertical-middle" style="text-align:center;"><span class="nodata-l"><span class="nodata-r"><span class="nodata-m">
			<span class="icon">当前无数据</span> </span></span></span>
			</td>
			</tr></tbody></table>
        </div>
	</s:else>
	
	</div>
  </page:param>
</page:applyDecorator>
</form>
</body>
</html>
<script language=javascript>
function win_onLoad(){
	var width = document.body.offsetWidth;    
	var height = document.body.offsetHeight; 
	
	alert(width + "," + height);
	width = eval(width + 20);
	height = eval(height + 75);
	
	if (width > screen.width)
	width = screen.width;
	
	if (height > screen.height)
	height = screen.height;
	
	//alert(width);alert(height);
	window.resizeTo(width,height);
}
// win_onLoad();
</script>
