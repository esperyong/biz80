var isChange = false;// 是否变更导航
$(document).ready(function() {

	/*
	 * license校验
	 */
	$("a[licenseKey]").each(function(){
		var key = $(this).attr("licenseKey");
		var value = licenseJson[key];
		if(value == "false"){
			var $parent = $(this).parent();
			$parent.css("display","none");
		}
	});
	
	var $preSelected = $("#a_navigate_resource"); // 资源发现
	var $handSingleAdd = $("#a_navigate_single_add"); // 手工添加-单个添加
	var $handBatchAdd = $("#a_navigate_batch_add"); // 手工添加-批量添加

	var preSelectedClass = $preSelected.attr("class");
	$preSelected.attr("class", preSelectedClass + "-on");

	var iframe_right = document.getElementById("iframe_right");

	var $ul_auto = $("#ul_auto");
	var $ul_manual = $("#ul_manual");
	var $ul_config = $("#ul_config");

	$("#h2_auto").bind("click", function() {
		confirmBox(h2_auto);
	});
	function h2_auto(){
		$ul_auto.show();
		$ul_manual.hide();
		$ul_config.hide();
		// $("#div_auto").after($("#div_manual"));
		// $("#div_auto").after($("#div_config"));
		$("#a_navigate_resource").click();
	}
	

	$("#h2_manual").bind("click", function() {
		confirmBox(h2_manual);
	});
	function h2_manual(){
		$ul_manual.show();
		$ul_auto.hide();
		$ul_config.hide();
		// $("#div_manual").after($("#div_auto"));
		// $("#div_manual").after($("#div_config"));
		$handSingleAdd.click();
	}

	$("#h2_config").bind("click", function() {
		confirmBox(h2_config);
	});
	function h2_config(){
		$ul_config.show();
		$ul_auto.hide();
		$ul_manual.hide();
		// $("#div_config").after($("#div_auto"));
		// $("#div_config").after($("#div_manual"));
		var ul = $("#h2_config").parent().children()[1];		
		var lis = $(ul).children();
		for(var i=0;i<lis.length;i++){
			if($(lis[i]).css("display") != "none"){
				var as = $(lis[i]).children();
				$(as)[0].click();
				break;
			}
		}
	}

	/**
	 * 导航页面资源按钮
	 */
	$("#a_navigate_resource").bind("click", function() {
		confirmBox(a_navigate_resource);
	});
	function a_navigate_resource(){
		// $.loadPage("find-right", "category-list.action", "post");
		iframe_right.src = "category-list.action";
		selectedModule($(this));
	}

	/**
	 * Excel发现
	 */
	$("#a_navigate_excel").bind("click", function() {
		confirmBox(a_navigate_excel);
	});
	function a_navigate_excel(){
		// $.loadPage("find-right", "", "post");
		selectedModule($(this));
		selectedModule($(this));
	}

	/**
	 * 发现配置
	 */
	$("#a_navigate_allocation").bind("click", function() {
		confirmBox(a_navigate_allocation);
	});
	function a_navigate_allocation(){
		var url = "/netfocus/netfocus.do?action=discoveryservice@getconfig&forward=/modules/discovery/discoveryconf.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 全网发现
	 */
	$("#a_navigate_all").bind("click", function() {
		confirmBox(a_navigate_all);
	});
	function a_navigate_all(){
		// var url =
		// "/netfocus/netfocus.do?action=discoveryservice@getcoreip&forward=/modules/discovery/coredevicediscovery.jsp";
		// iframe_right.src = url;
		var url = "/netfocus/netfocus.do?action=discoveryservice@getcoreip&forward=/modules/flash/discoverygraph.jsp";
		window
				.open(
						url,
						'discoverygraph',
						'fullscreen=yes,toolbar=no,scrollbars=no,resizable=no,location=no,status=no,menubar=no,top=0,left=0,');
		//selectedModule($(this));
	}

	/**
	 * 扩展发现
	 */
	$("#a_navigate_extend").bind("click", function() {
		confirmBox(a_navigate_extend);
	});
	function a_navigate_extend(){
		var url = "/netfocus/modules/discovery/extendednetworkdiscovery.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 子网发现
	 */
	$("#a_navigate_subnet").bind("click", function() {
		confirmBox(a_navigate_subnet);
	});
	function a_navigate_subnet(){
		var url = "/netfocus/modules/discovery/subnetdiscovery.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 网段发现
	 */
	$("#a_navigate_segment").bind("click", function() {
		confirmBox(a_navigate_segment);
	});
	function a_navigate_segment(){
		var url = "/netfocus/modules/discovery/netsegmentsdiscovery.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 网段发现
	 */
	$("#a_navigate_initialise").bind("click", function() {
		confirmBox(a_navigate_initialise);
	});
	function a_navigate_initialise(){
		var url = "preuser-list.action";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 发现报告
	 */
	$("#a_navigate_report").bind("click", function() {
		confirmBox(a_navigate_report);
	});
	function a_navigate_report(){
		var url = "/netfocus/netfocus.do?action=discoveryservice@reportlist&forward=/modules/discovery/topodiscoveryreport.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 自动增量发现链接
	 */
	$("#a_navigate_autoadd").bind("click", function() {
		confirmBox(a_navigate_autoadd);
	});
	function a_navigate_autoadd(){
		var url = "/netfocus/netfocus.do?action=discoveryservice@getautoincrease&forward=/modules/discovery/autoincreasediscovery.jsp";
		iframe_right.src = url;
		selectedModule($(this));
	}

	/**
	 * 手工添加-单个添加.
	 */
	$handSingleAdd.bind("click", function() {
		confirmBox(a_navigate_single_add);
	});
	function a_navigate_single_add(){
		iframe_right.src = "singletonAdd!singletonAdd.action";
		selectedModule($(this));
	}

	/**
	 * 手工添加-批量添加.
	 */
	$handBatchAdd.bind("click", function() {
		confirmBox(a_navigate_batch_add);	
	});
	function a_navigate_batch_add(){
		iframe_right.src = "batchAdd!openBatchAdd.action";
		selectedModule($(this));
	}

	$("#closeId").bind("click", function() {
		window.close();
	});

	function selectedModule($selected) {
		// $moduleSelected.attr("class", moduleSelectedClass + "-on");
		$preSelected.attr("class", preSelectedClass);

		var selectedClass = $selected.attr("class");
		$selected.attr("class", selectedClass + "-on");

		preSelectedClass = selectedClass;
		$preSelected = $selected;
	}

	function confirmBox(fun) {
		if (isChange) {
			var confirmConfig = {
				width : 480,
				height : 130
			};
			var confirmObj = new confirm_box(confirmConfig);
			confirmObj.setContentText("此操作可能造成发现失败，是否继续执行？"); // 也可以在使用的时候传入
			confirmObj.setConfirm_listener(function() {
				confirmObj.hide();
				fun();
			});
			confirmObj.show();
		}else{
			fun();
		}
	}
});
function setChange() {
	isChange = true;
}

function setNotChange() {
	isChange = false;
}
function refreshMonitorPage() {
	try {
		var discFrame = window.frames["iframe_right"].frames["iframe_discovery"];
		var instanceId = discFrame.$("#instanceId").val();
		if (instanceId != null) {
			try{
				if(opener){
					opener.refreshPage(instanceId.split(","),"discovery");
				}
			}catch(e){}
		}
	} catch (e) {

	}
}
