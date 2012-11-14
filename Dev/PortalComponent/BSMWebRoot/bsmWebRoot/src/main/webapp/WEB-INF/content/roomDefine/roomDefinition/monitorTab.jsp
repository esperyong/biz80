<!-- 机房-机房定义-设备tab  monitorTab.jsp -->
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>设备列表</title>
<link rel="stylesheet" href="${ctx}/css/common.css"
	type="text/css" />

<script type="text/javascript">
  $(function(){
      var tp = new TabPanel({id:"mytab",
	  				width:400,
					tabBarWidth:300			
					});
  });
</script>
</head>

<body>
	<div id="mytab" class="tab-grounp">
	<div class="tab-mid">
	<div class="tab-foot">
	<ul style="position: relative;">
		<li class="nonce">
		<div class="tab-l">
		<div class="tab-r">
		<div class="tab-m"><a href="#">常规信息</a></div>
		</div>
		</div>
		</li>
		<li>
		<div class="tab-l">
		<div class="tab-r">
		<div class="tab-m"><a href="#">设备列表</a></div>
		</div>
		</div>
		</li>
	</ul>
	</div>
	<div>tab1</div>
	<div style="display: none">tab2</div>
	</div>
	</div>
</body>


</html>
<script type="text/javascript">




</script>