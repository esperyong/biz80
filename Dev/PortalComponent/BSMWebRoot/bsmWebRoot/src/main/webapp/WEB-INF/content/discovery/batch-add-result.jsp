<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>发现页面</title>
<link href="${ctx}/css/public.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/UIComponent.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/validationEngine.jquery.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
<script type="text/javascript" src="${ctx}/js/jquery.form.js" ></script>
<script type="text/javascript" src="${ctx}/js/component/cfncc.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine-cn.js"></script>
<script type="text/javascript" src="${ctx}/js/jquery.validationEngine.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/accordionPanel/accordionAddSubPanel.js"></script>
<script type="text/javascript" src="${ctx}/js/component/combobox/simplebox.js"></script>
<script type="text/javascript" src="${ctx}/js/component/comm/winopen.js"></script>
<script type="text/javascript">
var ctxpath = "${ctx}";
var $sp_disc_result = parent.$("#sp_disc_result");
var time = parent.$('#compact').html();
parent.$('#compact').countdown("destroy");
parent.$('#compact').html(time);
<s:if test="importMap['success'] > 0">
  parent.$("#sp_monitor").show();
  parent.$("#sp_finish").show();
  parent.$("#sp_continue").show();
</s:if>
<s:else>
  parent.$("#sp_finish").show();
  parent.$("#sp_continue").show();
</s:else>
parent.stopLoading();
parent.$("#iframe_discovery").show();

$(document).ready(function() {
  parent.parent.setNotChange();
});

function addMonitor() {
  $('#form_result').ajaxSubmit({
    url: ctxpath + "/discovery/batchAddImport!batchMonitor.action",//表单的action
    method: 'POST',//方式
    success: (function(data){
      if(data){
        var total = data.total
        var success = data.success;
        var failure = data.failure;
        var monitored = data.monitored;
        var pc = data.pc;
        var result = data.result;
        var params = "total="+total+"&success="+success+"&failure="+failure+"&monitored="+monitored+"&pc="+pc +"&result=" + result;
        var url = ctxpath + "/discovery/batchAddImport!monitorResult.action?" + params;
        winOpen({url:url,width:500,height:245,scrollable:false,name:'handworkbatchmonitorresult'});
        parent.$.unblockUI();
        parent.parent.setNotChange();
      }
    })
  });
}
</script>
</head>
<body>
<form id="form_result" name="form_result">
<textarea style="display:none;" id="instanceIds" name="instanceIds">${instanceIds}</textarea>
<ul>
  <li class="margin8 bold lineheight21">
    <table class="gray-table table-width100 table-grayborder">
      <tr>
        <th class="bold" colspan="3">结果</th>
      </tr>
      <tr>
        <td class="underline" style="width:20%;">导入成功</td>
        <td class="underline" style="width:10px;">：</td>
        <td class="underline" ><s:property value="importMap['success']" /></td>
      </tr>
      <tr>
        <td class="underline">导入失败</td>
        <td class="underline">：</td>
        <td class="underline" ><span class="txt-red"><s:property value="importMap['failure']" /></span></td>
      </tr>
      <s:iterator value="importMap['failList']" var="failMsg" status="idx">
      <s:if test="#idx.isFirst()">
      <tr>
        <td class="underline">失败原因</td>
        <td class="underline">：</td>
        <td class="underline"><span class="txt-red"><s:property value="#failMsg" /></span></td>
      </tr>
      </s:if>
      <s:else>
      <tr>
        <td class="underline">&nbsp;</td>
        <td class="underline">&nbsp;</td>
        <td class="underline"><span class="txt-red"><s:property value="#failMsg" /></span></td>
      </tr>
      </s:else>
      </s:iterator>
    </table>
  </li>
</ul>
</form>
</body>
</html>