$(document).ready(function() {
	
	$("a[licenseKey]").each(function(){
		var key = $(this).attr("licenseKey");
		var value = licenseJson[key];
		if(value == "false"){
			$(this).css("display","none");
		}
	});
	
	var $find_right = $('#find-right');
	$find_right.find('li').bind('click', function() {
		var $li = $(this);
		var cateGroupId = $li.attr('id');
		var $parent = $li.parent();

		/* AJAX方式取资源的列表 */
		$.ajax( {
			type : "post",
			url : "category-list-getresources.action",
			data : "cateGroupId=" + cateGroupId,
			success : function(data, textStatus) {
				
				var $div = $parent.next("div");
				
				/* 删除绑定的div */
				if (!$div[0]) {
					$div = $("<div></div>");
					$parent.after($div);
				} else {
					$div.find("*").unbind();
					$div.html("");
				}

				/* 绑定资源列表的DIV */
				var resources = data.discResources;
				var resourcesLicense = $.parseJSON(data.licenseResourceJson);
				if (resources != null && resources.length > 0) {
					var $divResource = $('<div id="div_resource_list" class="find-right-result"></div>');
					var $ul = $('<ul></ul>');
					if (cateGroupId == "networkdevice") {
						var $li = $('<li id="networkdevice" suffix="">网络设备通用发现</li>');
						$ul.append($li);
						$li.bind('click', function() {
							$("#resourceIdStr").val(common_device_resourceId);
							$("#suffix").val("");
							$("#isNetDevDiscoveryWay").val("true");
							$("#formname").submit();
						});
					}
					for ( var i = 0; i < resources.length; i++) {
						var resourceId = resources[i].id;
						var resourceName = resources[i].name;
						var suffix = resources[i].suffix;
						var $li = $('<li class="elli-name" id="' + resourceId + '" suffix="' + suffix + '" title=" ' + resourceName + ' ">' + resourceName + '</li>');
						
						//校验license
						var resId = resourceId.split("!");
						var isValidate = false;
						var isDisplay = "false";
						for(var j=0;j<resId.length;j++){
							if(resourcesLicense[resId[j].toUpperCase()] != null){
								isDisplay = resourcesLicense[resId[j].toUpperCase()];
								isValidate = true;
								break;
							}
						}
						if(isValidate){
							if(isDisplay == "true"){
								$ul.append($li);
							}
						}else{
							$ul.append($li);
						}
						// $ul.append('<li id="' + resourceId + '">' + resourceName + '</li>');
						/*alert("resourceId=" + resourceId + ",resourceName=" + resourceName);*/
						/* 为资源列表绑定链接的事件 */
						$li.bind('click', function() {
							$("#resourceIdStr").val($(this).attr('id'));
							if ($(this).attr('suffix') != null && $(this).attr('suffix') != 'null') {
								$("#suffix").val($(this).attr('suffix'));
							}else{
								$("#suffix").val("");
							}
							$("#formname").submit();
//							var url = "resource-discovery.action?resourceIdStr=" + $(this).attr('id');
//							if ($(this).attr('suffix') != null && $(this).attr('suffix') != 'null') {
//								 url = url + "&suffix=" + encodeURIComponent($(this).attr('suffix'));
//							}
//							location.href = url;
							// $.loadPage("find-right", "resource-discovery.action", "post", "resourceId=" + $(this).attr('id'));
						});
					}
					$divResource.append($ul);
					$div.append($divResource);
				}
				
				parent.resizeFrameHeight();
			},
			beforeSend : function(XMLHttpRequest) {
				/*alert('beforeSend');*/
			},
			complete : function(XMLHttpRequest, textStatus) {
				/*alert('complete');*/
			},
			error : function() {
				alert("error");
			}
		});

	});

});
