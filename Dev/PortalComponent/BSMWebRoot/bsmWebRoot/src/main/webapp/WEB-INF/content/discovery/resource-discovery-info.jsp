<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<s:form id="form1" name="form1" method="post" enctype="multipart/form-data" >
	<div id="disc_info">
			<s:iterator value="discInfoGroups" id="discInfos">
				<s:if test="discGroupId != null">
					<div class="h4">
						<%-- s:property value="discGroupId"/>&nbsp;--%><s:property value="discGroupName"/>&nbsp;
					</div>
				</s:if>
				<ul class="fieldlist">
					<s:iterator value="discInfos" >
						<li>
							<span class="field"><s:property value="displayName"/></span><span><s:text name="i18n.discovery.colon"/></span>${fieldHTML}<s:if test="notNull"><span class="red">*</span></s:if><s:if test="helpInfo != null"><span class="ico ico-what" title="<s:property value="helpInfo"/>"></span></s:if>										
						</li>
					</s:iterator>
				</ul>
			</s:iterator>
	</div>
</s:form>
