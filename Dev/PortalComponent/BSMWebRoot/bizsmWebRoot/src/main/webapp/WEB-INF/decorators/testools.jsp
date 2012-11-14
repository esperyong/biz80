<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="css/portal.css" rel="stylesheet" type="text/css" />
<link href="css/footer.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript">
$(function(){
	Footools.init({listeners:{click:function(id){
										alert(id);
									}
							}
				  });

    $("#btn").click(function(){
			Footools.expend();
        });
  });
</script>
</head>
<body>
<input type="button" value="saddf" id="btn">
<p>sadkfaskdfasdflasdf;lasdf;lk</p>
<p>sadkfaskdfasdflasdf;lasdf;lk</p>
<p>sadkfaskdfasdflasdf;lasdf;lk</p>
<p>sadkfaskdfasdflasdf;lasdf;lk</p>
    <page:applyDecorator name="tools">  
       <page:param name="width">150px</page:param>
       <page:param name="available">false</page:param>
       <page:param name="isExpend">true</page:param>
       <page:param name="btns">[[{id:"textarea",oncls:"textarea-on",offcls:"textarea",disablecls:"textarea-off",available:"off",title:"全屏"},{id:"mview",offcls:"resume",disablecls:"resume-off",available:"false",title:"缩略图"}]]</page:param>
     </page:applyDecorator>
</body>
</html>