var dialogWidthAdd, dialogHeightAdd;
// 重新设置对话框的宽和高
function dialogResize(dialogWidth, dialogHeight){
	dialogWidth = dialogWidth?dialogWidth:document.body.scrollWidth;
	dialogHeight = dialogHeight?dialogHeight:document.body.scrollHeight;
	window.dialogWidth=dialogWidth+(dialogWidthAdd?dialogWidthAdd:0)+"px";
	window.dialogHeight=dialogHeight+(dialogHeightAdd?dialogHeightAdd:0)+"px";
}
// 对话框居中
function dialogCenter(){
	window.dialogTop=(screen.availHeight-document.body.scrollHeight-(dialogHeightAdd?dialogHeightAdd:0))/3+"px";
	window.dialogLeft=(screen.availWidth-document.body.scrollWidth-(dialogWidthAdd?dialogWidthAdd:0))/2+"px";
}
// 文档加载完成设置对话框的宽度和高度
$(function(){
	dialogResize();
})
