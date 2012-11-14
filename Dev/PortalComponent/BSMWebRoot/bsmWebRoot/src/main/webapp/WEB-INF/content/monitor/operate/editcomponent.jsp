<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<form id="editComponentForm"><input type="hidden" name="childId" id="childId" value="<s:property value="instanceId"/>"/>
<ul class="fieldlist-n">
<li><span class="txt-white field-middle bold">组件名称</span><span class="txt-white">：</span><input id="editname" class="validate[required[组件名称],length[0,30,组件名称],noSpecialStr[组件名称],ajax[editname]]" name="editname" type="input" value="<s:property value="instanceName" />" /><span style="color:red;">*</span></li>
<li><span class="txt-white field-middle"></span><span class="suojin1em txt-white">请勿输入：' " % \ : ? &lt; &gt; | ; &amp; @ # *</span></li>
<li><span class="txt-white field-middle bold">备注</span><span class="txt-white">：</span><textarea id="editdesc" name="editdesc" col="30" row="5"><s:property value="description" /></textarea></li>
<li><span class="txt-white field-middle bold">影响因子</span><span class="txt-white">：</span><span class="for-line" id="editNumberSliderSpan" style="height:20px;width:130px"></span><input id="editimpactFactor" name="editimpactFactor" class="validate[funcCall[editimpactFactor]]" type="input" size="3" value="<s:property value="impactFactor" />" /></li>
</ul>
</form>
<script type="text/javascript">
function childImpactFactorCheck(tag){
    var re=/^(?:0|[1-9][0-9]?|100)$/;
    return !re.test($("#editimpactFactor").val());
 }
	$(function(){
		$.validationEngineLanguage.allRules.editname = {
				  "file":"${ctx}/monitor/maintainSetting!validateInstanceName.action?instanceId="+$("#childId").val()+"&instanceName="+$("#editname").val(),
				  "alertTextLoad":"正在验证，请稍后",
				  "alertText":"<font color='red'>*</font>@@已存在。"
		}
		$("#editComponentForm").validationEngine({promptPosition:"topRight"});
		settings = {
			promptPosition:"topRight",
			validationEventTriggers:"keyup blur change",
			inlineValidation: true,
			scroll:false,
			success:false,
			failure : function() {}
		}
		$.validate = function(form){
	 	$.validationEngine.onSubmitValid = true;
	   	if($.validationEngine.submitValidation(form,settings) == false){
	        if($.validationEngine.submitForm(form,settings) == true){
	        	return false;
	        }else{
	        	return true;
	        }
	   }else{
	       settings.failure && settings.failure();
	       return false;
	   }
		};
		$.validationEngineLanguage.allRules.editimpactFactor = {
	       "nname":"childImpactFactorCheck",
	       "alertText":"<font color='red'>*</font>请输出0-100之间的整数"
	    }
	   
		  var editNumberSlider = new NumberSlider({wrapId:'editNumberSliderSpan', sliderId:'editNumberSlider', minValue:0, maxValue:100, bindId:'editimpactFactor', defaultValue:"<s:property value="impactFactor" />", sliderWidth:110,style:"gray"});
	});
</script>