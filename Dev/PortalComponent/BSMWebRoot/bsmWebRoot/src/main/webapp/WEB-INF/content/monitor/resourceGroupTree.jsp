<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<style type="text/css">.span_dot{width:145px;overflow: hidden; text-overflow:ellipsis;display: inline-block;white-space:nowrap;}
</style>
	
	 <s:if test="resourceGroupList != null && resourceGroupList.size() != 0">
	 	 <ul id="groupul" >
 <s:iterator value="resourceGroupList" var="group"  status="stat">
          <li id="<s:property value="#group.getResourceGroupId()"/>"  groupName="<s:property value="#group.getResourceGroupName()"/>" style="cursor:pointer">
              <span class="span_dot" name="groupInfo" groupId="<s:property value="#group.getResourceGroupId()" />" title="<s:property value="#group.getResourceGroupName()"/>"><s:property value="#group.getResourceGroupName()"/>
          	  (
          	    <s:if test="#group.getResourceInstances() != null">
          	  <s:property value="#group.getResourceInstances().length"/>
          	  </s:if>
          	  	<s:else>
          	  0
          	  </s:else>
          	  )
          	  </span>
          	  <span class="ico ico-t-right" ></span>
          	  </li>
          	    
</s:iterator>
	</ul>
		  </s:if>  
		  <s:else>
		      		<div class="add-button2" style="height:80%"><span>请点击 <img src="${ctx}/images/add-button1.gif" width="10" height="10" border="0"> 按钮新建一个资源组</span></div>
		   </s:else>

<script type="text/javascript">
Monitor.Resource.left.pointId = '<s:property value="pointId"/>';
Monitor.Resource.left.pointLevel = '<s:property value="pointLevel"/>';
Monitor.Resource.left.monitor = '<s:property value="monitor"/>';
Monitor.Resource.left.whichTree = '<s:property value="whichTree"/>';
Monitor.Resource.left.whichGrid = '<s:property value="whichGrid"/>';
Monitor.Resource.left.currentTree = '<s:property value="currentTree"/>';
Monitor.Resource.left.currentResourceTree = '<s:property value="currentResourceTree"/>';
Monitor.Resource.left.currentUserId = '<s:property value="currentUserId"/>';
Monitor.Resource.left.currentDomainId = '<s:property value="currentDomainId"/>';
</script>