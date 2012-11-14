<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
</head>

<body>
<form name="form1" method="post" action="">
  <table width="75%" border="1">
    <tr background="Drag to a file to choose it."> 
      <td colspan="2">属性</td>
    </tr>
    <tr> 
      <td>名称：</td>
      <td><input type="text" name="name" value="<s:property value="bizService.name"/>">
      
        * </td>
    </tr>
    <tr> 
      <td>影响因子：</td>
      <td><input type="text" name="textfield2"> <input type="text" name="reflectFactor"></td>
    </tr>
    <tr> 
      <td>备注：</td>
      <td><textarea name="remark" cols="30" rows="4"></textarea></td>
    </tr>
    <tr background="Drag to a file to choose it."> 
      <td>自定义属性</td>
      <td><div align="right"><a href="#">+</a> <a href="#">×</a></div></td>
    </tr>
    <tr> 
      <td colspan="2"><table width="75%" border="1">
          <tr background="#399966"> 
            <td width="5%"><input type="checkbox" name="checkbox" value="checkbox"></td>
            <td width="50%">属性名称</td>
            <td width="45%">属性值</td>
          </tr>
          <tr> 
            <td><input type="checkbox" name="checkbox2" value="checkbox"></td>
            <td><input type="text" name="textfield4">
              :</td>
            <td><input type="text" name="textfield5"></td>
          </tr>
        </table></td>
    </tr>
    <tr> 
      <td colspan="2">负责人信息</td>
    </tr>
    <tr> 
      <td>服务责任人：</td>
      <td><input type="text" name="textfield6"> <a href="#">搜索</a>*</td>
    </tr>
    <tr> 
      <td>联系电话：</td>
      <td><input type="text" name="textfield7"></td>
    </tr>
    <tr> 
      <td>电子邮件：</td>
      <td><input type="text" name="textfield8"></td>
    </tr>
    <tr> 
      <td colspan="2"><div align="right"><a href="#">应用</a></div></td>
    </tr>
  </table>
</form>
</body>
</html>

