<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%@ include file="/WEB-INF/common/meta.jsp" %>



<div id="remark_div">
	<ul>
		<li>
			<div>
			<input type="hidden" name="e_id" id="e_id" value="<s:property value='deviceId'/>"/>
			<textarea name="e_desc" id="e_desc" rows="5" cols="42" ><s:property value='note'/> </textarea>
			</div>
		</li>
		<li>
			<div class="t-right">
			<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="submitId"><a>确定</a></span></span></span>
			<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="closepanelId" ><a>取消</a></span></span></span>
			</div>
		</li>
	</ul>
</div>

