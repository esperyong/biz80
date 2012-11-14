<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<div class="manage-content" style="width:100%;">
	<div class="top-l"><div class="top-r"><div class="top-m"> </div></div></div>
    <div class="mid" >
		<div class="h1">
			<span class="bold">当前位置：</span>
			<span>系统部署 / 资源发现与DMS  / 资源发现与DMS  </span>
		</div>
		<div class="h1">
			<span><span class="ico ico-tips"></span>1.只针对配置管理员生效。2.为配置管理员发现不同${domainPageName}资源，配置不同的DMS。</span>
		</div>
		
		<div class="left-content" style="width:25%;">
			<div class="panel-gray">
				<div class="panel-gray-top">
					<span class="panel-gray-title"> 资源所属${domainPageName}</span>
				</div>
				<div class="panel-gray-content" style="height=400px;width:200px;overflow:auto;">
					<!-- 域列表 -->
					<ul>
					<input type="hidden" id="old_style" name="old_style">
					<s:iterator id="l1" value="domainList" status="i">
						<li><span name="domainListName" id="<s:property value="#l1.domainId" />" style="cursor: hand">
						<s:if test="#i.index==0">
							<script type="text/javascript">
								document.getElementById('old_style').value='<s:property value="#l1.domainId" />_style';
							</script>
							<div name="<s:property value="#l1.domainId" />_style" id="<s:property value="#l1.domainId" />_style" class="bold">
						</s:if>
						<s:else>
							<div name="<s:property value="#l1.domainId" />_style" id="<s:property value="#l1.domainId" />_style">
						</s:else>
						<s:property value="#l1.domainName" /></div></span></li>
					</s:iterator>
					</ul>
				</div>
			</div>
		</div>
		<div id="domaindmsrightDiv" class="right-content" style="width:70%;">
				<s:action name='domain-dms-list' namespace="/systemcomponent/server" executeResult="true" flush="false">
					<s:param name='domainId' value='domainId' />
				</s:action>
		</div>
	</div>
	<div class="bottom-l"><div class="bottom-r"><div class="bottom-m"> </div></div></div>
</div>