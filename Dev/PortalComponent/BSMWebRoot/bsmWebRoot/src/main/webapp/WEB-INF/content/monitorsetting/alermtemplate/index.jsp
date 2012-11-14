<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<body>
<form name="templateformname" id="templateformname" method="post">
<div>
  <div>
    <div class="manage-content">
      <div class="top-l">
        <div class="top-r">
          <div class="top-m"> </div>
        </div>
      </div>
      <div class="mid">
        <div class="h1"> <span class="bold">当前位置：</span> <span>监控配置 / 监控设置 /       <s:if test="type=='SMS'">短信告警模板</s:if>
      <s:elseif test="type=='VOICE'">语音告警模板</s:elseif>
      <s:else>邮件告警模板</s:else></span> </div>
        <div class="margin5"><span class="ico ico-tips"></span><span>默认所有域使用全局设置的模板，也可为单个域设置个性模板</span></div>
        <div class="indentation">
          <div class="h1"><span style="float:left;height:21px;line-height:21px;">适用范围：</span>${domainSelect }<span class="black-btn-l right vertical-middle" id="templateall" name="templateall" style="display: none;"><span class="btn-r"><span class="btn-m"><a id="allsave" name="allsave">使用全局设置</a></span></span></span>
          </div>
          <input type="hidden" name="type" id="type" value="${type}">
        <div style="width:99%;" id="tabmanageId">
		<s:action name="index-template" namespace="/monitorsetting/alermtemplate" executeResult="true">
			<s:param name='domainName' value='%{domainName}' />
		</s:action>
		</div>
        </div>
      </div>
      <div class="bottom-l">
        <div class="bottom-r">
          <div class="bottom-m"> </div>
        </div>
      </div>
    </div>
  </div>
</div>
</form>
</body>
<script type="text/javascript">
$(function(){
	SimpleBox.renderAll();
})
</script>