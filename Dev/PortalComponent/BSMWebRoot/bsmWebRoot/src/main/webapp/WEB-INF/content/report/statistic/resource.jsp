<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<div class="fold-blue" style="background-color:#fff;">
	<div id="resoure_${sign }">
	<div id="perDisplay" class="fold-top" style="display:none"><span class="sub-panel-tips">说明：这里只显示具有“性能指标”的资源或组件。</span></div>
	<div id="malDisplay" class="fold-top" style="display:none"><span class="sub-panel-tips">说明：这里只显示具有“可用性指标”的资源或组件。</span></div>
		<div  class="for-inline">			
					<ul class="fieldlist-n" >					
					<s:form id="resourceForm_%{sign}">					 	
					 	<input type="hidden" name="sign" value="<s:property value="sign" />">
						<li  class="left-menu">													 				
							<span >资源类型：</span> 
							<select id="resoureTypeSelect_${sign }" name="resourceCategory" style="width:180px" onchange="initRes(this),initForm(this),loadInstance()" >						
								<s:if test="resourceTree==null">
									<option  value="" >请选择</option>
								</s:if>
								<s:else>
									<s:iterator  var="resource" value="resourceTree"  status="stat">
										<s:if test="#resource.key==resourceCategory">
											<option selected="selected" value="<s:property value="#resource.key" />"><s:property value="#resource.value" /></option>
										</s:if>
										<s:else>
											<option  value="<s:property value="#resource.key" />"><s:property value="#resource.value" /></option>
										</s:else>																			        	    	 			
						    		</s:iterator>									
								</s:else>				
							</select>	
							<select id="resourceModelSelect_${sign }" name="resourceModel"  style="width:240px" onchange="loadResModel(this),initForm(this),loadInstance()">						
								<option  value="<s:property value="resourceCategory" />">全部</option>
								<s:iterator  var="modle" value="resourceModleTree"  status="stat">
									<s:if test="#modle.key==resourceModel">
										<option selected="selected" value="<s:property value="#modle.key" />"><s:property value="#modle.value" /></option>
									</s:if>
									<s:else>
										<option  value="<s:property value="#modle.key" />"><s:property value="#modle.value" /></option>
									</s:else>																			        	    	 			
						    	</s:iterator>							    	
							</select>		
							<s:if test="reportType!='Malfunction'">
								<span>组件类型：</span>
								<select id="compomentSelect_${sign }" name="childResourceType"  style="width:80px" onchange="initForm(this),loadInstance()">
									<option value="">请选择</option>
										<s:iterator  var="componment" value="componmentTree"  status="stat">
										<s:if test="#componment.key==childResourceType">
											<option selected="selected" value="<s:property value="#componment.key" />"><s:property value="#componment.value" /></option>
										</s:if>
										<s:else>
											<option  value="<s:property value="#componment.key" />"><s:property value="#componment.value" /></option>
										</s:else>																			        	    	 			
							    	</s:iterator>								
								</select>
							</s:if>																	
						</li>
						<li class="left-menu">	
							<span ><s:property value="domainPageName" />：</span>
							<select id="domainId_${sign }" name="domainId" onchange="reLoadResourceTree()">
								<s:iterator  var="domainId" value="domainIds"  status="stat">
									<s:if test="#domainId.key==domainId">
										<option selected="selected"  value="<s:property value="#domainId.key" />"><s:property value="#domainId.value" /></option>
									</s:if>
									<s:else>
										<option  value="<s:property value="#domainId.key" />"><s:property value="#domainId.value" /></option>
									</s:else>										        	    	 			
							    </s:iterator>														
							</select>
							<span>搜索：</span>						
							<select id="pageQuerySearch_${sign }"  onchange="choiceSearchType(this)">							    							
								<option value="SEARCHTYPE_IPADDRESS">按IP地址</option>
								<option value="SEARCHTYPE_NAME">按名称</option>	
							</select>
							<input type="hidden" name="pageQueryVO.searchType" id="searchType_${sign }" value=''/>
							<input type="text" size="30" name="pageQueryVO.searchValue" id="searchValue_${sign }" value="请输入条件进行搜索"/><span id="pageQueryVO_${sign }" onclick="initForm(this),loadInstance()" class="ico ico-find" title="搜索"></span>			      						        							
						</li>
						<li class="right-content" style="width:725px">		
							<input type="hidden"  id="instancesParent_${sign }" name="instanceParent" value="<s:property value="instanceParent" />"/>						
							<input type="hidden"  id="instances_${sign }" name="instance" value="<s:property value="instance" />">							
							<input type="hidden"  id="returnType_${sign }" name="returnType" value="<s:property value="returnType" />"/>
							<input type="hidden"  id="compositor_${sign }" name="pageQueryVO.compositor" value="COMPOSITOR_DISPLAYNAME">
							<input type="hidden"  id="order_${sign }" name="pageQueryVO.order" value='ASC'>
							<input type="hidden"  id="pageSize_${sign }" name="pageQueryVO.pageSize" value="12">
							<input type="hidden"  id="pageNumber_${sign }" name="pageQueryVO.pageNumber" value="1">
							<div id="choiceResource_${sign }" style="height: 300px"></div>				      						        							
						</li>
						</s:form>
					</ul>				    				  			    
		</div>
	</div>	
</div>
<script type="text/javascript">
$(document).ready(function(){	
	if(cacheObj.getReportType()=="Performance"){
		$("#perDisplay").css("display","block");
	}else if(cacheObj.getReportType()=="Malfunction"){
		$("#malDisplay").css("display","block");
	}
	loadInstance();//初始化资源实例	
});
$("#searchValue_${sign }").bind("click",function(){
	$(this).val("");
});
</script>
