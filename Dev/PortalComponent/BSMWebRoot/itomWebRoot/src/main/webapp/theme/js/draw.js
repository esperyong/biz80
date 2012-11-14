var mouseDownX;
var mouseDownY;
var mouseUpX;
var mouseUpY;

var div_mouseDownX;
var div_mouseDownY;
var div_mouseUpX;
var div_mouseUpY;

var divLeft;
var divTop;
var moveing;
moveing=0;
divLeft="0";
divTop="0";

var L_Cfun;
var R_Cfun;
var start_per=0;
var end_per=0;
var imgobj;

function down()
{
	if(!mouseObjLeftButtonPressed()) {
		return false;
	}
    if(cutDis.style.display=="block")
	{
	    cutDis.style.display="none";
	}
	
	mouseDownX=event.clientX + document.body.scrollLeft;       
    mouseDownY=event.clientY + document.body.scrollTop;


	div_mouseDownX=event.x;       
    div_mouseDownY=event.y;
	div_mouseDownX=parseInt(div_mouseDownX)+parseInt(divLeft);
	div_mouseDownY=parseInt(div_mouseDownY)+parseInt(divTop);
	
	moveing=1;  
}
function disDown()    
{
    divLeft=cutDis.style.left;
    divTop=cutDis.style.top;
}
function up()
{
	if(!mouseObjLeftButtonPressed()) {
		return false;
	}

	mouseUpX=event.clientX + document.body.scrollLeft;   
	mouseUpY=event.clientY + document.body.scrollTop;


	moveing=0;      
	divLeft="0";
	divTop="0";
	cutDis.style.display="none";

	var imagePos = getPosition(imgobj);
	imageX = imagePos.x;
	imageY = imagePos.y;

	var oRect = getAbsPoint(imgobj);
	swapMouseXY();
					
	var start_per = parseInt((mouseDownX-oRect.left)/imgobj.width*100);
	var end_per = parseInt((mouseUpX-oRect.left)/imgobj.width*100);

//alert("up = "+mouseDownX+","+mouseUpX);
//alert(mouseStartmpX+","+mouseEndmpX+","+imageX);

	eval(L_Cfun+"('"+start_per+"','"+end_per+"')");

}
function move()
{
	if(!mouseObjLeftButtonPressed()) {
		return false;
	}


   if(moveing==1)  
   {
	mouseUpX=event.clientX + document.body.scrollLeft;  
	mouseUpY=event.clientY + document.body.scrollTop;
	

	div_mouseUpX=event.x;              
	div_mouseUpY=event.y;


	cutDis.style.left = Math.min(div_mouseDownX,div_mouseUpX);   
	cutDis.style.top = Math.min(div_mouseDownY,div_mouseUpY);

	div_mouseUpX=Math.abs(div_mouseUpX-div_mouseDownX);              
	div_mouseUpY=Math.abs(div_mouseUpY-div_mouseDownY);

	cutDis.style.width=div_mouseUpX;
	cutDis.style.height=div_mouseUpY;
	

	cutDis.style.display='block';                    
	
   }
}


function swapMouseXY(){
	var t = mouseDownX;
	if(mouseDownX>mouseUpX){
		mouseDownX = mouseUpX;
		mouseUpX = t;
	}
}

function   getAbsPoint(obj)   
{   
	var   x,y;   
	oRect=obj.getBoundingClientRect();   
	x=oRect.left   
	y=oRect.top   
	return oRect;
}

function getPosition(e){
 var left = 0;
 var top  = 0;

 while (e.offsetParent){
  left += e.offsetLeft;
  top  += e.offsetTop;
  e     = e.offsetParent;
 }

 left += e.offsetLeft;
 top  += e.offsetTop;

 return {x:left, y:top};
}

function mouseObjLeftButtonPressed() {
	var LeftButtonPressed = false;
	LeftButtonPressed = (this.event.button < 2);
	return LeftButtonPressed;
}

function rightbtn() {
	eval(R_Cfun+"()");
	return false;

}



function initDraw(id,imgid,leftCfun,rightCfun) {
	var obj = document.getElementById(id);
	imgobj = document.getElementById(imgid);
	this.L_Cfun = leftCfun;
	this.R_Cfun = rightCfun;
	obj.onmousedown=down;
	obj.onmousemove=move;
	obj.onmouseup=up;
	document.oncontextmenu=rightbtn; 
	//alert(document.all[id].innerHTML);
	//document.all[id].innerHTML = "	<div id='cutDis' style='position:absolute; overflow:none; left:0px; top:0px; width:0px; height:0px; visibility:visible; background:magenta; filter:alpha(opacity=50); -moz-opacity:0.5; -khtml-opacity:0.5; opacity:0.5; z-index:5' ></div>" + document.all[id].innerHTML;

	//imgobj.oncontextmenu=rightbtn;
	
}