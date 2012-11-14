<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/common.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css"/>
<title>刷新设置</title>
<script>var path = '${ctx}';</script>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script src="${ctx}/js/jquery.validationEngine.js"></script>
<script src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/notification/comm.js"></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
</head>
<body>
<page:applyDecorator name="popwindow"  title="刷新设置">
 <page:param name="width">300px;</page:param>
 <page:param name="height">140px;</page:param>
 <page:param name="topBtn_index_1">1</page:param>
 <page:param name="topBtn_id_1">win-close</page:param>
 <page:param name="topBtn_css_1">win-ico win-close</page:param>
 <page:param name="topBtn_title_1">关闭</page:param>
 <page:param name="bottomBtn_index_1">1</page:param>
 <page:param name="bottomBtn_id_1">confirm_button</page:param>
 <page:param name="bottomBtn_text_1">确定</page:param>
 <page:param name="bottomBtn_index_2">2</page:param>
 <page:param name="bottomBtn_id_2">close_button</page:param>
 <page:param name="bottomBtn_text_2">取消</page:param>
 <page:param name="content">
       <form name="setupForm" id="setupForm" method="post">
              <input type="hidden" name="pageModule" id="pageModule" value="${pageModule}"/>
              <input type="hidden" name="auto" id="auto" value="${auto}"/>
              <div>
                   <li class="padding5">请选择页面刷新方式：</li
                   ><li class="padding2"><input name="autopage" type="radio" value="false" <s:if test="auto!='true'">checked</s:if>/>手动刷新
                   <input name="autopage" type="radio" value="true" <s:if test="auto=='true'">checked</s:if>/>自动刷新</li> 
                   <div id="selectInterval" <s:if test="auto!='true'">style="display: none;"</s:if>><span class="f-right">选择频率：<s:select name="interval"  list="intervalTime" listKey="optionValue"  listValue="optionDisplay" value="interval"/>&nbsp;&nbsp;</span></div>
             </div>
      </form>
</page:param>
</page:applyDecorator>
</body>
<script type="text/javascript">
$(function() {
	$('#close_button').click(function(){
		opener.Monitor.refresh();
		window.close();
	});
	$("input[name='autopage']").click(function(){
		if($("input[name='autopage']")[0].checked){
			$('#selectInterval').hide();
		}else{
			$('#selectInterval').show();
		}
	});
	$('#confirm_button').click(function(){
		var item = $('input[name=autopage][checked]').val();
		var data = function(){};
		data.pageModule = $('#pageModule').val();
		data.auto = item;
		data.interval = $('#interval').val();
		$.ajax({
			type:"POST",
			url:path + "/monitor/setupRenovate.action",
			data:data,
			success:function(data){
				//alert("保存成功。");
				opener.Monitor.refresh();
				window.close();
			},
            error:function(e){
				opener.Monitor.refresh();
              	//alert("发送失败。");
              	//alert(e.responseText);
            }
		});
	})
	SimpleBox.renderAll();
});
</script>
</html>