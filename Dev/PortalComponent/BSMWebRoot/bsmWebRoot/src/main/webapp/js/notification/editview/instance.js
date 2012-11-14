var resCat = $('#_resCategorys').clone();
resCat.attr("name","query.queryCategory");
if(query && query.category){
	resCat.val(query.category);
}
$('#selectResCat').append(resCat.show());
$(function(){
	createSelect($("#unselect_ins").find("tbody"));
	createSelect($("#selected_ins").find("tbody"));
	$("#query_userId").val(query.userId);
	$("#query_domainIds").val(query.domainIds);
	$('#filterIns').click(function(){
		var data = $("#notificationInstanceFilterForm").serialize();
		data+="&query.viewId="+$("#viewId").val();
		data+="&query.isSystemAdmin="+isSystemAdmin;
		var insids = $("#selected_ins").find("tr[insid]");
		var insLength = insids.length;
		for(var i = 0 ; i < insLength  ;i++){
			var tr = $(insids[i]);
			data += "&rightIns["+i+"].id=" + tr.attr("insid");
			data += "&rightIns["+i+"].moduleId=" + tr.attr("moduleId");
		}
		$("#INSTANCEID").unbind();
		$("#INSTANCEID").load(path + "/notification/reloadNotificationInstance.action"
				,data,function(){
		});
	});
	$('#select_left_all').change(function(){
		checkAll(this,$('#unselect_ins').find(':checkbox'));
	});
	$('#select_right_all').change(function(){
		$('#selected_ins').find(':checkbox').attr('checked',$(this).attr('checked'));
	});
	
	$('#instance-turn-right').click(function(){
		moveCheckbox($('#unselect_ins'),$('#selected_ins'));
	});
	
	$('#instance-turn-left').click(function(){
		moveCheckbox($('#selected_ins'),$('#unselect_ins'));
	});
	
	function checkAll(obj, check){
		//var check = document.getElementsByName(id);
		for (i = 0; i < check.length; i++)	{
			check[i].checked = obj.checked;
		}
	}  
	
	
	function moveCheckbox($left,$right){
		var trs = $left.find('tr');
		trs.each(function(i,e){
			var $tr = $(e);
			if($tr.find(':checkbox').attr('checked')){
				$right.find('tbody').append($tr);
				$tr.find(':checkbox').attr('checked',false);
			}
		})
		
		testCheckAll($left);
		testCheckAll($right);
	}
	
	function testCheckAll($left){
		var flag = true;
		var trs = $left.find('tbody').find('tr');
		if(trs.length == 0){
			flag = false;
		}
		if(flag){
			trs.each(function(i,e){
				var $tr = $(e);
				if(!$tr.find(':checkbox').attr('checked')){
					flag = false;
					return;
				}
			});
		}
		$($left.prev().find('thead').find(':checkbox')[0]).attr('checked',flag);
	}
});
function createSelect(tbody){
	var $tbody = $(tbody);
	$tbody.find("tr[insid]").each(function(i,e){
		var $td = $($(e).children()[1]);
		var str = $td.text().split(",");
		if(str && str.length && str.length > 1){
			var trInstId = $($tbody.find("tr[insid]")[0]);
			var instIdValue = trInstId.attr("insid");
			
			var $select = $("<select id=\""+instIdValue+"\" iconIndex=\"0\" iconClass=\"combox_ico_select f-absolute\" iconTitle=\"管理IP\" style=\"width: 120px;\"></select>");
			for(var i =0;i<str.length;i++){
				$select.append("<option>"+str[i]+"</option>");
			}
			$td.empty().html($select);
		}
	})
}


var pageObj = document.getElementById("contentDIV");
var pHeight = pageObj.offsetHeight;
parent.setBodyHeight(pHeight);