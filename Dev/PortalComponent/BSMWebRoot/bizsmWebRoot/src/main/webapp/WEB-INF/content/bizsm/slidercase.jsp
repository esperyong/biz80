<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- 
	author:qiaozheng
	description:业务服务定义首页
	uri:{domainContextPath}/bizsm/bizservice/ui/bizdefinemain
 -->
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<title>滑动块测试</title>
<link href="${ctx}/css/jquery-ui/jquery.ui.slider.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js"></script>


<script src="${ctx}/js/component/cfncc.js" type="text/javascript"></script>

<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.core.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.widget.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.mouse.js"></script>
<script type="text/javascript" src="${ctx}/js/component/plugins/jquery.ui.slider.js"></script>

<script type="text/javascript" src="${ctx}/js/component/slider/j-dynamic-slider.js"></script>


<script type="text/javascript">
	
	$(function() {
		var jDynamicSlide = new JDynamicSlider({id:"slider-range-case1",defaultValue:10,min:1,max:100});
		
		jDynamicSlide.change(function(value){
			$("#amount").val(value);
		});

		jDynamicSlide.appendToContainer($("#jd-slider-root"));
		
		//alert($("#jd-slider-root").html());
		
		$("#amount").val(jDynamicSlide.getValue());

		$('input[type=button]').click(function(){
			var num = $('#amount').val();
			jDynamicSlide.setValue(num);
		});
	});
	</script>
</head>
<body>

<div class="demo">

<p>
<label for="amount">Maximum price:</label>
<input type="text" id="amount" style="border:1; color:#f6931f; font-weight:bold;" />
</p>

<div id="jd-slider-root"></div>

</div><!-- End demo -->

<div class="demo-description">

<p>Fix the minimum value of the range slider so that the user can only select a maximum.  Set the <code>range</code> option to "min."</p>

</div><!-- End demo-description -->
<input type="button" value=" Apply ">
</body>
</html>
