<!-- WEB-INF\content\location\relation\editRemark.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base target="_self">
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>显示关联设置</title>
<script type="text/javascript">
$(document).ready(function() {
	/*因为第二遍不能绑定事件所以改成方法声明方式	*/
	$("#closeId").click(function (){
		if(panel){panel.close("close");}
	});

	$("#submitId").click(function (){
		
		$.ajax({
			url: 		"${ctx}/location/relation/device!editRemark.action",
			data:		"equipment.id=" + $("#e_id").val() + "&equipment.description=" + encodeURI($("#e_desc").val()),
			dataType: 	"html",
			cache:		false,
			success: function(data, textStatus){

				// 重新加载数据
				//$("#search").click();
				document.getElementById("search").click();
			}
		});
		panel.close("close");
	});

});

</script>
</head>

<body >
<div id="remark_div">
<ul>
<li>
<div>
<s:hidden name="equipment.id" id="e_id"/>
<s:textarea name="equipment.description" id="e_desc" rows="5" cols="50"></s:textarea>
</div></li>
<li><div class="t-right">
<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="submitId"><a>确定</a></span></span></span>
<span class="gray-btn-l"><span class="btn-r"><span class="btn-m" id="closeId"><a>取消</a></span></span></span>
</div></li>
</ul>
</div>
</body>
</html>