$(document).ready(function() {
	
	load("div_syscomp_right", ctx+"/systemcomponent/agent-main.action");
	
	$("#a_agent").bind("click", function() {
		load("div_syscomp_right", ctx+"/systemcomponent/agent-main.action");
	});

	$("#a_server").bind("click", function() {
		load("div_syscomp_right", ctx+"/systemcomponent/server-main.action");
	});
	$("#leftdmsdomain").bind("click", function() {
		load("div_syscomp_right", ctx+"/systemcomponent/server/domain-dms-index.action",function(){
			initDomainDMSIndex();
		});
	});
	
});

function load(id, url,callback) {
	$.loadPage(id, url, "POST", '', callback);
}
/**
 * 初始化域关联DMS界面dms列表
 */
function initDomainDMSList(){
	$("#addDMS").click(function(){
		if($("#unselect option:selected").length>0){
			$("#unselect option:selected").each(function(){
				$("#selected").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option");
				$(this).remove();　
			})
		}else{
			//alert("请选择要添加的分包！");
		}
	});
	$("#removeDMS").click(function(){
		if($("#selected option:selected").length>0){
			$("#selected option:selected").each(function(){
				$("#unselect").append("<option value='"+$(this).val()+"'>"+$(this).text()+"</option");
				$(this).remove();　
			});
		}else{
			//alert("请选择要删除的分包！");
		}
	});
	$("#domaindmsselectsubmit").click(function(){
		document.getElementById('domaindmsselectsubmit').disabled = true;
		var ops = [];
		$("#selected option").each(function(){
			ops.push("<input type='hidden' name='dmsId' value='" + this.value + "'/>");
		});
		$("#domaindmsformname").append(ops.join(""));
		$.ajax({
				type: "POST",
				dataType:'html',
				data:$("#domaindmsformname").serialize(),
				url:ctx+"/systemcomponent/server/domain-dms-save.action",
				success: function(data){
					load("domaindmsrightDiv",ctx+"/systemcomponent/server/domain-dms-list.action?domainId="+$.parseJSON(data).domainId,function(){
						initDomainDMSList();
					});
				}
		});
	});
}

/**
 * 初始化域关联DMS首页
 */
function initDomainDMSIndex(){
	initDomainDMSList();
	$("span[name='domainListName']").click(function(){
		
		
		document.getElementById(document.getElementById("old_style").value).className = '';
		document.getElementById(this.id+'_style').className = 'bold';
		document.getElementById("old_style").value = this.id+'_style';
		
		load("domaindmsrightDiv",ctx+"/systemcomponent/server/domain-dms-list.action?domainId="+this.id,function(){
			initDomainDMSList();
		});
	});
}