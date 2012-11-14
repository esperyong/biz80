<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/loading.jsp" %> 
<script type="text/javascript">

toast = new Toast({position:"CT"});

function setEditEnabled(configWay){

	if(configWay==2){
		document.getElementById("maxNumber").disabled = false;
		document.getElementById("timeWay").disabled = false;
	}else{
		document.getElementById("maxNumber").disabled = true;
		document.getElementById("timeWay").disabled = true;
	}
}


	$("#configstatussubmit").click(function (){
		if(checkForm())
		{
				$.blockUI({message:$('#loading')}); 
			BSM.Monitorsetting.initValidationEngine("configstatusformname");
			$.ajax({
					type: "POST",
					dataType:"html",
					data:$("#configstatusformname").serialize(),
					url:ctx+"/monitorsetting/configstatus/update.action",
					success: function(data){
							$.unblockUI();
					}
			});
		}
	});
	
	
	function checkForm()
	{
		var configWay;
			for(var i=0;i<document.getElementsByName('recoverWay').length;i++){
				if(document.getElementsByName('recoverWay')[i].checked){
				configWay=document.getElementsByName('recoverWay')[i].value;
			}
		}
		if(configWay==2){
			
			var maxNumber = document.getElementById("maxNumber").value;
			var timeWay = document.getElementById("timeWay").value;
			if(maxNumber==""){
				toast.addMessage('自动确认资源的时间设置不能为空。');
				//alert("自动确认资源不能为空");
				return false;
			}
			if(!checkNum(maxNumber)){
				//alert("自动确认资源只能为数字");
				toast.addMessage('自动确认资源的时间设置只能为数字。');
				return false;
			}
			if(timeWay==1){//天
				if(!checkMidValue(maxNumber,7,1)){
					//alert("不能超过7天");
					toast.addMessage('不能超过7天。');
			   		return false;
				}
			}else{//小时
				if(!checkMidValue(maxNumber,24,0)){
					//alert("不能超过24小时");
					toast.addMessage('不能超过24小时。');
			   		return false;
				}
			}
			
		}
		return true;
	}
	
function checkMidValue(field,MaxValue,MinValue){
	if (parseFloat(field) > parseFloat(MaxValue) || parseFloat(field) < parseFloat(MinValue)){
		return false;
	}
	return true;
}

	// 只能在指定域内输入数字
	function checkNum(Field) {
		if (Field != "") {
			for (i = 0; i < Field.length; i++) {
				ch = Field.charAt(i);
				if ((ch < '0' || ch > '9')&&ch!='.'/* && ch != '-' */) {
					return false;
				}
			}
		}
		return true;
	}

</script>
<form name="configstatusformname" id="configstatusformname" method="post">
  <div>
    <div class="manage-content">
      <div class="top-l">
        <div class="top-r">
          <div class="top-m"> </div>
        </div>
      </div>
      <div class="mid">
        <div class="h1"> <span class="bold">当前位置：</span> <span>监控配置 / 监控设置 / 配置状态设置</span></div>
        <div class="margin5">
          <ul class="fieldlist-n">
          	<s:if test="configStatusPojo.recoverWay==1">
	          	<li style="padding-bottom:8px;">
	            <input type="radio" name="recoverWay" id="recoverWay" value="1" checked onclick="setEditEnabled('1')"/>
	            <span class="margin5">手动确认资源的配置变更状态</span>
	        	</li>
	        	<li style="padding-bottom:8px;" class="border-bottom">
		          <input type="radio" name="recoverWay" id="recoverWay" value="2" onclick="setEditEnabled('2')"/>
		          <span class="margin5">超过
		          <input name="maxNumber" type="text" id="maxNumber" size="10" value="${configStatusPojo.maxNumber }" disabled="disabled"/>
		          <select name="timeWay" id="timeWay" disabled="disabled">
		          	<s:if test="configStatusPojo.timeWay==1">
			            <option value="2">小时</option>
			            <option selected="selected" value="1">天</option>
		            </s:if>
		            <s:else>
		            	<option value="2" selected="selected">小时</option>
			            <option value="1">天</option>
		            </s:else>
		          </select>
		          自动确认资源的配置变更状态</span>
		        </li>
	       	</s:if>
	        <s:else>
	        	<li style="padding-bottom:8px;">
	            <input type="radio" name="recoverWay" id="recoverWay" value="1" onclick="setEditEnabled('1')"/>
	            <span class="margin5">手动确认资源的配置变更状态</span>
	        	</li>
	        	<li style="padding-bottom:8px;" class="border-bottom">
		          <input type="radio" name="recoverWay" id="recoverWay" value="2" checked onclick="setEditEnabled('2')"/>
		          <span class="margin5">超过
		          <input name="maxNumber" type="text" id="maxNumber" size="10" value="${configStatusPojo.maxNumber }" />
		          <select name="timeWay" id="timeWay">
		          	<s:if test="configStatusPojo.timeWay==1">
			            <option value="2">小时</option>
			            <option selected="selected" value="1">天</option>
		            </s:if>
		            <s:else>
		            	<option value="2" selected="selected">小时</option>
			            <option value="1">天</option>
		            </s:else>
		          </select>
		          自动确认资源的配置变更状态</span>
		        </li>
	        </s:else>
	        <li><span class="black-btn-l  multi-line right"> <span class="btn-r"> <span class="btn-m"><a id="configstatussubmit" >应用</a></span></span></span></li>
	        <li style="height:200px;"></li>
            </ul>
        </div>
      </div>
      <div class="bottom-l">
        <div class="bottom-r">
          <div class="bottom-m"> </div>
        </div>
      </div>
    </div>
</form>