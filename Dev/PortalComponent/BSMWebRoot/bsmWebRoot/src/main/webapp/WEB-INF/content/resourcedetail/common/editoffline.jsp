<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
  <%@ include file="/WEB-INF/common/meta.jsp" %>
  <title></title>
	<style type="text/css">
		.addBackground {
		  background:gray;
		  color:white;
		}
		.timeEntry_control {
		 vertical-align: middle;
		 margin-left: 1px;
		}
		.timeEntry_wrap{
		} 
	</style>
  <link rel="stylesheet" type="text/css" href="${ctxCss}/master.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/public.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/jquery-ui/jquery.ui.datepicker.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/validationEngine.jquery.css" />
  <link rel="stylesheet" type="text/css" href="${ctxCss}/UIComponent.css" />
  <script type="text/javascript">
    var path = "${ctx}";
  </script>
  <script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/cfncc.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/plugins/jquery.timeentry.min.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/plugins/jquery.ui.datepicker.js"></script>
  <script type="text/javascript" src="${ctxJs}/jquery.blockUI.js" type="text/javascript"></script>
  <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionPanel.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js"></script>
  <script type="text/javascript" src="${ctxJs}/jquery.validationEngine-cn.js"></script> 
  <script type="text/javascript" src="${ctxJs}/jquery.validationEngine.js"></script>
  <script type="text/javascript" src="${ctxJs}/component/toast/Toast.js"></script>
  <script type="text/javascript" src="${ctxJs}/resourcedetail/editoffline.js"></script>
</head>

<body>
<page:applyDecorator name="popwindow" title="编辑计划不在线时间">
  <page:param name="width">650px;</page:param>
  <page:param name="bottomBtn_index_1">1</page:param>
  <page:param name="bottomBtn_id_1">confirm_button</page:param>
  <page:param name="bottomBtn_text_1"><s:text name="i18n.confirm" /></page:param>

  <page:param name="bottomBtn_index_2">2</page:param>
  <page:param name="bottomBtn_id_2">cancel_button</page:param>
  <page:param name="bottomBtn_text_2"><s:text name="i18n.cancel" /></page:param>
  
  <page:param name="topBtn_index_1">1</page:param>
  <page:param name="topBtn_id_1">topBtn1</page:param>
  <page:param name="topBtn_css_1">win-ico win-close</page:param>
  
  <page:param name="content">

    <div class="select-lr" style="width:600px">

       <div class="h1">
                         设置时间：
       </div>
			<div class="left" style="width:250px">
			  <div class="h2">
			    <input type="radio" name="offlineType" id="daliy" checked="checked" />每天<input type="radio" name="offlineType" id="weekly" />每周<input type="radio" name="offlineType" id="fixed" />固定时间
			  </div>
			  <div id="week" class="h1" style="display:none;">
			    <s:select name="weekly" list="@com.mocha.bsm.detail.util.WeekEnum@values()" listKey="key" listValue='value' />               
			  </div>
			  <div id="date" class="h1" style="display:;">
			                     日期：<input id="datepicker" name="figurely" type="text" size="10" readonly="readonly" class="validate[funcCall[validateFigruely]]"/><!-- <span class="ico ico-date"></span> -->
			  </div>
			  <div id="time">
			        从<s:textfield name="startTime" id="startTime" cssStyle="width:80px" value="09:00:00"/>
			        到<s:textfield name="endTime" id="endTime" cssStyle="width:80px" value="10:00:00"/>
			  </div>
			</div>
			<div class="middle">
			  <span id="pre_right" class="turn-right"></span>
			  <span id="pre_left" class="turn-left"></span>
			</div>
			
			<div class="h1">
			                 计划不在线时间列表：<span>*</span>
			</div>
			<div class="right" style="width:250px">
			
			</div>
			
    </div>
  </page:param>
</page:applyDecorator>  
</body>
</html>
