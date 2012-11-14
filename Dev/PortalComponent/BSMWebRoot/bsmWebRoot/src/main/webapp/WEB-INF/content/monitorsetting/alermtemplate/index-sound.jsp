<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %> 
<body>
<div>
<div>
  <div class="manage-content">
    <div class="top-l">
      <div class="top-r">
        <div class="top-m"> </div>
      </div>
    </div>
    <div class="mid">

      <div class="h1"> <span class="bold">当前位置：</span> <span>监控配置 / 监控设置 / 声光告警模板</span> </div> 
      <div class="margin5"><span class="ico ico-tips"></span><span>默认所有域使用全局设置的模板，也可为单个域设置个性模板</span></div>    
      <div class="indentation">
      <div class="h1">适用范围：${domainSelect }
      
      	<div style="width:99%;" id="tabmanageId">
		<s:action name="sound-list" namespace="/monitorsetting/alermtemplate" executeResult="true">
			<s:param name='domainName' value='%{domainName}' />
		</s:action>
		</div>
      
      </div>
      <div class="h1">注：‘级别’指事件定义中的事件级别，其中‘其他’特指进程管理和SNMP Trap产生的事件。

     </div>
     </div>
   <span class="black-btn-l f-right"><span class="btn-r"><span class="btn-m"><a id="soundsave">应用</a></span></span></span>

</div>
</div>
</body>
