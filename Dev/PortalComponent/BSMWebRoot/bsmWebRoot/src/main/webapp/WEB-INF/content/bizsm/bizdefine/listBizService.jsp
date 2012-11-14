<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
 author:liuyong
 description:业务服务列表
 uri:{domainContextPath}/bizservice/?canAdoptByServiceId={bizserviceId}
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>列出所有业务服务列表选择业务服务到topo</title>
<link href="${ctx}/css/portal.css" rel="stylesheet" type="text/css" />
<link href="${ctx}/css/master.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="${ctx}/js/bizservice/ajaxcommon.js"></script>
<script>
 $(function(){
		$('#bizServiceImg-box>ul>li').click(function(){
			var $this = $(this);
			
			var $oldClicked = $('#bizServiceImg-box>ul>li.on');
			$oldClicked.removeClass("on");
			$oldClicked.attr("isClicked", "false");

			$this.attr("isClicked", "true");
			$this.addClass("on");

			parent.choose("bizservice", $this.find(">span").attr("uri"));
		});

		$('#bizServiceImg-box>ul>li').hover(function(){
			var $this = $(this);
			$this.addClass("on");
		}, function(){
			var $this = $(this);
			if($this.attr("isClicked") != "true"){
				$this.removeClass("on");
			}
		});

 });
</script>
</head>
<body>

<div class="set-panel-content-white">
	<div class="sub-panel-open">
	 <div class="sub-panel-top">
		 <span class="sub-panel-title"><s:text name="i18n.bizservice.bizdefine.2" /></span>
	 </div>
	 <div id="bizServiceImg-box" class ="img-show">
	 	<ul>
	 	<s:iterator value="model.services" status="status">
	 		<li>
	 			<img src="${ctx}/images/bizservice-default/default-bizservice-icon.png"/>
	 			<span style="cursor:hand" uri='<s:property value="uri"/>' bizId='<s:property value="bizId"/>'>
	 				<s:property value="name"/>
	 				<input type="hidden" name="uri" value="<s:property value="uri"/>" />
	 				<input type="hidden" name="bizId" value="<s:property value="bizId"/>" />
	 			</span>
	 		</li>
	 	</s:iterator>
	 	</ul>
	 </div>    
	</div>
</div>
</body>
</html>