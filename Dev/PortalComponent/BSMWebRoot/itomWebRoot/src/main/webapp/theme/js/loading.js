document.write("<div align='center' id='loadinglayer' style='display: none'>");
document.write("<iframe name='loadingIframe' scrolling=no frameborder=0 width=100% height=100%></iframe></div>");

/*******************************************************************************
 * name: _writeIFrame
 * func: 私有方法. 生成层.
 * in  : none
 * out : none
 * ret : none
 ******************************************************************************/
Loading.prototype._writeIFrame = function()
{
  var strLayer = "<div id='loadingdiv' style='position:absolute;width:330;height:60;border-width:1;border-style:ridge;background-color:white;padding-top:10px;display:none'>"
  + "<center>"
  + "<span id='msg'></span>"
  + "<table border='1' width='300' cellspacing='0' cellpadding='0' style='border-collapse:collapse' height='8'>"
  + "	<tr> "
  + "	  <td> "
  + "      <div id='loading' style='overflow:hidden;width=300;'>"
  + "      	<table align=left cellpadding=0 cellspace=0 border=0>"
  + "      		<tr>"
  + "            <td id='piece' valign='top' >"
  + "            	<div style='width:300;background-color=#ECF2FF'>"
  + "                <table cellspacing='0' cellpadding='0'>"
  + "                  <tr height=8>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                  </tr>"
  + "                </table>"
  + "              </div>"
  + "            </td> "
  + "            <td id='piece2' valign='top'>"
  + "            	<div style='width:300;background-color=#ECF2FF'>"
  + "                <table cellspacing='0' cellpadding='0'>"
  + "                  <tr height=8>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td> "
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                    <td bgcolor=#3399FF width=8></td>"
  + "                    <td width=1></td>"
  + "                  </tr>"
  + "                </table>"
  + "              </div>"
  + "            </td>"
  + "          </tr>"
  + "        </table>"
  + "      </div>"
  + "    </td>"
  + "  </tr>"
  + "</table>"
  + "</center>"
  + "</div>"

  with(document.getElementById('loadingIframe'))
  {
    document.write(strLayer);
    document.close();
  }
}

/*******************************************************************************
 * name: _marquee
 * func: 私有方法. 驱动滚动条滚动.
 * in  : none
 * out : none
 * ret : none
 ******************************************************************************/
Loading.prototype._marquee = function()
{
  oLoadingDiv = document.getElementById('loading');
  opieceDiv  = document.getElementById('piece');
  if(oLoadingDiv.scrollLeft <= 0)
  {
    oLoadingDiv.scrollLeft = opieceDiv.offsetWidth
  }
  else
  {
    oLoadingDiv.scrollLeft = oLoadingDiv.scrollLeft-2;
  }
};

/*******************************************************************************
 * name: Loading
 * func: 构造器.
 * in  : none
 * out : none
 * ret : none
 ******************************************************************************/
function Loading()
{
  var interval;
  var shield;
};

/*******************************************************************************
 * name: Loading
 * func: 构造器.
 * in  : msg 显示的提示信息.
 *       left 提示框左上角坐标
 *       top  提示框左上角坐标
 *       bAutoStart 是否自动显示
 *       bModal     是否为模态的
 *		 width 背景的宽度
 *		 height 背景的高度
 * out : none
 * ret : none
 ******************************************************************************/
function Loading(msg, left, top, bAutoStart, bModal, width, height, bgleft, bgtop)
{
  this._writeIFrame();

  oDiv = document.getElementById('loadingdiv');
  if(!left)
  {
    oDiv.style.left = (window.screen.availWidth /2) - (330/2) ;
  }
  else
  {
    oDiv.style.left = left ;
  }
  if(!top)
  {
  	oDiv.style.top = (window.screen.availHeight/2) - (50/2) - 120;
  }
  else
  {
  	oDiv.style.top = top ;
  }

  if(!bAutoStart)
  {
    if(bAutoStart == false)
    {
      bAutoStart = false;
    }
    else
    {
   	  bAutoStart = true;
   	}
  }

  if(!bModal)
  {
   	bModal = false;
  }

  oTxt = document.getElementById('msg');
  oTxt.innerHTML = msg;

  if(bModal)
  {
    var sWidth,sHeight;

    if (width != undefined || null != width || '' == width) {
    	 sWidth  = width;
    } else {
    	 sWidth  = screen.availWidth-20;
    }
    if (height != undefined || null != height || '' == height) {
    	 sHeight  = height;
    } else {
    	 sHeight = screen.availHeight;
    }



   	var bgObj = document.createElement("div");
    bgObj.setAttribute('id','bgDiv');
    bgObj.style.position = "absolute";
    bgObj.style.top= bgtop+"px" ;
    bgObj.style.background = "#FFFFFF";
    bgObj.style.filter = "progid:DXImageTransform.Microsoft.Alpha(opacity=20)";
    bgObj.style.left= bgleft+"px";
  	bgObj.style.width= sWidth+"px";
   	bgObj.style.height= sHeight+"px";
    bgObj.style.zIndex="10000";

    this.shield = bgObj;

    oDiv.style.zIndex="10001";
  }
  if(bAutoStart)
  {
    this.start();
  }
};

/*******************************************************************************
 * name: start
 * func: 启动显示.
 * in  : none
 * out : none
 * ret : true : 成功。
 *       false: 已经显示。
 ******************************************************************************/
Loading.prototype.start = function()
{
  if(this.shield)
  {
    try {
      document.body.appendChild(this.shield);
    } catch (e) {
    }
  }
  oDiv = document.getElementById('loadingdiv');
  if(oDiv.style.display == 'block')
  {
    return false;
  }

  oDiv.style.display = 'block';
  this.interval = setInterval(this._marquee, 30);
  return true;
};

/*******************************************************************************
 * name: stop
 * func: 停止显示.
 * in  : none
 * out : none
 * ret : none
 ******************************************************************************/
Loading.prototype.stop = function()
{
  clearInterval(this.interval);
  oDiv = document.getElementById('loadingdiv');
  oDiv.style.display = 'none';
  //将滚动条设置到初始位置。
  oLoadingDiv = document.getElementById('loading');
  opieceDiv  = document.getElementById('piece');
  oLoadingDiv.scrollLeft = opieceDiv.offsetWidth

  if(this.shield)
  {
   	try {
   	  document.body.removeChild(this.shield);
    } catch(e) {
    }
  }
};