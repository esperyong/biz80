<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
	<title><s:if test="whatOperate=='delResource'">删除</s:if><s:else>取消监控</s:else>提示</title>
	<link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
	<link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
    <script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.core.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.widget.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.mouse.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.draggable.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
	<script type="text/javascript" src="${ctxJs}/component/panel/panel.js"></script>
	<style type="text/css">.span_dot{width:260px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
</head>
<body>
<page:applyDecorator name="popwindow"  title="提示">
  <page:param name="width">350px</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">close_button</page:param>
  <page:param name="topBtn_title_1">关闭</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">submitForm</page:param>
  <page:param name="bottomBtn_text_1">确定</page:param>
  <page:param name="content">
        <!-- content start -->
        <span class="ico ico-note-blue"></span><span class="suojin bold">以下资源<s:if test="whatOperate=='delResource'">删除</s:if><s:else>取消监控</s:else>失败：</span>
             <div style="text-align:center">
             <div style="margin:2px 2px 5px 2px;padding:10px 10px 10px 10px;width:285px;height:130px;overflow:auto;border:1px solid #666">
                 <s:iterator value="delResultsList" var="deleteResult" status="status">
                      <span style="display:block" class="span_dot" title="<s:property value="#deleteResult" />"><s:property value="#deleteResult" /></span>
                 </s:iterator>
             </div>
              </div>
        <!-- content end -->
  </page:param>
</page:applyDecorator>
<script type="text/javascript">
var path = "<%=request.getContextPath()%>";
$(function() {
    $("#close_button,#submitForm").click(function() {
   	 logout();
   });
});
function logout() {
    window.opener = null;
    window.open("", "_self");
    window.close();
}
</script>
</body>
</html>