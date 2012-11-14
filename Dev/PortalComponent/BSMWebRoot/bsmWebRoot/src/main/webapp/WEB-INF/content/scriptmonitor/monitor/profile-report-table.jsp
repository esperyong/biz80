<%--  
 *************************************************************************
 * @source  : profile-report-table.jsp
 * @desc    : Mocha BSM 8.0
 *------------------------------------------------------------------------
 * VER  DATE         AUTHOR      DESCRIPTION
 * ---  -----------  ----------  -----------------------------------------
 * 1.0  2011.5.30	 huaf     	  报表数据表
 * ----------- ----------  -----------------------------------------------
 * Copyright(c) 2011 mochasoft,  All rights reserved.
 *************************************************************************
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<s:set name="tdWidth" value="150"/>
<div  style="width:980px;overflow-x:hidden;" id="tableTitle">
<table  class="tongji-grid table-width100"  cellspacing="0" cellpadding="0">
		<tr>
			<s:iterator id="column" value="scriptDatas[0]" status="st">
				<s:if test="#st.index == 0">
					<th><div style="width:${tdWidth}px;height:20px;" title="时间">时间</th>
				</s:if>
				<s:else>
					<th><div style="width:${tdWidth}px;height:20px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;"  title="<s:property value="#column"/>"><s:property value="#column"/></div></th>
				</s:else>
			</s:iterator>
		</tr>
</table>
</div>
<s:if test="scriptDatas.size > 1">
<div style="width:980px;overflow-x:auto;overflow-y:auto;height:480px;" id="tableContent" onScroll="myMove();">
<table class="tongji-grid table-width100" cellspacing="0" cellpadding="0">
	<s:iterator id="row" value="scriptDatas" status="st">
	<tr>
		<s:if test="#st.index != 0">
			<s:iterator id="column" value="top" status="st2">
					<td class="line"><div style="width:${tdWidth}px;height:20px;text-overflow:ellipsis;white-space:nowrap; overflow:hidden;"  title="<s:property value="#column"/>"><s:property value="#column"/></div></td>
			</s:iterator>
		</s:if>
	</tr>
	</s:iterator>
</table>
</div>
</s:if>
<s:else>
<s:set name="emptyWidth" value="scriptDatas[0].size*#tdWidth"/>
<s:if test="#emptyWidth < 980">
	<s:set name="emptyWidth" value="980"/>
</s:if>
<div  style="width:980px;height:480px;overflow-x:auto;overflow-y:auto;" id="tableContent" onScroll="myMove();">
	<div style="width:${emptyWidth}px;text-align:center;padding-top:150px;padding-bottom:150px;">
		 <span class="nodata-l">
			 <span class="nodata-r">
			   	   <span class="nodata-m"><span class="icon">当前无数据</span></span>
			 </span>	
		 </span> 
	</div>
</div>
</s:else>
<script>
	function myMove(){
		$("#tableTitle").scrollLeft($("#tableContent").scrollLeft());
	}
	</script>