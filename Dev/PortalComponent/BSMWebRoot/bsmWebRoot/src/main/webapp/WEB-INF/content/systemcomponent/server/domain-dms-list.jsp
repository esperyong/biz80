<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<form name="domaindmsformname" id="domaindmsformname">
	<input type="hidden" name="domainId" value="${domainId }"/>
	<div class="panel-gray">
		<div class="panel-gray-top">
			<span class="panel-gray-title"> ${domainPageName}资源发现时使用的DMS</span>
		</div>
		<div class="panel-gray-content">
			<!-- DMS列表 -->
			<div class="select-lr" >			
				<div class="left-n" style="width:40%;">
					<div class="panel-gray">
						<div class="panel-gray-top"><span class="bold">待选DMS</span></div>
						<!-- 未选 -->
						<div class="gray-border">
							<select id="unselect" multiple="multiple" style="text-align: center;width: 96%;height: 150px;">
								<s:iterator value="unDmsList" id="unselect">
									<option value="${unselect.dmsId }">${unselect.dmsName }</option>
								</s:iterator>
							</select>
						</div>
					</div>
				</div>
				<div class="middle" >
					<span class="turn-right" id="addDMS"></span>
					<span class="turn-left" id="removeDMS"></span>
				</div>
				<div class="right-n" style="width:40%;">
					<div class="panel-gray">
						<div class="panel-gray-top"><span class="bold">已选DMS</span></div>
						<!-- 已选 -->
						<div class="gray-border" id="right_resIns">
							<select id="selected" multiple="multiple" style="text-align: center;width: 96%;height: 150px;">
								<s:iterator value="dmsListed" id="selected">
									<option value="${selected.dmsId }">${selected.dmsName }</option>
								</s:iterator>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="right">
				<span class="black-btn-l"><span class="btn-r"><span class="btn-m"><a id="domaindmsselectsubmit" href="javascript:void(0);">应用</a></span></span></span>
			</div>
		</div>
	</div>
</form>