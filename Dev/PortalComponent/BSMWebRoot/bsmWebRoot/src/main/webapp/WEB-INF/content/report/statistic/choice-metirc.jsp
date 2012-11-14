<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
  <s:if test="reportType=='Performance'">
  <div class="fold-blue">
  	<div class="fold-top"><span class="fold-top-title">性能指标</span> </div>
  	<s:if test="infoMetrics!=null"> 
  	<div class="fold-content-padding">	  	 
  	 <table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="80%">信息指标</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="2"  style="padding: 0 0 0 0;">
           <div style="width: 100%;height:143px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
            	<table id="PerformanceInfoMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">            	
            	<s:iterator  var="metric" value="infoMetrics"  status="stat">
            		<s:if test="#metric.split(',')[0]=='componmentType'||#metric.split(',')[0]=='componmentName'">
            			<s:if test="#metric.split(',')[5]=='true'">
	            			<tr><td width="80%"><input type="checkbox" disabled=true checked="checked" name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  							<td width="20%"><input type="radio"    disabled=true name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
	           	    		</tr>
            			</s:if><s:else>
            				<tr><td width="80%"><input type="checkbox"  disabled=true name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  							<td width="20%"><input type="radio"     disabled=true name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
	           	    		</tr>
            			</s:else>           			
            		</s:if>
            		<s:else>
            			<s:if test="#metric.split(',')[0]=='DeviceName'">
            					<tr><td width="80%"><input type="checkbox"  disabled=true checked="checked"  name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  									<td width="20%"><input type="radio" id="PerformanceInfo_${sign }_first" name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>
            			</s:if><s:else>            			
            				<s:if test="#metric.split(',')[5]=='true'">
	            				<tr><td width="80%"><input type="checkbox"  checked="checked" onclick="checkMetric(this)" id="PerformanceInfo_${sign }_<s:property value="#stat.index" />" name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  									<td width="20%"><input type="radio" id="PerformanceInfo_${sign }_<s:property value="#stat.index" />_order" name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>	            			
            				</s:if><s:else>
	            				<tr><td width="80%"><input type="checkbox" onclick="checkMetric(this)" id="PerformanceInfo_${sign }_<s:property value="#stat.index" />" name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  								<td width="20%"><input type="radio" disabled=true id="PerformanceInfo_${sign }_<s:property value="#stat.index" />_order" name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
	           	    			</tr>
            				</s:else>             					
            			</s:else>            			           			
            		</s:else>           		
            	</s:iterator>        	                	
			</table>            		
			</div>
           </td></tr>
           </tbody>			
      </table>      
  </div>
   <div class="fold-content-padding">
   <table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="50%">性能指标(至少选择一个指标)</th>
               <th width="30%">单位</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="3" style="padding: 0 0 0 0;">
           <div style="width: 100%;height:143px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">           
            	<table id="PerformancePerMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">
           	   <s:iterator  var="metric" value="perMetrics"  status="stat">
           	   	<s:if test="#stat.index==0">
           	   		<tr>
		           	    <td width="50%"><input type="checkbox"  disabled=true checked="checked" name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
		           	    <td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
		           	    <td width="20%"><input type="radio" id="PerformancePer_${sign }_first" checked="checked" name="Performance_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	    	</tr>
           	   	</s:if>
           	   	 <s:else>           	   	 	
         	   	 	<s:if test="#metric.split(',')[6]=='true'">
         	   	 		<tr>
	          	   	 		<td width="50%"><input type="checkbox"  onclick="checkMetric(this)" id="PerformancePer_${sign }_<s:property value="#stat.index" />" checked="checked" name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
		           	    	<td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
		           	    	<td width="20%"><input type="radio" id="PerformancePer_${sign }_<s:property value="#stat.index" />_order" name="Performance_metricOrder_${sign }"  value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
         	   	 		</tr>
         	   	 	</s:if>
         	   	 	<s:else>
         	   	 		<tr>
	          	   	 		<td width="50%"><input type="checkbox"  onclick="checkMetric(this)" id="PerformancePer_${sign }_<s:property value="#stat.index" />"  name="Performance_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
		           	    	<td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
		           	    	<td width="20%"><input type="radio" disabled=true id="PerformancePer_${sign }_<s:property value="#stat.index" />_order" name="Performance_metricOrder_${sign }"  value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
         	   	 		</tr>
         	   	 	</s:else>           	   	 			           	            	    	
           	   	 </s:else>
           	   </s:iterator>          	       	   
			</table>                      
			</div>
           </td></tr>
          </tbody>			
      </table>
   </div>
  	 </s:if>
  	 <s:else>
  	 <div class="fold-content-padding" style="width: 100%;height:350px;">
  	 	<span class="nodata-l" style="margin:100px 230px" > <span class="nodata-r"> <span class="nodata-m"> <span class="icon">请选择资源</span> </span></span></span>
  	 </div>	  		
  	 </s:else>	
  </div> 
  </s:if>
  <s:if test="reportType=='Malfunction'">
  <div class="fold-blue">
  <div class="fold-top"><span class="fold-top-title">故障指标</span> </div>	
  	<s:if test="infoMetrics!=null"> 
  	<div class="fold-content-padding">	
  	<table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="80%">信息指标</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="2"  style="padding: 0 0 0 0;">
           <div style="width: 100%;height:176px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
           		 <table id="MalfunctionInfoMetric_${sign }"  border="0" width="100%" cellpadding="0" cellspacing="0">      	    
           	    <s:iterator  var="metric" value="infoMetrics"  status="stat">
            		<s:if test="#metric.split(',')[0]=='componmentType'||#metric.split(',')[0]=='componmentName'">
            			<s:if test="#metric.split(',')[5]=='true'">
	            			<tr><td width="80%"><input type="checkbox" disabled=true checked="checked" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true  name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:if><s:else>
            				<tr><td width="80%"><input type="checkbox" disabled=true  name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true  name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:else>           			
            		</s:if>
            		<s:else>
            			<s:if test="#metric.split(',')[0]=='DeviceName'">
            					<tr><td width="80%"><input type="checkbox"   disabled=true  checked="checked" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  									<td width="20%"><input type="radio"   id="MalfunctionInfo_${sign }_first"  name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>
            			</s:if><s:else>
	            			<s:if test="#metric.split(',')[5]=='true'">
		            			 <tr><td width="80%"><input type="checkbox" onclick="checkMetric(this)" id="MalfunctionInfo_${sign }_<s:property value="#stat.index" />" checked="checked" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  									<td width="20%"><input type="radio" id="MalfunctionInfo_${sign }_<s:property value="#stat.index" />_order"  name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>         			
	            			</s:if><s:else>
	            				<tr><td width="80%"><input type="checkbox"  onclick="checkMetric(this)" id="MalfunctionInfo_${sign }_<s:property value="#stat.index" />" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  								<td width="20%"><input type="radio" disabled=true id="MalfunctionInfo_${sign }_<s:property value="#stat.index" />_order"   name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
	           	    			</tr>
	            			</s:else>              					
            			</s:else>              			          			
            		</s:else>           		
            	</s:iterator>     	             	   
			</table>        
			</div>
           </td></tr>
           </tbody>			
      </table>      
   	<table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="50%">故障指标(至少选择一个指标)</th>
               <th width="30%">单位</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="3" style="padding: 0 0 0 0;">
           <div style="width: 100%;height:110px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
             	<table id="MalfunctionPerMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">           	  
           	    <s:iterator  var="metric" value="perMetrics"  status="stat">           	   	 
           	   	 	<s:if test="#metric.split(',')[0]=='AvailableState'">
           	   	 		<tr>
           	   	 			<td width="50%"><input type="checkbox" disabled=true  checked="checked" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	           	    		<td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
	           	    		<td width="20%"><input type="radio" checked="checked"  id="MalfunctionPer_${sign }_first" name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASC"/><span>升序</span></td>
           	   	 		 </tr>
           	   	 	</s:if>
           	   	 	<s:else>
           	   	 		 <s:if test="#metric.split(',')[6]=='true'">
		           	    		<tr>
		           	   	 			<td width="50%"><input type="checkbox"  onclick="checkMetric(this)" id="MalfunctionPer_${sign }_<s:property value="#stat.index" />" checked="checked" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
			           	    		<td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
			           	    		<td width="20%"><input type="radio"  id="MalfunctionPer_${sign }_<s:property value="#stat.index" />_order" name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASC"/><span>升序</span></td>
	           	   	 			</tr>
		           	    	</s:if><s:else>
		           	    		<tr>
		           	   	 			<td width="50%"><input type="checkbox" onclick="checkMetric(this)" id="MalfunctionPer_${sign }_<s:property value="#stat.index" />" name="Malfunction_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
			           	    		<td width="30%"><span><s:property value="#metric.split(',')[5]" /></span></td>
			           	    		<td width="20%"><input type="radio" disabled=true id="MalfunctionPer_${sign }_<s:property value="#stat.index" />_order" name="Malfunction_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASC"/><span>升序</span></td>
	           	   	 			</tr>
		           	    	</s:else>	
           	   	 	</s:else>	           	              	         	   
           	   </s:iterator>  
			</table>          
			</div>
           </td></tr>
           </tbody>			
      </table> 
     </div>
     </s:if>
  	 <s:else>
  	 <div class="fold-content-padding" style="width: 100%;height:350px;">
  	 	<span class="nodata-l" style="margin:100px 230px" > <span class="nodata-r"> <span class="nodata-m"> <span class="icon">请选择资源</span> </span></span></span>
  	 </div>	  		
  	 </s:else>
     </div>
   </s:if>
   <s:if test="reportType=='Event'">
   	<div class="fold-top"><span class="fold-top-title">事件指标</span> </div>
 	 <s:if test="infoMetrics!=null"> 
 	 <div class="fold-content-padding">	
  		<table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="80%">指标</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="2"  style="padding: 0 0 0 0;">
           <div style="width: 100%;height:286px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
            	<table id="EventInfoMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">
           	    <s:iterator  var="metric" value="infoMetrics"  status="stat">          		
           	    	<s:if test="#metric.split(',')[0]=='componmentType'||#metric.split(',')[0]=='componmentName'">
            			<s:if test="#metric.split(',')[5]=='true'">
	            			<tr>
	            				<td width="80%"><input type="checkbox" disabled=true checked="checked" name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:if><s:else>
            				<tr>
	            				<td width="80%"><input type="checkbox" disabled=true name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:else>           			
            		</s:if>
            		<s:else>
            				<s:if test="#metric.split(',')[0]=='DeviceName'">
            					<tr>
		            				<td width="80%"><input type="checkbox" checked="checked"   checked="checked" disabled=true name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  								<td width="20%"><input type="radio" id="EventInfo_${sign }_first"   name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>
            				</s:if><s:else>
            					<s:if test="#metric.split(',')[5]=='true'">
            				   		<tr>
		            					<td width="80%"><input type="checkbox" checked="checked"  onclick="checkMetric(this)" id="EventInfo_${sign }_<s:property value="#stat.index" />" checked="checked"  name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	  									<td width="20%"><input type="radio" id="EventInfo_${sign }_<s:property value="#stat.index" />_order"  name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    					</tr>
            					</s:if><s:else>
            						<tr>
	            						<td width="80%"><input type="checkbox"   onclick="checkMetric(this)" id="EventInfo_${sign }_<s:property value="#stat.index" />" name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  										<td width="20%"><input type="radio" disabled=true id="EventInfo_${sign }_<s:property value="#stat.index" />_order"  name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;ASCII"/><span>ASCII码</span></td>         	    
           	    					</tr>
            					</s:else>          					
            				</s:else>   			            			
            		</s:else> 
            	</s:iterator>  
			 </table>			
			 <table id="EventPerMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">           
           	    <s:iterator  var="metric" value="perMetrics"  status="stat">           	   	 
           	   	 	<s:if test="#metric.split(',')[0]=='NOTCONFIRMNUM'">
           	   	 		<tr>
           	   	 			<td width="80%"><input type="checkbox" checked="checked" disabled=true name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	           	    		<td width="20%"><input type="radio" id="EventPer_${sign }_first" checked="checked" name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 		 </tr>
           	   	 	</s:if>	         	  
	           	    <s:else>
	           	    	<s:if test="#metric.split(',')[6]=='true'">
	           	    		<tr>
		          	   	 		<td width="80%"><input type="checkbox"  onclick="checkMetric(this)" id="EventPer_${sign }_<s:property value="#stat.index" />"  checked="checked" name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>	          
		           	    		<td width="20%"><input type="radio"  id="EventPer_${sign }_<s:property value="#stat.index" />_order" name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 			</tr> 
	           	    	</s:if><s:else>
	           	    		<tr>
		          	   	 		<td width="80%"><input type="checkbox"  onclick="checkMetric(this)" id="EventPer_${sign }_<s:property value="#stat.index" />" name="Event_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>	          
		           	    		<td width="20%"><input type="radio" disabled=true  id="EventPer_${sign }_<s:property value="#stat.index" />_order"  name="Event_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 			</tr> 
	           	    	</s:else>	           	    	 
	           	    </s:else>  	           	         	   
           	   </s:iterator> 
			</table>       
			</div>
           </td></tr>
           </tbody>			
      </table>      
   	</div>
   	 </s:if>
   	 <s:else>
  	 <div class="fold-content-padding" style="width: 100%;height:350px;">
  	 	<span class="nodata-l" style="margin:100px 230px" > <span class="nodata-r"> <span class="nodata-m"> <span class="icon">请选择资源</span> </span></span></span>
  	 </div>	  		
  	 </s:else>
   </s:if>
   <s:if test="reportType=='Alarm'">
   	<div class="fold-top"><span class="fold-top-title">告警指标</span> </div>
 	  <s:if test="infoMetrics!=null"> 
 	 <div class="fold-content-padding">	
  		<table class="bluegrid table-width100 table-grayborder">
           <thead>
             <tr>
               <th width="80%">指标</th>
               <th width="20%">排序</th>
             </tr>
           </thead>           
           <tbody>
           <tr><td colspan="2"  style="padding: 0 0 0 0;">
           <div style="width: 100%;height:286px;overflow-y:auto; overflow-x:hidden; padding: 0 0 0 0; margin:0;">
            <s:if test="infoMetrics!=null">
            	<table id="AlarmInfoMetric_${sign }" border="0" width="100%" cellpadding="0" cellspacing="0">
           	   <s:iterator  var="metric" value="infoMetrics"  status="stat">            		
           	    	<s:if test="#metric.split(',')[0]=='componmentType'||#metric.split(',')[0]=='componmentName'">
            			<s:if test="#metric.split(',')[5]=='true'">
	            			<tr><td width="80%"><input type="checkbox" disabled=true checked="checked" name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true name="Alarm_metricOrder_${sign }"  value="<s:property value="#metric.split(',')[0]" />_ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:if><s:else>
            				<tr><td width="80%"><input type="checkbox" disabled=true  name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  								<td width="20%"><input type="radio" disabled=true name="Alarm_metricOrder_${sign }"  value="<s:property value="#metric.split(',')[0]" />_ASCII"/><span>ASCII码</span></td>         	    
           	    			</tr>
            			</s:else>           			
            		</s:if>
            		<s:else>
            			<s:if test="#metric.split(',')[0]=='DeviceName'">
            					<tr><td width="80%"><input type="checkbox" disabled=true checked="checked" name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  									<td width="20%"><input type="radio" id="AlarmInfo_${sign }_first" name="Alarm_metricOrder_${sign }"  value="<s:property value="#metric.split(',')[0]" />_ASCII"/><span>ASCII码</span></td>         	    
           	    				</tr>
            				</s:if><s:else>
            					<s:if test="#metric.split(',')[5]=='true'">          				
            				  	        <tr><td width="80%"><input type="checkbox" onclick="checkMetric(this)" id="AlarmInfo_${sign }_<s:property value="#stat.index" />"  checked="checked" name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  										<td width="20%"><input type="radio" id="AlarmInfo_${sign }_<s:property value="#stat.index" />_order"   name="Alarm_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />_ASCII"/><span>ASCII码</span></td>         	    
           	    						</tr>    			
            					</s:if><s:else>
            						<tr><td width="80%"><input type="checkbox" onclick="checkMetric(this)" id="AlarmInfo_${sign }_<s:property value="#stat.index" />"  name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
  										<td width="20%"><input type="radio" disabled=true id="AlarmInfo_${sign }_<s:property value="#stat.index" />_order"  name="Alarm_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />_ASCII"/><span>ASCII码</span></td>         	    
           	    					</tr>
            					</s:else> 
            						
            				</s:else>           			           			
            		</s:else> 
            	</s:iterator>          	    
			</table>			
			 <table id="AlarmPerMetric_${sign }"  border="0" width="100%" cellpadding="0" cellspacing="0">          
           	     <s:iterator  var="metric" value="perMetrics"  status="stat">           	   	 
           	   	 	<s:if test="#metric.split(',')[0]=='AlarmNum'">
           	   	 		<tr>
           	   	 			<td width="80%"><input type="checkbox" checked="checked" disabled=true name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>
	           	    		<td width="20%"><input type="radio" id="AlarmPer_${sign }_first" checked="checked" name="Alarm_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 		 </tr>
           	   	 	</s:if>	         	  
	           	    <s:else>
	           	    	<s:if test="#metric.split(',')[6]=='true'">
	           	    		<tr>
		          	   	 		<td width="80%"><input type="checkbox"   onclick="checkMetric(this)" id="AlarmPer_${sign }_<s:property value="#stat.index" />" checked="checked" name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>	          
		           	    		<td width="20%"><input type="radio"  id="AlarmPer_${sign }_<s:property value="#stat.index" />_order" name="Alarm_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 			</tr>  
	           	    	</s:if><s:else>
	           	    		<tr>
		          	   	 		<td width="80%"><input type="checkbox"   onclick="checkMetric(this)" id="AlarmPer_${sign }_<s:property value="#stat.index" />" name="Alarm_metric_${sign }" value="<s:property value="#metric" />"/><span><s:property value="#metric.split(',')[1]" /></span></td>	          
		           	    		<td width="20%"><input type="radio" disabled=true  id="AlarmPer_${sign }_<s:property value="#stat.index" />_order" name="Alarm_metricOrder_${sign }" value="<s:property value="#metric.split(',')[0]" />;DESC"/><span>降序</span></td>
           	   	 			</tr>
	           	    	</s:else>	           	    	
	           	    </s:else>  	           	         	   
           	   </s:iterator> 
			</table>
            </s:if>
            <s:else>
            	<span class="nodata-l" style="margin:50px 230px" > <span class="nodata-r"> <span class="nodata-m"> <span class="icon">请选择资源</span> </span></span></span>
            </s:else>           
			</div>
           </td></tr>
           </tbody>			
      </table>      
   	</div>
   	 </s:if>
   	 <s:else>
  	 <div class="fold-content-padding" style="width: 100%;height:350px;">
  	 	<span class="nodata-l" style="margin:100px 230px" > <span class="nodata-r"> <span class="nodata-m"> <span class="icon">请选择资源</span> </span></span></span>
  	 </div>	  		
  	 </s:else>
   </s:if>
<script  type="text/javascript">
$(function(){
	var childResourceType=$("#compomentSelect_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(childResourceType)){
		var period=cacheObj.getPeriod();	
	}
	var order=$("#"+cacheObj.getReportType()+"_orderValue_"+cacheObj.getRowID()).val();
	if(objValue.isNotEmpty(order)){
		var metric=order.split(";")[0];
		$("input[name$='"+cacheObj.getReportType()+"_"+metric+"_"+cacheObj.getRowID()+"']").attr("checked",true);
	}
	
});
function checkMetric(obj){
	var id=obj.id+"_order";
	if($(obj).attr("checked")){
		$("#"+id).attr("disabled",false);
	}else{
		if($("#"+id).attr("checked")){
			$("#"+id).attr("checked",false);
			var signs=obj.id.split("_");
			$("#"+signs[0]+"_"+signs[1]+"_first").attr("checked",true);
		}
		$("#"+id).attr("disabled",true);
	}
}
</script>
