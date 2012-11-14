/**
 * 渲染已有的下拉列表组件
 */

var SimpleBox = function(){
	function initialization(conf,mvc){
	    mvc = mvc ? mvc :{};
	    $.extend(conf,mvc);
	    this.init(conf,{domStru :  mvc.simpleBox_DomStruFn ? mvc.simpleBox_DomStruFn  : "default_simpleBox_DomStruFn",
	                    domCtrl : mvc.simpleBox_DomCtrlFn ? mvc.simpleBox_DomCtrlFn : "defatul_simpleBox_DomCtrlFn",
	                    compFn : mvc.simpleBox_ComponetFn ? mvc.simpleBox_ComponetFn : "default_simpleBox_ComponetFn"
	                  });
	}

	CFNC.registDomStruFn("default_simpleBox_DomStruFn",default_simpleBox_DomStruFn);
	CFNC.registDomCtrlFn("defatul_simpleBox_DomCtrlFn",defatul_simpleBox_DomCtrlFn);
	CFNC.registComponetFn("default_simpleBox_ComponetFn",default_simpleBox_ComponetFn);

	return initialization;

}();

function default_simpleBox_DomStruFn(conf){
	var self = this;
	var t_comboboxId = conf.comboboxId;
	var t_width = conf.width;
	var t_validateClass = conf.validateClass;
	var t_readOnly = 'readonly="readonly"';
	self.isEdit = false;
	if(conf.isEdit){
		t_readOnly = '';
		self.isEdit = true;
	}
	var t_name = '';
	if(conf.name){
		t_name = 'name="'+conf.name+'"';
	}
	var disabled = self.disabled = conf.disabled;
	self.combobox_text = t_comboboxId + '_text';
	self.combobox_options = t_comboboxId + '_options';
	self.renderSelectId = conf.renderSelectId;
	self.$wrap = $('<div><span style="width:auto;display:block;position:absolute;"></span></div>');
	self.$combobox = $('<div id="' + t_comboboxId + '"></div>');
	self.$border = $('<div class="lf"></div><div class="rg"><a></a></div>');
	self.$textBody = $('<div class="ct f-relative"><input type="text" id="'+ self.combobox_text + '" ' + t_readOnly + ' ' + t_name + ' ' + (t_validateClass ? 'class="' + t_validateClass + '"':'') + '/></div>');
	var t_combobox_height = $('#' + self.renderSelectId + ' option').size() >= 10 ? 150 : '';
	self.$options = $('<div class="content" style="height:' + t_combobox_height + 'px"><ul id="'+ self.combobox_options +'"></ul></div>');
	self.$combobox.append(self.$border);
	self.$combobox.append(self.$textBody);
	self.$combobox.append(self.$options);
	self.$wrap.append(self.$combobox);
	self.contentId = conf.contentId;
	
	if(null != self.renderSelectId){
		var t_select = $('#'+self.renderSelectId);
		if(0 != t_select.attr('size') || t_select.attr('isRender') == '1'){
			return;
		}
		var t_selectedOption = $('#'+self.renderSelectId + ' option:selected');
		var t_allOptions = $('#'+self.renderSelectId + ' option');
		
		if(null != t_width && !isNaN(t_width) && 0!= t_width){
			//此处减去20为下拉框左右图片的宽度，13为图片的宽度
			self.$combobox.css('width', t_width + 13);
			self.$textBody.css("width", t_width - 20 + 13);
			if(t_width > 220){
				self.$options.css('width', 218 + 13);
			}else{
				self.$options.css('width', t_width - 2 +13);
			}
		}
		t_select.css('display', 'none');
		// 已经渲染的标志位
		t_select.attr('isRender', '1');
		if(null == conf.wrapId){
			self.$wrap.insertBefore('#'+self.renderSelectId);
		}else{
			$('#'+conf.wrapId).append(self.$wrap);
		}
		if(null != t_selectedOption){
			$('#'+self.combobox_text).val(t_selectedOption.text());
			$('#'+self.combobox_text).attr('key', t_selectedOption.val());
			$('#'+self.combobox_text).attr('title', t_selectedOption.text());
		}
		for(var i=0,len=t_allOptions.length; i<len; i++){
			var t_li = $('<li key="'+t_allOptions[i].value+'">'+t_allOptions[i].text+'</li>');
			if(conf.renderIcon && conf.renderIndex && conf.renderIndex==i){
				t_li = $('<li class="f-relative" key="'+t_allOptions[i].value+'">'+t_allOptions[i].text+'</li>');
				var $span = $('<span class="'+conf.renderIcon+'" style="top:0px;right:0px;"></span>');
				if(conf.renderTitle){
					$span.attr("title",conf.renderTitle);
				}
				t_li.append($span);
				if($(t_allOptions[i]).attr("selected")==true){
					$('#'+self.combobox_text).css("padding-right","16px");
					var $span = $('<span class="'+conf.renderIcon+'" title="' + conf.renderTitle +  '" style="top:2px;*top:3px;right:0px;"></span>');
					$('#'+self.combobox_text).parent().append($span);
				}
			}
			if(t_allOptions[i].value == t_selectedOption.val()){
				t_li.css('background-color', '#cfdef1');
			}else{
				t_li.css('background-color', '#ffffff');
			}
			t_li.attr('title', t_allOptions[i].text);
			$('#'+self.combobox_options).append(t_li);
		}
	}
}

function defatul_simpleBox_DomCtrlFn(conf){
	var self = this;
	//如果下拉列表为可写入的则绑定键盘按下事件
	if(self.isEdit){
		var t_comboboxText = $('#'+self.combobox_text);
		t_comboboxText.addClass(conf.validate);
		t_comboboxText.bind('keyup', {comboId:self.combobox_text}, function(event){
			var t_value = $(this).val();
			var t_allOptions = $('#'+self.renderSelectId + ' option');
			var $comboOption = $('#'+self.combobox_options);
			$comboOption.empty();
			var t_regex = t_value;
			for(var i=0,len=t_allOptions.length; i<len; i++){
				var t_optionValue = $(t_allOptions[i]).text();
				if(t_optionValue.substr(0,t_regex.length)==t_regex){
					var t_li = $('<li key='+t_allOptions[i].value+'>'+t_allOptions[i].text+'</li>');
					t_li.attr('title', t_allOptions[i].text);
					$comboOption.append(t_li);
				}
			}
			if($comboOption.children().length==0){
				$('#'+self.renderSelectId).val(null);
			}else{
				// 重新绑定option事件
				bindOptionEvent(conf.comboboxId, self.combobox_text, self.renderSelectId);
			}
			t_comboboxText.attr('title', t_comboboxText.val());
		})
	}
	// 监听绑定的下拉列表的值改变事件 - 用于联动处理
	var t_renderSelect = $('#'+self.renderSelectId);
	if(t_renderSelect.attr('isSynchro')){
		$('#'+self.renderSelectId).bind('change', function(ev){
			// 重新渲染下拉列表
			self.reload();
		});
	}
	self.disable = function(){
		$('#'+ conf.comboboxId).attr("class","disabled-combobox");
		$('#'+ conf.comboboxId + ' a').unbind();
		$('#'+ self.combobox_text).unbind();
		$('#'+ self.combobox_text).attr("disabled","true");
		self.hover();
	};
	
	self.enable = function(){
		$('#'+ conf.comboboxId).attr("class","combobox");
		$('#'+ conf.comboboxId + ' a').bind('click', {comboboxId:conf.comboboxId, comboboxTextId:self.combobox_text, contentId:self.contentId}, showOptions);
		$('#'+ self.combobox_text).bind('click', {comboboxId:conf.comboboxId, comboboxTextId:self.combobox_text, contentId:self.contentId}, showOptions);
		$('#'+ self.combobox_text).attr("disabled",'');
		self.hover();
	};
	self.hover = function(){
		$('#'+ self.combobox_text).bind('mouseover', function(){
			$('#'+ conf.comboboxId + ' a').addClass('mouseover');
		}).bind('mouseout', function(){
			$('#'+ conf.comboboxId + ' a').removeClass('mouseover');
		});
	};

	// 展开下拉列表
	if(!self.disabled){
//		$('#'+ conf.comboboxId + ' a').bind('click', {comboboxId:conf.comboboxId, comboboxTextId:self.combobox_text, contentId:self.contentId}, showOptions);
//		$('#'+ self.combobox_text).bind('click', {comboboxId:conf.comboboxId, comboboxTextId:self.combobox_text, contentId:self.contentId}, showOptions);
		self.enable();
	}else{
		self.disable();
	}
	
	// 当悬浮在文本框上高亮显示下拉列表的按钮
//	$('#'+ self.combobox_text).bind('mouseover', function(){
//		$('#'+ conf.comboboxId + ' a').addClass('mouseover');
//	}).bind('mouseout', function(){
//		$('#'+ conf.comboboxId + ' a').removeClass('mouseover');
//	});
//	self.hover();
	// option上的事件
	bindOptionEvent(conf.comboboxId, self.combobox_text, self.renderSelectId);
}

function default_simpleBox_ComponetFn(conf){
	var self = this;
	$('#'+self.combobox_text).css('border', 'none');
	$('#'+self.combobox_text).parent().css('overflow', '');
	// 设置选中项
	self.setSelect = function(optionValue){
		if(optionValue){
			var t_allOptions = $('#'+conf.comboboxId + ' .content ul li');
			var t_comboboxText = $('#'+self.combobox_text);

			for(var i=0,len=t_allOptions.length; i<len; i++){
				var t_option = t_allOptions[i];
				var t_optionKey = $(t_option).attr('key');
				if(t_optionKey == optionValue){
					if(null != t_optionKey && t_optionKey.length>0){
						$(t_option).css('background-color', '#cfdef1');
						t_comboboxText.attr('key', optionValue);
						t_comboboxText.val($(t_option).text());
					}
				}else{
					$(t_option).css('background-color', '#ffffff');
				}
			}
		}
	}
	// 清空渲染的下拉列表
	self.clearOptions = function(){
		var t_allOptions = $('#'+conf.comboboxId + ' .content ul');
		t_allOptions.empty();
		var t_comboboxText = $('#'+self.combobox_text);
		t_comboboxText.val('');
		t_comboboxText.attr('key', '');
	}
	// 重新加载下拉列表
	self.reload = function(){
		self.clearOptions();
		var t_selectedOption = $('#'+self.renderSelectId + ' option:selected');
		var t_allOptions = $('#'+self.renderSelectId + ' option');
		if(null != t_selectedOption){
			$('#'+self.combobox_text).val(t_selectedOption.text());
			$('#'+self.combobox_text).attr('key', t_selectedOption.val());
			$('#'+self.combobox_text).attr('title', t_selectedOption.text());
		}
		for(var i=0,len=t_allOptions.length; i<len; i++){
			var t_li = $('<li key='+t_allOptions[i].value+'>'+t_allOptions[i].text+'</li>');
			if(t_allOptions[i].value == t_selectedOption.val()){
				t_li.css('background-color', '#cfdef1');
			}else{
				t_li.css('background-color', '#ffffff');
			}
			t_li.attr('title', t_allOptions[i].text);
			$('#'+self.combobox_options).append(t_li);
		}
		bindOptionEvent(conf.comboboxId, self.combobox_text, self.renderSelectId);
	}
	if(conf.maxHeight){
		$('#'+ conf.comboboxId + ' .content').css('max-height', conf.maxHeight);
	}
}

function showOptions(event){
	setTimeout(function(){
	    $('.combobox .content').find("span").show();
		/*此处是为表格中使用 才作这样的处理*/
		var $currentCombobox = $('#'+ event.data.comboboxId);
		$currentCombobox.parent().css('position', 'relative');
		$currentCombobox.css('position', 'relative');
		$('#'+ event.data.comboboxId + ' .content').css('position', 'absolute');
		/*end*/
		$currentCombobox.parent().css('z-index', 5);
		$('#'+ event.data.comboboxId + ' a').addClass('clickdown');

		//判断是否有足够的空间展开下拉列表
		var t_contentId = event.data.contentId;
		var t_pageHeight = 0;
		var t_mouseY = 0;
		var currentBoxTop = $currentCombobox.offset().top; //当前combox的top坐标
		// 如果设置使用范围 则取使用范围的高度，否则取页面的高度
		if(t_contentId){
			t_pageHeight = $('#'+t_contentId).attr('offsetHeight');
			t_mouseY = currentBoxTop - ($('#'+t_contentId).attr('offsetTop'));
		}else{
			t_pageHeight = $('body').attr('offsetHeight');//内容可视区域的高度+滚动条+边框
			t_mouseY = currentBoxTop;
		}
		var t_optionsList = $('#'+ event.data.comboboxId + ' .content');
		var t_mh = $('#'+ event.data.comboboxId + ' .content').css('max-Height');
		var t_maxHeight = parseInt(t_optionsList.height());
		// 当向下展开下拉列表高度不够时
		if((t_pageHeight - t_mouseY) < t_maxHeight){
			// 如果下拉列表上方的高度足够展开下拉列表，则向上展开
			if(t_mouseY >= t_maxHeight){
				t_optionsList.css('top', -t_maxHeight);
			}else{
				// 一下条件需要调整下拉列表的最大高度
				var t_height = 0;
				// 通过判断是向上展开的空间更大还是向下展开的空间更大
				// 此处-23 是因为下拉列表高度为23 为了防止pageY获取的偏移量差异造成显示不开 所以选择-23
				if(t_pageHeight - t_mouseY > t_mouseY){
					// 调整最大高度
					t_height = t_pageHeight - t_mouseY - 23;
					if(!t_mh){
					   t_optionsList.css('max-height', t_height);
					}
				}else{
					// 向上展开 并调整最大高度
					t_height = (t_mouseY-23);
					if(!t_mh){
					   t_optionsList.css('max-height', t_height);
					}
					t_optionsList.css('top', -t_height);
				}
			}
		}
		$('#'+ event.data.comboboxId + ' .content').width($currentCombobox.find('div:eq(1)').width() + $currentCombobox.find('div:eq(2)').width());
		$('#'+ event.data.comboboxId + ' .content').show(1, function(){
			var t_allOptions = $('#'+ event.data.comboboxId + ' .content ul li');
			var t_comboboxText = $('#'+event.data.comboboxTextId);

			for(var i=0,len=t_allOptions.length; i<len; i++){
				var t_option = t_allOptions[i];
				var t_optionKey = $(t_option).attr('key');
				if(t_optionKey == t_comboboxText.attr('key')){
					if(null != t_optionKey && t_optionKey.length>0){
						$(t_option).css('background-color', '#cfdef1');
					}
				}else{
					$(t_option).css('background-color', '#ffffff');
				}
			}
			$(document.body).bind('click', {comboboxId:event.data.comboboxId}, hideOptions);
		});
	}, 1);

}

function hideOptions(event){
	$('.combobox a').removeClass('clickdown');
	var $combobox = $('.combobox');
	var $content = $('.combobox .content');
	$content.find("span").hide();
	$combobox.parent().css('z-index', 0);
	/*此处是为表格中使用 才作这样的处理*/
	$combobox.parent().css('position', 'relative');
	$combobox.css('position', 'relative');
	$content.css('position', 'absolute');
	
	/*end*/
	$content.hide(1, function(event){
		// 如果改变了打开下拉列表的方向，将其恢复为默认值
		$content.css('top', 20);
		$(document.body).unbind('click',hideOptions);
	});
}
/*
 * 绑定option的事件
 * */
function bindOptionEvent(comboboxId, comboboxTextId, renderSelectId){
	if(null != comboboxId){
		$('#'+ comboboxId +' .content ul li').bind('click', {comboId:comboboxTextId}, function(event){
			var $inputObj = $('#'+event.data.comboId);
			var count = $inputObj.parent().find("span").size();
			if(count>0){
				$inputObj.css("padding-right","0px");
				$inputObj.parent().find("span").remove();
			}
			$inputObj.val($(this).text());
			$inputObj.attr('key', $(this).attr('key'));
			$inputObj.attr('title' ,$(this).text());
			count = $(this).find("span").size();
			if(count>0){
				$inputObj.css("padding-right","16px");
				var iconClass = $(this).find("span").attr("class");
				var $span = $('<span class="'+iconClass+'" style="top:2px;*top:3px;right:0px;"></span>');
				$inputObj.parent().append($span);
			}
			$('#'+renderSelectId).val($(this).attr('key'));
			try{
				if(!$('#'+renderSelectId).attr('isSynchro')){
					$('#'+renderSelectId).change();
				}else{
					$('#'+renderSelectId).change();
					hideOptions(event);
				}
			}catch(e){}
		}).bind('mouseover', function(){
			$(this).css('background-color', '#cfdef1');
		}).bind('mouseout', function(){
			$(this).css('background-color', '#ffffff');
		});
	}
}

$.apply(SimpleBox,Componet);

// 下拉列表实例的容器
SimpleBox.instanceContent = {};

/*渲染页面所有下拉列表框
*
*	新增参数 bodyId - 下拉列表的使用范围ID，用于判断是否有足够的空间展开下拉列表。
*/
SimpleBox.renderAll = function(bodyId){
	var t_allSelect = $('select');
	for(var i=0,len=t_allSelect.length; i<len; i++){
		var t_select = t_allSelect[i];
		var t_selectId = t_select.id;
		if(null != t_selectId){
			var t_selectOffsetWidth = parseInt($('#'+t_selectId).attr('offsetWidth'));
			var t_selectWidth = parseInt($('#'+t_selectId).css('width'));
			var t_width = t_selectOffsetWidth >= t_selectWidth ? t_selectOffsetWidth : t_selectWidth;
			var validateClass = "";
			var t_renderIndex = $(t_select).attr("iconIndex");
			var t_renderIcon = $(t_select).attr("iconClass");
			var t_renderTitle = $(t_select).attr("iconTitle");
			if($(t_select).attr("validate")){
				validateClass="validate["+$(t_select).attr("validate")+"]";
			}
			var t_simpleBox = new SimpleBox({comboboxId:t_selectId+'_render'
				, renderSelectId:t_selectId
				, width:t_width
				, contentId:bodyId
				, validateClass:validateClass
				, disabled :$('#'+t_selectId).attr('disabled')
				, renderIndex:t_renderIndex
				, renderIcon:t_renderIcon
				, renderTitle:t_renderTitle
			});
			SimpleBox.instanceContent[t_selectId] = t_simpleBox;
		}
	}
}

//渲染指定的下拉列表框
SimpleBox.renderTo = function(selectIdArray){
	if(null != selectIdArray){
		for(var i=0,len=selectIdArray.length; i<len; i++){
			var t_select = selectIdArray[i];
			var t_selectId,t_renderIndex,t_renderIcon,t_renderTitle;
			if(t_select instanceof Object){
				t_selectId = t_select.id;
				t_renderIndex = t_select.iconIndex;
				t_renderIcon = t_select.iconClass;
				t_renderTitle = t_select.iconTitle;
			}else{
				t_selectId = t_select;
			}
			var validateClass = "";
			var $_select = $('#'+t_selectId);
			if($_select.attr("validate")){
				validateClass="validate["+$_select.attr("validate")+"]";
			}
			var t_simpleBox = new SimpleBox({
				comboboxId:t_selectId+'_render'
			  , renderSelectId:t_selectId
			  , width:$('#'+t_selectId).attr('offsetWidth')
			  , disabled :$('#'+t_selectId).attr('disabled')
			  , validateClass:validateClass
			  , renderIndex:t_renderIndex
			  , renderIcon:t_renderIcon
			  , renderTitle:t_renderTitle
			  });
			SimpleBox.instanceContent[t_selectId] = t_simpleBox;
		}
	}
}

/*将下拉列表渲染到指定的wrap中
*
* selectArray - {wrapId:..., selectId:...}
* wrapId - 包裹ID
* selectId - 下拉列表Id
* maxHeight - 设置下拉列表的最大长度
* contentId - 下拉列表的使用范围ID
*/
SimpleBox.renderToUseWrap = function(selectArray){
	if(null != selectArray){
		for(var i=0,len=selectArray.length; i<len; i++){
			var t_select = selectArray[i];
			var t_selectId = t_select.selectId;
			var $select = $('#'+t_selectId);
			var t_selectOffsetWidth = parseInt($select.attr('offsetWidth'));
			var t_width ;
			if(t_selectOffsetWidth && !isNaN(t_selectOffsetWidth)){
				t_width = t_selectOffsetWidth
			}
			var t_selectWidth = parseInt($select.css('width'));
			if(t_selectWidth && !isNaN(t_selectWidth)){
				t_width = t_selectWidth
			}
			if(!t_width || isNaN(t_width)){
				t_width = t_selectOffsetWidth >= t_selectWidth ? t_selectOffsetWidth : t_selectWidth;
			}
			var t_wrapId = t_select.wrapId;
			var t_maxHeight = parseInt(t_select.maxHeight);
			var t_renderIndex = $select.attr("iconIndex");
			var t_renderIcon = $select.attr("iconClass");
			var t_renderTitle = $select.attr("iconTitle");
			if(!t_maxHeight){
			   t_maxHeight = t_select.maxHeight;
			}
			if(!t_renderIndex){
			   t_renderIndex = t_select.iconIndex;
			}
			if(!t_renderIcon){
				 t_renderIcon = t_select.iconClass;
			}
			if(!t_renderTitle){
				 t_renderTitle = t_select.iconTitle;
			}
			var validateClass = "";
			var $_select = $('#'+t_selectId);
			if($_select.attr("validate")){
				validateClass="validate["+$_select.attr("validate")+"]";
			}
			var t_simpleBox = new SimpleBox({
				  wrapId:t_wrapId
				, comboboxId:t_selectId+'_render'
				, renderSelectId:t_selectId
				, width:t_width
				, maxHeight:t_maxHeight
				, contentId:t_select.contentId
				, disabled :$('#'+t_selectId).attr('disabled')
				, validateClass:validateClass
				, renderIndex:t_renderIndex
				, renderIcon:t_renderIcon
				, renderTitle:t_renderTitle
			});
			SimpleBox.instanceContent[t_selectId] = t_simpleBox;
		}
	}
}

/*
 * 获取IP地址可编辑下拉列表实例
 *
 *
 *
 * */
SimpleBox.getIPComboBoxInstance = function(conf){
	if(null != conf){
		var t_simpleBox = new SimpleBox({wrapId:conf.wrapId,
			comboboxId:conf.selectId+'_render',
			renderSelectId:conf.selectId,
			width:$('#'+conf.selectId).attr('offsetWidth'),
			validate:conf.validate,
			isEdit:true,
			name:conf.name,
			contentId:conf.contentId});
		SimpleBox.instanceContent[conf.selectId] = t_simpleBox;
	}
}

/*
 * 重新加载指定的下拉列表
 * selectIdArray - 下拉列表的ID集合
 */
SimpleBox.reload = function(selectIdArray){
	if(null != selectIdArray && selectIdArray.length > 0){
		for(var i=0, len=selectIdArray.length; i<len; i++){
			var t_selectId = selectIdArray[i];
			var t_simpleBox = SimpleBox.instanceContent[t_selectId];
			t_simpleBox.reload();
		}
	}
}