<!-- WEB-INF\content\location\relation\associateElectricityMap.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>

<page:applyDecorator name="tabPanel">
	<page:param name="id">mytab</page:param>
	<page:param name="width">100%</page:param>
	<page:param name="height">680</page:param>
	<page:param name="tabBarWidth">420</page:param>
	<page:param name="cls">tab-grounp</page:param>
	<page:param name="current">${tabIndex }</page:param>
	<page:param name="tabHander">[{text:"上传图片",id:"upload"},{text:"管理源文件",id:"manage"}]</page:param>
	<page:param name="content_1">
		<s:form id="form1" action="/location/relation/electricityMap!uploadPicture.action" enctype="multipart/form-data" target="hiddenFrame">
			<s:hidden name="location.locationId" />
			<div id="panel-titlebg">
				<ul class="panel-singleli">
					<li>
						<span class="h1 bold font-white"">上传布电图图片：</span>
						<input id="text" type="text"/>
						<span class="buttoncopy"> 
						<input type="file" name="file" id="upload" onKeyDown="DisabledKeyInput();"/>
						</span>
						<SPAN id=export class="gray-btn-l  f-left" >
						<SPAN class=btn-r><SPAN class=btn-m>
						<A onFocus="undefined"  onClick="uploadFile('form1')">上传</A></SPAN></SPAN></SPAN> 
						
						
						<span class="red">&nbsp;&nbsp;&nbsp;&nbsp;注：文件格式限为bmp，大小不能超过2M。</span>				
					</li>
					<li>&nbsp;
					</li>
					<s:if test="#request.locationFile!=null">
					<li style="height:100%;display:block">
						<img id="picture" src="${ctx}/location/relation/electricityMap!downloadPicture.action?location.locationId=${location.locationId}"/>
					</li>
					</s:if>
				</ul>
			</div>
		</s:form>	
	</page:param>
	<page:param name="content_2">
		<s:form id="form2" action="/location/relation/electricityMap!uploadFile.action" enctype="multipart/form-data" target="hiddenFrame">
			<s:hidden name="location.locationId" />
			<div>
				<ul class="panel-singleli">
					<li>
						<span class="h1 bold font-white"">上传布电图文件：</span>
						<input id="text" type="text"/>
						<span class="buttoncopy"> 
						<input type="file" name="file" id="upload" onKeyDown="DisabledKeyInput();"/>
						</span>
						
						<SPAN id=export class="gray-btn-l  f-left" >
						<SPAN class=btn-r><SPAN class=btn-m>
						<A onFocus="undefined"  onClick="uploadFile('form2')">上传</A></SPAN></SPAN></SPAN> 
						
						<span class="red">&nbsp;&nbsp;&nbsp;&nbsp;注：上传wmf文件，可用本地AutoCAD软件打开。</span>	
					</li>
				</ul>
			</div>
		</s:form>
		
	<page:applyDecorator name="indexcirgrid">  
     <page:param name="id">tableId</page:param>
     <page:param name="width">100%</page:param>
     <page:param name="height">435px</page:param>
     <page:param name="tableCls">grid-gray</page:param>
     <page:param name="gridhead">[{colId:"fileName",text:"文件名称"},{colId:"uploadTime",text:"创建时间"},{colId:"uploadUserId",text:"上传人"},{colId:"fileId",text:"操作"}]</page:param>
     <page:param name="gridcontent">${files}</page:param>
   </page:applyDecorator>
   
	</page:param>
</page:applyDecorator>
<iframe name="hiddenFrame" style="display:none"></iframe>

<script type="text/javascript">

	$(document).ready(function () {

		var $form1 = $("#form1");
		var $form2 = $("#form2");
		$("#upload",$form1).change(function(){
			$("#text",$form1).val($("#upload",$form1).val());
		});
		
		$("#upload",$form2).change(function(){
			$("#text",$form2).val($("#upload",$form2).val());
		});

		 tp = new TabPanel({id:"mytab"});	
		var gp = new GridPanel({id:"tableId",
						//width:100,
						unit:"%",
						columnWidth:{fileName:25,uploadTime:25,uploadUserId:25,fileId:25}
					},{gridpanel_DomStruFn:"index_gridpanel_DomStruFn",gridpanel_DomCtrlFn:"index_gridpanel_DomCtrlFn",gridpanel_ComponetFn:"index_gridpanel_ComponetFn"});
		
		gp.rend([{index:"fileId",fn:function(td){
			if(td.html==""){
				return "";
				}
	    	var span1 =  jQuery("<span class='gray-btn-singleline'>&nbsp;&nbsp;打开&nbsp;&nbsp;</span>").click(function(){
	    		var elemIF = document.createElement("iframe");   
	    		elemIF.src = "${ctx}/location/relation/electricityMap!downloadFile.action?locationFile.fileId=" + td.html;
	    		elemIF.style.display = "none";   
	    		document.body.appendChild(elemIF);
	    	});
	    	var span2 =  jQuery("<span class='gray-btn-singleline'>&nbsp;&nbsp;删除&nbsp;&nbsp;</span>").click(function(){
	    		var confirm_batdel = new confirm_box({text:"该操作不可恢复，是否确认删除？"});
	    		confirm_batdel.show();
	    		confirm_batdel.setConfirm_listener(function(){
	    		confirm_batdel.hide();
		    			$.ajax({
	    				url: 		"${ctx}/location/relation/electricityMap!delete.action",
	    				data:		"locationFile.fileId=" + td.html,
	    				dataType: 	"html",
	    				cache:		false,
	    				success: function(data, textStatus){
	    					reloadContent();
	    				}
	    			});
		    	});
		    	confirm_batdel.setCancle_listener(function(){
		    		confirm_batdel.hide();
					});
	    		
	    	});    	
	    	return $("<span></span>").append(span1).append("&nbsp;").append(span2);
		}}]);
	});
	
	//屏蔽输入
	function DisabledKeyInput(){
	   if(event.keyCode!=8&&event.keyCode!=46) event.returnValue=false;
	   if(event.ctrlKey) return false;
	}
	
	//上传文件 
	function uploadFile(formId){
		var $form = $("#"+formId);
		var $upload = $("#upload", $form);
		//验证不为空
		if($upload == null || $upload.val() == ""){
			//alert("请选择要上传的文件");
			showMess("请选择要上传的文件");
			return false;
		}

		if(formId=="form1"){
			
			//上传文件类型错误
			var uploadFileTyep = $upload.val().match(/^(.*)(\.)(.{1,8})$/)[3].toLowerCase();
			if("${fiatPictureType}".indexOf(uploadFileTyep)<0){
				//alert("上传格式不符,请上传${fiatPictureType}文件");
				var mes = "${fiatPictureType}";
				var me = mes.split("/");
				showMess("上传格式不符,请上传"+me[1]+"文件");
				$form[0].reset();
				return false;
			}
		}
		
		if(formId=="form2"){
			
			//上传文件类型错误
			var uploadFileTyep = $upload.val().match(/^(.*)(\.)(.{1,8})$/)[3].toLowerCase();
			if("${fiatCADType}".indexOf(uploadFileTyep)<0){
				//alert("上传格式不符,请上传${fiatCADType}文件");
				showMess("上传格式不符,请上传wmf文件");
				$form[0].reset();
				return false;
			}
		}
		
		$form.submit();
	}
	function showMess(str){
		var toast = new Toast({position:"CT"});
		toast.addMessage(str);
	}
	function reloadContent(){
		loadContent("${ctx}/location/relation/electricityMap!showAssociateElectricityMap.action","tabIndex="+tp.currentIndex);
	}
</script>