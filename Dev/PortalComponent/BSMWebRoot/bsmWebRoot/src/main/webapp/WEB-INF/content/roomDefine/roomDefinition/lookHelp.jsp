<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>

<%@ include file="/WEB-INF/common/meta.jsp" %>
<base target="_self">
<title>备注</title>



<div id="remark_div">
	<ul>
		<li>
			<div>
			<textarea name="e_desc" id="e_desc" rows="8" cols="70" readonly style="overflow:auto"> <s:property value='note'/> </textarea>
			</div>
		</li>
		<li>
			<div class="t-right">
<!--			<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="submitId"><a>确定</a></span></span></span>-->
<!--			<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="closemeId"  ><a>关闭</a></span></span></span>-->
			</div>
		</li>
	</ul>
</div>

<script type="text/javascript">

	$("#e_desc").focus().click(function(event){
		event.stopPropagation();
	});
	$("#closemeId").click(function (){
		if(panel){panel.close("close");}
	});

	/* $("#submitId").click(function (){
		alert(0);
		$.ajax({
			url: 		"${ctx}/roomDefine/EditNote!updateNote.action",
			data:		"deviceId=" + $("#e_id").val() + "&note=" + encodeURI($("#e_desc").val()),
			dataType: 	"html",
			cache:		false,
			success: function(data, textStatus){

			}
		});
		panel.close();
	}); */

</script>