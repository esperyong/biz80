<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>
<%@ include file="/WEB-INF/common/meta.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>	
	<script type="text/javascript" src="${ctxJs}/jquery-1.4.2.min.js" ></script>
	<script type="text/javascript">
	    $(function(){
	    	var url="${ctx}/${reportPath} ";	
			$.ajax({
				   type: "POST",
				   dataType:'html',
				   url: url,
				   success: function(data, textStatus){	
					   $("#readReport").html(data);			   
				   }			
			 });
	    });	
	</script>
	</head>
	<body>
		<div  id="readReport" style="background-color:#fff; width: 1000px;height:750px;overflow:auto;"></div>
	</body>
</html>

