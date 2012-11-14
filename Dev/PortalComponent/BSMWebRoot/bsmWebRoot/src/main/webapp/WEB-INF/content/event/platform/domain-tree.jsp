<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<link href="${ctx}/css/jquery-ui/treeview.css" rel="stylesheet" type="text/css" ></link>
<script type="text/javascript" src="${ctx}/js/component/treeView/tree.js"></script>
<style type="text/css">
.focus{
      border:1px solid #f00;
      background:#fcc;
}
</style>
<div id="treeDiv" style="color:#fff;background:#000;height:150px;overflow-y:auto;overflow-x:hidden;">
<DIV STYLE="overflow: hidden; text-overflow:ellipsis" title=""><NOBR></NOBR></DIV>
${domainTree}
</div>
<script type="text/javascript">
var tree = new Tree({id:"domainTree"});
$('#treeDiv li').css('word-wrap','normal');
$("#treeDiv span[type='text']").each(
	function() {
		var text = $(this).text();
		$(this).empty();
		$(this).append("<span STYLE='width:170px;overflow: hidden; text-overflow:ellipsis;display: inline-block;' title='" + text + "'>" + text + "</span>");
	}
);
</script>