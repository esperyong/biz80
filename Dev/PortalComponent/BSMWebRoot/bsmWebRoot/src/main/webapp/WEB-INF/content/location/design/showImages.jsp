<!-- WEB-INF\content\location\design\showImages.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<s:iterator value="imageTypeList" id="type" status="typeList">
	<s:if test="typeImages.get(#type.key)!=null">
    <page:applyDecorator name="accordionAddSubPanel">  
		<page:param name="id">${type }a</page:param>
		<page:param name="title"><s:property value="%{getText(value)}"/></page:param>
		<page:param name="width">160px</page:param>
		<page:param name="cls">fold-blue</page:param>
		<page:param name="content">
		<div class="img-show" style="width:160px;">
		<ul name="customulsame">
			<s:iterator value="typeImages.get(#type.key)" id="image">
			<li  id="${id }">
			<img onClick="addMap(this)" id="${id }" name="${name }" type="${type }" childType="${childType }" src="${ctx}/location/design/designImage!getImage.action?designImage.id=${id}"  height="30" width="30"/>
			<span class="more">${name }</span>
			</li>
			</s:iterator>
		</ul>
		</div>
		</page:param>
       
    </page:applyDecorator>
 	</s:if>
</s:iterator>
<link href="${ctxCss}/public.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/UIComponent.css" rel="stylesheet" type="text/css">
<link href="${ctxCss}/master.css" rel="stylesheet" type="text/css">
<script src="${ctxJs}/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="${ctxJs}/component/cfncc.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionPanel.js" type="text/javascript"></script>
<script src="${ctxJs}/component/accordionPanel/accordionAddSubPanel.js" type="text/javascript"></script>
<script type="text/javascript">
	
	var currId="";

	function addMap(obj){
		
		if(currId != ""){
				$("li[id='"+currId+"']").removeClass("on");
			}
			
		if(currId != obj.id){
				$("li[id='"+obj.id+"']").addClass("on");
				currId = obj.id;
				parent.addFlashElement(obj);
			}else{
				$("li[id='"+currId+"']").removeClass("on");
				currId = "";
				parent.removeFlashElement();
				}
	}
	
	
	
$(document).ready(function() {
	
	
	
	//由于type中有一个logo类型和css中的id为logo样式重复所以将这个类型后面加个字母a
	<s:iterator value="imageTypeList" id="type" status="typeList">
		var ${type } = new AccordionPanel({id:"${type }a"},
								{DomStruFn:"addsub_accordionpanel_DomStruFn",
								DomCtrlFn:"addsub_accordionpanel_DomCtrlFn"
	               				});
	</s:iterator>
});
</script>