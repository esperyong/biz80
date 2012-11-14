<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
<title>Insert title here</title>
<script>
function OK(){
//	var x = "";
//	var obj = document.getElementById("selDomain");
//	for(var i = 0; i < obj.options.length; i++) {
//		x = x+obj.options[i].value +",";
//	}
	//document.getElementById("domain").value=x;
	document.newForm.submit();
}
</script>
</head>
<body>
<form name="newForm" action="<%= request.getContextPath()%>/bizServiceAction!add" method="POST">
<table width="300" cellspacing="0" cellpadding="0">
	<tr>
		<td><img src="../../images/table-04-01.jpg" width="5" height="27" /></td>
		<td width="100%" background="../../images/table-04-02.jpg">
		<table width="98%" align="center" cellpadding="0" cellspacing="0">
			<tr>
				<td class="txt-white"><strong>新建服务</strong></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">&nbsp;</td>
		<td bgcolor="#FFFFFF">
		<table width="94%" align="center" cellpadding="2" cellspacing="0">
			<tr>
				<td width="27%" height="30" valign="middle"
					class="border-bottom-grey01">服务名称：</td>
				<td width="73%" height="30" class="border-bottom-grey01">
				<input name="bizService.name" type="text" class="input01" value="广告制作" size="30" />
				<span class="txt-red">*</span></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="border-bottom-grey01">所属域：</td>
				<td height="30" class="border-bottom-grey01">
					<select name="bizService.belongDomainIds" multiple="multiple" size="4" id="selDomain"> 
						<option value="bj">北京</option>
						<option value="sh">上海</option>
						<option value="tj">天津</option>
	  				</select>
  				</td>
			</tr>
		</table>
		<table width="94%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="80%" height="30" valign="bottom">
				<table width="45" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td width="100%" align="center"
							background="../../images/btn/btn-02.jpg"><a
							onClick="OK()" class="txt-white">确定</a></td>
					</tr>
				</table>
				</td>
				<td width="20%" valign="bottom">
				<table width="45" align="right" cellpadding="0" cellspacing="0">
					<tr>
						<td width="100%" align="center"
							background="../../images/btn/btn-02.jpg"><a
							href="../discovery/network.htm" target="_blank" class="txt-white">取消</a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<table width="98%" border="0">
			<tr>
				<td></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><img src="../../images/table-04-04.jpg" width="5" height="4" /></td>
		<td bgcolor="#FFFFFF"></td>
		<td><img src="../../images/table-04-05.jpg" width="6" height="4" /></td>
	</tr>
</table>
</form>

</body>
</html>