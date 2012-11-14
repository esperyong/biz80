<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<html>
	<head>
	<script type="text/javascript" src="${ctx}/js/jquery-1.4.2.min.js" ></script>
	<script type="text/javascript">
    $(function(){
      parent.parent.setNotChange();
      var isMax = "${max}";
      if(isMax=="true") {
        // 文件大于5MB
        if(parent && parent.fileIsMax){
          parent.fileIsMax();
        }
      } else{
        var fileName = $("#uploadFileName").val();
        if(parent && parent.reloadDataMatch){
          parent.reloadDataMatch(fileName);
        }
      }
    });
	</script>
	</head>
	<body>
	<input id="uploadFileName" type="hidden" value="${uploadFileName}" />
	</body>
</html>

