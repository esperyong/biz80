	var lineNum = 0
	,	$checkAll = $('#checkall')
	,	$custom_type = $('#custom_type')
	,	$object_relation = $('#object_relation')
	,	$ip_relation = $('#ip_relation')
	,	$custom_lines = $('#custom_lines')
	
	,	custom_type = {INSTANCEID:'INSTANCEID',OBJECT_TYPE:'OBJECT_TYPE',IPADDRESS:'IPADDRESS'}
//	.INSTANCEID = 'INSTANCEID' 	//自定义对象类型.资源实例
//	,	custom_type.OBJECT_TYPE = 'OBJECT_TYPE'	//自定义对象类型.资源类型
//	,	custom_type.IPADDRESS = 'IPADDRESS'		//自定义对象类型.ip地址
	,	defaultInput = "多个关键字之间用“;”分隔，关系为“或”"
	,	$blank_input = 	$('<input size=50/>').addClass('input-single').val(defaultInput)
	,	bindInput = function($blank_input){$blank_input.bind('click',function(){
			if($(this).val()==defaultInput){
				$(this).val('');
			}
		}).bind('blur',function(){if($(this).val()==''){
			$(this).val(defaultInput);
		}})}
	;
	
$(function(){
	$('#add_line').click(function(){addLine();});
	$('#del_line').click(function(){delLine();});
	$('#chooseObjType').click(function(){
        $("#operateForm").attr('action', path + "/notification/chooseObjectType.action");
        $("#operateForm").submit();

		//alert(userId+"##"+domainId);
		
	});
	$('[name=chooseViewObjType]').change(function(){
		changeObjType(this);
	})
	$checkAll.click(function(){checkAll(this);});
	
});
openSpecfiyWindow = function(windowName) {
	 //winOpen({url: 'about:blank',width: 500,height: 100,name: 'windowName'});
	  var left =  window.screen.width/2 - 500/2;
	  var top = window.screen.height/2 -100/2;
	 window.open('about:blank',windowName, 'width=500,height=500,menubar=no,scrollbars=no,left='+left+',top='+top);
}

function delLine(){
	var trs = $custom_lines.children();
	var unchecked = false;
	trs.each(function(i,e){
		var tr = $(e);
		var isChecked = $(tr.find(':checkbox')[0]).attr('checked');
		if(isChecked){
			unchecked = true;
			tr.remove();
		}
	});
	trs = $custom_lines.children();
	trs.each(function(i,e){
		if(i%2==1){
			$(e).addClass("black-grid-graybg");
		}else{
			$(e).removeClass("black-grid-graybg");
		}
	});
	if(unchecked){
		$checkAll.attr('checked',false);
	}
}
function addLine(){
	if(lineNum == 0){
		lineNum = $custom_lines.children().length - 1;
	}
	var td=$('<td/>');
	var ct = $custom_type.clone().attr({'id':'custom_type_'+lineNum,'name':'custom_type['+lineNum+']'}).click(function(){changeObjType(this)});
	var or = $object_relation.clone().attr({'id':'object_relation'+lineNum,'name':'object_relation['+lineNum+']'});
	var inp = $blank_input.clone().attr({'id':'object_relation'+lineNum,'name':'object_relation['+lineNum+']'});
	var $newTr = $('<tr></tr>').append('<td><input type="checkbox" onclick="unChecked(this)"></td>')
		.append(td.clone().append(ct))
		.append(td.clone().append(or).append(inp))
		.append(td.clone().append('并'))
		.attr("lineNum",lineNum)
	;
	var sumLine = $custom_lines.children().length;
	if(sumLine%2==1){
		$newTr.addClass("black-grid-graybg");
	}
	$custom_lines.append($newTr);
	var h = $custom_lines.height();
	//if(h>180){
	//	$custom_lines.parent().css({'overflow-y':'scroll','height':h});
	//}
	lineNum ++;
}

function checkAll(tag){
	var lines = $custom_lines.children().find(':checkbox:enabled');
	lines.attr('checked',$(tag).attr('checked'));
}

function unChecked(tag){
	var flag = $(tag).attr('checked');
	if(!flag){
		$checkAll.attr('checked',flag);
	}
}

fillObjTypes = function(nameArray,idArray){
	$('#obj_type_name').val(nameArray.join(";"));
	$('#obj_type_ids').val(idArray.join(";"));
	//alert($('#obj_type_ids').val())
}
function changeObjType(tag){
	var $self = $(tag);
	var $nextTd = $self.parent().next('td');
	var $nextSelect = $($nextTd.children()[0]);
	var lineNum = $self.parent().attr("lineNum");
	switch ($self.val()) {
	case custom_type.INSTANCEID:		//资源实例
		var $newSelect = $object_relation.clone().attr({id:$nextSelect.attr('id'),name:$nextSelect.attr('name')});
		$nextTd.empty().append($newSelect).append($blank_input.clone().attr({'id':'object_relation'+lineNum,'name':'object_relation['+lineNum+']'}));
		break;
	case custom_type.OBJECT_TYPE:		//资源类型
		break;
	case custom_type.IPADDRESS:			//ip地址
		var $newSelect = $ip_relation.clone().attr({id:$nextSelect.attr('id'),name:$nextSelect.attr('name')});
		$nextTd.empty().append($newSelect).append($blank_input.clone().attr({'id':'object_relation'+lineNum,'name':'object_relation['+lineNum+']'}));
		break;

	default:
		break;
	}
	
}