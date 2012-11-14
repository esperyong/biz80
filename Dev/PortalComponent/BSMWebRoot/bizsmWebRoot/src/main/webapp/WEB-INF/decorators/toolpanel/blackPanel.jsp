<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<decorator:usePage id="blackpanel" />

<div class="pop-black" id="<decorator:getProperty property="id"/>" style="display:none">
	<div class="pop-top-l">
		<div class="pop-top-r">
			<div class="pop-top-m">页面上部修饰</div>
		</div>
	</div>
	<div class="pop-middle-l">
		<div class="pop-middle-r">
			<div class="pop-middle-m">
				<div class="pop-content">
					    <decorator:getProperty property="content"/>
			    </div>  
			</div>
		</div>
	</div>
	<div class="pop-bottom-l">
		<div class="pop-bottom-r">
			<div class="pop-bottom-m">页面下部修饰</div>
		</div>
	</div>
</div>
