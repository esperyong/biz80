<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<div class="pop-content" style="width: 100%;height: 565px;overflow:auto;">
			<div class="margin5">
            <ul id="top">
              <li style=" text-align:center">
             	<span class="txt14 bold"><s:property value="reportbasevo.name" /> </span>
             </li>
             <li style=" text-align:center" class="margin5"><s:property value="previewStartTime" />~<s:property value="previewEndTime" /></li>
            </ul>
          </div>
          <div class="gray-bg-nb bold">【目录】</div>
          <div class="margin3 catalog"> 
         	 <ul >
			    <s:iterator var="info" value="reportInfo" status="stat">
			    	<s:if test="#info!=null">
						<li class="bold"><a href="#<s:property value="#info.getName()" />"><s:property value="#info.getName()" /></a> </li>			    	
			    	</s:if>			    				    	
			    </s:iterator>
	 		</ul>  
	</div>	
	<s:iterator var="info" value="reportInfo" status="stat">
	<s:if test="#info!=null">
		<div class="blur-bg txt-white padding8" style="zoom:1;"  id="<s:property value="#info.getName()" />"><span class="left for-inline  bold"><s:property value="#info.getName()" /></span><span class="right for-inline  bold"><span class="ico ico-toparrow"></span><a href="#top">Back To Top</a></span></div>
			<div style="padding:8px;">
			<div class="bold margin3"></div>	 		
	   		<table class="tongji-grid table-width100 whitebg grayborder margin3" style="border:1px solic #ccc;">
	     	<tr>
		       <th rowspan="2">序号</th>
		       <th rowspan="2">资源名称</th>
		       <th rowspan="2">资源类型</th>
		       <th rowspan="2">IP地址</th>
		       <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<th rowspan="2">组件类型</th>
		       		<th rowspan="2">组件名称</th>
		       </s:if>
		       <th rowspan="2">告警数量</th>
		       
		       <th colspan="3"  class="rt  textalign">级别分布</th>
		       <th colspan="2"  class="rt  textalign">状态分布</th>
	     	</tr>
		      <tr>
		      <th class="rb textalign">致命</th>
			  <th class="rb textalign">严重</th>  
			  <th class="rb textalign">其他</th>
			  <th class="rb textalign">未确认</th>  
			  <th class="rb textalign">确认</th>			   
		     </tr>	
		     <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<s:iterator var="name" value="#info.componentResName.split(';')" status="st2">		   	
			   		<tr class="line">
				   				<td ><s:property value="#st2.index+1" /></td>	   					   							   						
			   					<td ><s:property value="#name" /></td>
			   					<td ><s:property value="#info.resoureName" /></td>
			   					<td ><s:property value="#info.componentResIp.split(';')[#st2.index]" /></td>	
			   					<td ><s:property value="#info.componentName" /></td>		   					
			   					<td ><s:property value="#info.componentsName.split(';')[#st2.index]" /></td>
					   			<td >0</td>	
					   			<td >0</td>					   			
					   			<td >0</td>		
					   			<td >0</td>		
					   			<td >0</td>	
					   			<td >0</td>								   			
					</tr>   	 	
			   	</s:iterator> 
		     </s:if>
	     	<s:else>
	     		<s:iterator var="name" value="#info.resourcesName.split(';')" status="st2">		   	
		   		<tr class="line">
			   				<td ><s:property value="#st2.index+1" /></td>	   					   						   						
		   					<td ><s:property value="#name" /></td>
		   					<td ><s:property value="#info.resoureName" /></td>
		   					<td ><s:property value="#info.resourcesIp.split(';')[#st2.index]" /></td>	
				   			<td >0</td>	
					   		<td >0</td>					   			
					   		<td >0</td>		
					   		<td >0</td>		
					   		<td >0</td>	
					   		<td >0</td>								   			
				</tr>   	 	
		   		</s:iterator> 
	     	</s:else>	  	          			     			        			   				   
	   	  </table>			   				   				   			   				
	  	</div>
	   </s:if>			    		     	
	</s:iterator>   				                                   
</div>  