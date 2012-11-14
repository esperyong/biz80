/**
 * 用于ajax表单提交,遍历表单将所有的值都取得
 * @param p_formId
 * @return
 */
function get_form_params(p_formId){
	var selectSelector = "form#" + p_formId + " select";
	var inputSelector = "form#" + p_formId + " input";
	var textareaSelector = "form#" + p_formId + " textarea";
	//var textareaSelector = "form#" + p_formId + ":textarea";
	var params = '';
	
	$(selectSelector).each(
			function (index, domEle) { 
				  var selectid = domEle.id;
				  var options = domEle.getElementsByTagName('option');
				  for(var i = 0,il = options.length;i < il;i++){
					if(options[i].selected){
						params += ((params.length > 0)?'&':'') + selectid + '='+encodeURIComponent(options[i].value);
					}
				  }
			}
	);
	
	$(inputSelector).each(
			function (index, domEle) { 
				  var type = domEle.getAttribute('type');
				  if(type=='text'||type=='password'||type=='hidden'||(type=='checkbox'&&domEle.checked)){
					  params += ((params.length > 0)?'&':'')+domEle.id+'='+encodeURIComponent(domEle.value);
				  }
				  if(type=='radio'&&domEle.checked){
					  params += ((params.length > 0)?'&':'')+domEle.name+'='+encodeURIComponent(domEle.value);
				  }
			}
	);
	
	$(textareaSelector).each(
			function (index, domEle) { 
				  params += ((params.length > 0)?'&':'')+domEle.id+'='+encodeURIComponent($(domEle).val());
			}
	);		

	return params;
}

/**
 * 预览图片：Example:
 * $(
 *		function(){
 *			$("#picture").change(
 *				function(){
 *					var result = previewImg(this,'preview_fake',"80px","60px");
 *					if(result == 1){
 *						alert('图片格式无效！');
 *					}else if(result == 2){
 *						alert('暂时不支持Opera浏览器!');
 *					}else if(result == 3){
 *						alert('暂时不支持Safari浏览器');
 *					}
 *				}
 *			);
 *		}
 * 	);
 * 	<input type="file" id="picture" name="picture" size="35" value=""/>
 *	<div id="preview_fake" style="margin-left: 50px"/>
 */
function previewImg(obj,divId,width,height){
    if( !obj.value.match( /.jpg|.gif|.png|.bmp/i ) ){
        return 1;
    }
    $("#"+divId).empty();
    var img = document.createElement("img");
    img.setAttribute("src", "");
    img.setAttribute("id", "preview");
    if($.browser.msie){
       if($.browser.version == 6.0){
    	  document.getElementById(divId).appendChild(img);
          $("#preview").attr("src",obj.value);
          $("#preview").attr("style","{width:"+width+";height:"+height+";}"); 
       }else{
    	   var newPreview = document.getElementById(divId);
    	   newPreview.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = obj.value; 
    	   newPreview.style.width = width; 
    	   newPreview.style.height = height;
       }
    }
    
    if($.browser.mozilla){
    	document.getElementById(divId).appendChild(img);
        $("#preview").attr("src",obj.files[0].getAsDataURL());
        $("#preview").attr("style","{width:"+width+";height:"+height+";}");   
    }
    
    if($.browser.opera){
        return 2;
    }
    if($.browser.safari){
        return 3;
    }
	return 0;
}