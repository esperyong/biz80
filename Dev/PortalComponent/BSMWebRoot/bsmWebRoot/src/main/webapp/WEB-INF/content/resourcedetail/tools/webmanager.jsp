<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.mocha.sys.util.time.DateFormatUtils"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp"%>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/master.css" />
	<link rel="stylesheet" type="text/css" href="${ctx}/css/public.css" />
  <link href="${ctx}/css/common.css" rel="stylesheet" type="text/css"/>
  <link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="${ctx}/css/validationEngine.jquery.css" />
	<title><s:text name="detail.webmanage" /></title>
</head>
<body>
<page:applyDecorator name="popwindow">
  <page:param name="title"><s:text name="detail.webmanage" /></page:param>
  <page:param name="width">420px;</page:param>
  <page:param name="height">75px;</page:param>
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">win_close</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  <page:param name="topBtn_title_1"><s:text name="i18n.close" /></page:param>
  
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">ok_button</page:param>
  <page:param name="bottomBtn_text_1"><s:text name="i18n.confirm" /></page:param>
  
  <page:param name="bottomBtn_index_2">2</page:param>
  <page:param name="bottomBtn_id_2">close_button</page:param>
  <page:param name="bottomBtn_text_2"><s:text name="i18n.cancel" /></page:param>
  
  <page:param name="content">
    <form id="webFrm">
    <div class="h2"><span class="ico ico-note-blue"></span><span class="lineheight21"><s:text name="detail.webmanage.note" /></span></div>
    <ul class="fieldlist">
      <li><span class="field"><s:text name="detail.webmanage.weburl" /></span><input type='text' id='consoleUrl' class='validate[required]' size='25' value="http://<s:property value="discoveryIp" default="-" />" /><span class="red">*</span></li>
    </ul>
    </form>
  </page:param>

</page:applyDecorator>
<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
<script type="text/javascript" src="${ctxJs}/component/comm/winopen.js"></script> 
<script type="text/javascript" src="${ctxJs}/component/popwindow/popwin.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
<script>
  $(function(){
    $("#webFrm").validationEngine();
    
    $("#ok_button").click(function(){
      if(!$.validate($("#webFrm"),{promptPosition:"centerRight"})){
         return;
      }
      var url = $("#consoleUrl").val();
      winOpen({url:url,resizeable:true,name:'webmanager'});
      window.close();
    });

    $("#consoleUrl").keydown(function(event){
      if(event.keyCode == 13){
        $("#ok_button").click();
      }
    });
    
    $('#close_button,#win_close').click(function(){
      window.close();
    });
  });
</script>
</body>
</html>