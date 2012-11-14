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
		<div class="blur-bg txt-white padding8" style="zoom:1;" id="<s:property value="#info.getName()" />"><span class="left for-inline  bold"><s:property value="#info.getName()" /></span><span class="right for-inline  bold"><span class="ico ico-toparrow"></span><a href="#top">Back To Top</a></span></div>
		<s:if test="#info.show1=='true'">
			<div style="padding:8px;">
	 		<div class="bold margin3">汇总数据：</div>
	   		<table class="tongji-grid table-width100 whitebg grayborder margin3" style="border:1px solic #ccc;">
	     	<tr>
		       <th noWrap="nowrap">序号</th>
		       <th noWrap="nowrap">资源名称</th>
		       <th noWrap="nowrap">资源类型</th>
		       <th noWrap="nowrap">IP地址</th>
		       <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<th noWrap="nowrap">组件类型</th>
		       		<th noWrap="nowrap">组件名称</th>
		       </s:if>
		       <s:iterator var="perMetric" value="#info.perMetrics.split(';')" status="st0">
		       		<th noWrap="nowrap"><s:property value="#perMetric.split(',')[1]" /></th>
		       </s:iterator>
	     	</tr>	      	
		     <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<s:iterator var="name" value="#info.componentResName.split(';')" status="st2">		   	
			   		<tr class="line">
				   				<td noWrap="nowrap"><s:property value="#st2.index+1" /></td>	   					   							   						
			   					<td noWrap="nowrap"><s:property value="#name" /></td>
			   					<td noWrap="nowrap"><s:property value="#info.resoureName" /></td>
			   					<td noWrap="nowrap"><s:property value="#info.componentResIp.split(';')[#st2.index]" /></td>	
			   					<td noWrap="nowrap"><s:property value="#info.componentName" /></td>		   					
			   					<td noWrap="nowrap"><s:property value="#info.componentsName.split(';')[#st2.index]" /></td>
					   			<s:iterator var="perMetric" value="#info.perMetrics.split(';')" status="st0">
					   				<td noWrap="nowrap">0</td>						   				
					   			</s:iterator>						   			
					</tr>   	 	
			   	</s:iterator> 
		     </s:if>
	     	<s:else>
	     		<s:iterator var="name" value="#info.resourcesName.split(';')" status="st2">		   	
		   		<tr class="line">
			   				<td noWrap="nowrap"><s:property value="#st2.index+1" /></td>	   					   					   						
		   					<td noWrap="nowrap" ><s:property value="#name" /></td>
		   					<td noWrap="nowrap"><s:property value="#info.resoureName" /></td>
		   					<td noWrap="nowrap"><s:property value="#info.resourcesIp.split(';')[#st2.index]" /></td>	
				   			<s:iterator var="perMetric" value="#info.perMetrics.split(';')" status="st0">
				   				<td noWrap="nowrap">0</td>	
				   			</s:iterator>						   			
				</tr>   	 	
		   		</s:iterator> 
	     	</s:else>	  	          			     			        			   				   
	   	  </table>			   				   				   			   				
	  	</div>
	   </s:if>	
	   	<s:if test="#info.show2=='true'">
	   		<div style="padding:8px;">
	 		<div class="bold margin3">可用性数据：</div>
	   		<table class="tongji-grid table-width100 whitebg grayborder margin3" style="border:1px solic #ccc;">
	     	<tr>
		       <th noWrap="nowrap">序号</th>
		       <th noWrap="nowrap">资源名称</th>
		       <th noWrap="nowrap">资源类型</th>
		       <th noWrap="nowrap">IP地址</th>
		       <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<th noWrap="nowrap">组件类型</th>
		       		<th noWrap="nowrap">组件名称</th>
		       </s:if>
		       <th noWrap="nowrap">事件级别</th>
		       <th noWrap="nowrap">事件内容</th>
		       <th noWrap="nowrap">产生时间</th>
	     	</tr>
		      
		     <s:if test="#info.componentType!=null&&#info.componentType!=''">
		       		<s:iterator var="name" value="#info.componentResName.split(';')" status="st2">		   	
			   		<tr class="line">
				   				<td noWrap="nowrap"><s:property value="#st2.index+1" /></td>	   					   							   						
			   					<td noWrap="nowrap"><s:property value="#name" /></td>
			   					<td noWrap="nowrap"><s:property value="#info.resoureName" /></td>
			   					<td noWrap="nowrap"><s:property value="#info.componentResIp.split(';')[#st2.index]" /></td>	
			   					<td noWrap="nowrap"><s:property value="#info.componentName" /></td>		   					
			   					<td noWrap="nowrap"><s:property value="#info.componentsName.split(';')[#st2.index]" /></td>
					   			<td noWrap="nowrap">致命</td>
					   			<td noWrap="nowrap"><s:property value="#name" />不可用</td>	
					   			<td noWrap="nowrap">0000/00/00 00:00</td>						   			
					</tr> 
					<tr  class="line">
				   				<td colspan="6"  class="rt  textalign" noWrap="nowrap"></td>	   					   				
					   			<td noWrap="nowrap">恢复</td>
					   			<td noWrap="nowrap"><s:property value="#name" />恢复可用性</td>	
					   			<td noWrap="nowrap">0000/00/00 00:00</td>							   			
					</tr>
					<tr  class="line">
				   				<td colspan="6"  class="rt  textalign" noWrap="nowrap"></td>	   					   				
					   			<td noWrap="nowrap">致命</td>
					   			<td noWrap="nowrap"><s:property value="#name" />不可用</td>		
					   			<td noWrap="nowrap">0000/00/00 00:00</td>						   			
					</tr>   	 	
			   	</s:iterator> 
		     </s:if>
	     	 <s:else>
	     		<s:iterator var="name" value="#info.resourcesName.split(';')" status="st2">		   	
		   		<tr class="line">
			   				<td noWrap="nowrap"><s:property value="#st2.index+1" /></td>	   					   						   						
		   					<td noWrap="nowrap"><s:property value="#name" /></td>
		   					<td noWrap="nowrap"><s:property value="#info.resoureName" /></td>
		   					<td noWrap="nowrap"><s:property value="#info.resourcesIp.split(';')[#st2.index]" /></td>
		   					<td noWrap="nowrap">致命</td>
					   		<td noWrap="nowrap"><s:property value="#name" />不可用</td>		
					   		<td noWrap="nowrap">0000/00/00 00:00</td>							   									   			
				</tr> 
				<tr  class="line">
				   			<td colspan="4"  class="rt  textalign" noWrap="nowrap"></td>	   					   				
					   		<td noWrap="nowrap">恢复</td>
					   		<td noWrap="nowrap"><s:property value="#name" />恢复可用性</td>	
					   		<td noWrap="nowrap">0000/00/00 00:00</td>							   			
				</tr>
				<tr  class="line">
				   			<td colspan="4"  class="rt  textalign" noWrap="nowrap"></td>	   					   				
					   		<td noWrap="nowrap">致命</td>
					   		<td noWrap="nowrap"><s:property value="#name" />不可用</td>		
					   		<td noWrap="nowrap">0000/00/00 00:00</td>						   			
				</tr>   	 	
		   	</s:iterator> 
	     	</s:else>	  	          			     			        			   				   
	   	  </table>			   				   				   			   				
	  	</div>
	   	</s:if>			    		 
	</s:if>	    	
	</s:iterator>   				                                   
</div>  