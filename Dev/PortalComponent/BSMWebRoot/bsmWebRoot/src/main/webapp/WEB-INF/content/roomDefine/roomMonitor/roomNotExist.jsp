<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp"%>

<head>
<%@ page import="com.opensymphony.xwork2.util.*"%>
<link rel="stylesheet" href="${ctx}/css/UIComponent.css" type="text/css" />
<title>机房不存在</title>
</head>
<body >
<!--透明层按钮 -->
<div style="height:100%;width:100%;background-color:#000000">
   <table style="height:100%;width:100%;">
	      <tbody>
	        <tr style="height:100%">
	         <td style="height:100%" class="nodata vertical-middle" style="text-align:center;">
	           <span class="nodata-l" style="position:relative;top:32%">
	              <span class="nodata-r">
	                <span class="nodata-m"> <span class="icon">当前机房不存在</span> </span>
	              </span>
	            </span>
            </td>
          </tr>
	      </tbody>
	    </table>
</div>
</body>
