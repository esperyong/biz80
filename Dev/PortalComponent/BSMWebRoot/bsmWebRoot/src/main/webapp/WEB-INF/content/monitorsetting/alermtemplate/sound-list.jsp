<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
		<table class="black-grid black-grid-blackb">
		<colgroup><col width="15%"><col width="15%"><col width="70%"></colgroup>
		<form name="soundlightserverformname" id="soundlightserverformname" method="post">
		<input type="hidden" name="domainId" id="domainId" value="${domainId }"/>
		<tr>
		  <th>级别</th>
          <th>告警灯</th>
          <th>描述</th>
		</tr>			
		
			<s:iterator id="list"   value="tabList" status="i">
			<s:if test="#i.index%2==0"><tr class="black-grid-graybg"></s:if>
			<s:else><tr></s:else>
			
			
				<td>
				<s:property value="#list.eventName" /></td>
				<td><select name="soundselect" id="${list.eventClass}" onchange="changeDetail(this,'${list.eventClass }&${list.eventName }&${list.templateDesc }')">
					<s:if test="#list.templateZhText=='RED'">
						<option value="RED&${list.eventClass }&${list.eventName }&${list.templateDesc }" selected >红灯</option>
					</s:if>
					<s:else>
						<option value="RED&${list.eventClass }&${list.eventName }&${list.templateDesc }"  >红灯</option>
					</s:else>
					
					<s:if test="#list.templateZhText=='YELLOW'">
						<option value="YELLOW&${list.eventClass }&${list.eventName }&${list.templateDesc }" selected >黄灯</option>
					</s:if>
					<s:else>
						<option value="YELLOW&${list.eventClass }&${list.eventName }&${list.templateDesc }"  >黄灯</option>
					</s:else>
					
					<s:if test="#list.templateZhText=='GREEN'">
						<option value="GREEN&${list.eventClass }&${list.eventName }&${list.templateDesc }" selected >绿灯</option>
					</s:if>
					<s:else>
						<option value="GREEN&${list.eventClass }&${list.eventName }&${list.templateDesc }"  >绿灯</option>
					</s:else>
					
					<s:if test="#list.templateZhText=='NONE'">
						<option value="NONE&${list.eventClass }&${list.eventName }&${list.templateDesc }" selected >无</option>
					</s:if>
					<s:else>
						<option value="NONE&${list.eventClass }&${list.eventName }&${list.templateDesc }"  >无</option>
					</s:else>
				</select></td>
				<td>当产生声光告警的事件级别为{<s:property value="#list.eventName" />}时,<span id="${list.eventClass}Detail">亮“红灯”。</span></td>
				</tr>
			</s:iterator>
			
					
				</form>
</table>

		
<script language="javascript">

try{document.getElementById('UNKNOWN').onchange();}catch(e){}
try{document.getElementById('INFORMATIONAL').onchange();}catch(e){}
try{document.getElementById('SEVERE').onchange();}catch(e){}
try{document.getElementById('ERROR').onchange();}catch(e){}
try{document.getElementById('CRITICAL').onchange();}catch(e){}
try{document.getElementById('WARNING').onchange();}catch(e){}
try{document.getElementById('OTHERS').onchange();}catch(e){}


	function changeDetail(obj,test){
	//alert(test);
	var tdObj = document.getElementById(obj.id+"Detail");
	//alert(obj.value);
	//alert("RED&"+test);
	if(obj.value == "RED&"+test){
		tdObj.innerText="亮“红灯”。";
	}
	if(obj.value == "YELLOW&"+test){
		tdObj.innerText="亮“黄灯”。";
	}
	if(obj.value == "GREEN&"+test){
		tdObj.innerText="亮“绿灯”。";
	}
	if(obj.value == "NONE&"+test){
		tdObj.innerText="不亮灯。";
	}
}
</script>