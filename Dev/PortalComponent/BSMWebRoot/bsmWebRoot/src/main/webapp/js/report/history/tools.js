/*******************************************************************************
 * Copyright Mocha Software Co.,Ltd. 
 ******************************************************************************/
  

/*******************************************************************************
 * 构造器
 ******************************************************************************/
function Tools() 
{
  var m_param; //定义传递用的数组
  var m_curwin;//定义当前被打开的窗口
  var m_oOpened; //记录打开的窗口句柄.
}

/*******************************************************************************
 * 名称: getOpened
 * 功能: 取得打开的窗口句柄列表.
 * 输入: 无
 * 输出: 无
 * 返回: 打开的窗口句柄列表.
 ******************************************************************************/
Tools.prototype.getOpened = function()
{
  if(!this.m_oOpened)
  {
    this.m_oOpened = new Array();
  }
  return this.m_oOpened;
}

/*******************************************************************************
 * 名称: closeAllOpened
 * 功能: 关闭所有打开的窗口.
 * 输入: 无
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.closeAllOpened = function()
{
  var t_oList = this.getOpened();
  
  for(i = 0; i < t_oList.length; i++)
  {
    if(!t_oList[i].closed)
    {
      t_oList[i].close();
    }
  }
}

/*******************************************************************************
 * 名称: setWindow
 * 功能: 设置窗口对象
 * 输入: window 句柄.
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.setWindow = function (win)
{
  this.m_curwin = win;
}
/*******************************************************************************
 * 名称: checkLength
 * 功能: 限制textarea输入的长度
 * 输入: element: textarea对象
        limit：限制的长度
 * 输出: 无
 ******************************************************************************/
Tools.prototype.checkLength = function(element,limit) 
{
  if (element.value.length > limit) 
 {// if too long.... trim it!
   element.value = element.value.substring(0, limit);
 }
 // var regC = /[^-~]+/g;
  //var regE = /\D+/g;
  //var str = element.value;
  
  //if (regC.test(str)){
   // element.value = element.value.substr(0,limit);
 // }
  
  //if(regE.test(str)){
  //  element.value = element.value.substr(0,2*limit);
  //}
}

/*******************************************************************************
 * 名称: extendedopen
 * 功能: 私有方法, window.open 扩展
 * 输入: sURL      : String that specifies the URL of the document to display. 
         sName     : String that specifies the name of the window .
         sFeatures : Optional. 
         bReplace  : Optional. 
 * 输出: 无
 ******************************************************************************/
Tools.prototype.extendedopen = function(sURL, sName, sFeatures, bReplace)
{
	if(!sURL)
	{
		sURL = '';
	}
	if(!sName)
	{
		sName = '';
	}
	if(!sFeatures)
	{
		sFeatures = '';
	}
	if(!bReplace)
	{
		bReplace = '';
	}
	
	var t_bHasChip = false;
	
	var t_oOpenedList = this.getOpened();
	
	var t_retWin = window.open(sURL, sName, sFeatures, bReplace);
	
	for(i = 0; i < t_oOpenedList.length; i++)
	{
		
		if(t_oOpenedList[i].closed)
		{
		  t_oOpenedList[i] = t_retWin;
		  t_bHasChip = true;
		  break;
	  }
	}
	if(!t_bHasChip)
	{
	  t_oOpenedList[t_oOpenedList.length] = t_retWin;
    }
    
    return t_retWin;
}

/*******************************************************************************
 * 名称: openFullWin
 * 功能: 全屏幕打开新窗口
 * 输入: url    
 ×      title  窗口对象名称
 *      width  窗口宽度
 *      height 窗口高度
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.openFullWin = function (url,title)
{
  var newwindow = this.extendedopen(url,title,"directories=no,location=no,menubar=no,resizable=yes,scrollbars=yes,status=no,titlebar=no,toolbar=no");
  newwindow.focus();
  if(!newwindow.closed)
  {
    newwindow.moveTo(0,0)
    newwindow.resizeTo(screen.availWidth, screen.availHeight)
  }
  return newwindow;
}

/*******************************************************************************
 * 名称: _onloadResize
 * 功能: 动态调整窗口的大小。
 * 输入: 
 * 输出: 无
 * 返回: 
 ******************************************************************************/
Tools.prototype.onloadResize = function(nomoving)
{
  var width = this.m_curwin.document.body.scrollWidth;
  var height = this.m_curwin.document.body.scrollHeight + 38;

  if(!nomoving)
  {
    var showx = screen.availWidth / 2 - width / 2;
    var showy = screen.availHeight / 2 - height / 2; 

    this.m_curwin.moveTo(showx, showy);
  }
  this.m_curwin.resizeTo(width+30 , height);
 // alert("width = " + width + " height = " + height);
}

/*******************************************************************************
 * 名称: openWin
 * 功能: 弹出新窗口
 * 输入: url    
 ×      title  窗口对象名称
 *      width  窗口宽度
 *      height 窗口高度
 *      autoresize 是否自动改变窗口大小
 *      scrollbars 是否显示滚动条
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.openWin = function (url,title,width,height,autoresize,scrollbars)
{
  showx = screen.availWidth / 2 - width / 2;
  showy = screen.availHeight / 2 - height / 2; 
  
  var isscrollbars;
  if(typeof(scrollbars) != 'undefined')
  {
    isscrollbars = 'yes'
  } 
  else
  {
    isscrollbars = 'no'
  }
  
  m_curwin = this.extendedopen(url,title,"width="+ width +",height="+ height +",top=" + showy +",left=" + showx + ",directories=no,location=no,menubar=no,resizable=yes,scrollbars="+ isscrollbars +",status=no,titlebar=no,toolbar=no");
  if(autoresize)
  {
    m_curwin.attachEvent('onload', this.onloadResize);
  }

  m_curwin.focus();

  return m_curwin;
}

/*******************************************************************************
 * 名称: openWinFromForm
 * 功能: Post 方式弹出新窗口
 * 输入: oForm  form对象    
 ×      title  窗口对象名称
 *      width  窗口宽度
 *      height 窗口高度
 *      autoresize 是否自动改变窗口大小
 *      scrollbars 是否显示滚动条
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.openWinFromForm = function (oForm,title,width,height,autoresize,scrollbars)
{
  if(!oForm)
  {
    return;
  }
  showx = screen.availWidth / 2 - width / 2;
  showy = screen.availHeight / 2 - height / 2; 
  
  var isscrollbars;
  if(!scrollbars)
  {
    isscrollbars = 'yes'
  }
  else
  {
    isscrollbars = 'no'
  }
  m_curwin = this.extendedopen('',title,"width="+ width +",height="+ height +",top=" + showy +",left=" + showx + ",directories=no,location=no,menubar=no,resizable=no,scrollbars="+ isscrollbars +",status=no,titlebar=no,toolbar=no");
  if(autoresize)
  {
    m_curwin.attachEvent('onload', this.onloadResize);
  }

  oForm.target = title;
  oForm.submit();
  
  m_curwin.focus();
  
  return m_curwin;
}

/*******************************************************************************
 * 名称: showModalWin
 * 功能: 弹出模态对话框
 * 输入: url    
 *      width  对话框宽度
 *      height 对话框高度
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.showModalWin = function (sUrl, vArguments, iWidth, iHeight) 
{
/** xjcmcc,窗口弹出默认居中 modify by zhangjk begin
  sFeatures="dialogWidth="+iWidth+"px;dialogHeight="+iHeight+"px;help=no;status=no;scroll=yes";    
**/  
  sFeatures="center=yes;dialogWidth="+iWidth+"px;dialogHeight="+iHeight+"px;help=no;status=no;scroll=yes";    
/** xjcmcc,窗口弹出默认居中 modify by zhangjk end **/
  if (sUrl.indexOf("?") == -1) 
  {
    sUrl += "?time=" + this.getCurrentTime() + Math.random();
  } 
  else 
  {
    sUrl += "&time=" + this.getCurrentTime() + Math.random();
  }
  return window.showModalDialog(sUrl, vArguments, sFeatures);
};
  
/*******************************************************************************
 * 名称: selectAll
 * 功能: 所以checkbox选择
 * 输入: form对象    
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.selectAll = function (oForm) 
{
  if(!oForm)
  { 
    return;
  }

  if (oForm.cb.checked) 
  {
    if (oForm.chb.length > 1) 
    {
      for (var i = 0; i < oForm.chb.length; i++) 
      {
        oForm.chb[i].checked = true;
      }
    } 
    else 
    {
      oForm.chb.checked = true;
    }
  }
  else
  {
    if (oForm.chb.length > 1) 
    {
      for (var i = 0; i < oForm.chb.length; i++) 
      {
        oForm.chb[i].checked = false;
      }
    } 
    else 
    {
      oForm.chb.checked = false;
    }
  }
};


/*******************************************************************************
 * 名称: deleteCheckBoxValue
 * 功能: 取得所有选中的CheckBox对象值
 * 输入: checkbox组 
 * 输出: 无
 * 返回: 返回选中的CheckBox对象值, 如果没有选中返回''
 ******************************************************************************/
Tools.prototype.deleteCheckBoxValue = function(checkboxGroup)
{
  
  if(typeof(checkboxGroup[0]) == 'undefined')
  {
    if(checkboxGroup.checked)
    {
      return checkboxGroup.value;
    }
  } 
  else 
  {
    var retValue = '';
    
    
    var retValue = '';
    for(i=0; i < checkboxGroup.length; i++)
    {
      if(checkboxGroup[i].checked)
      {
      	if(retValue == '')
      	{
          retValue = checkboxGroup[i].value;
      	}
        else
        {
          retValue = retValue + '@@' + checkboxGroup[i].value;
        }
      }
    }

    return retValue;
  }
  return '';
};
/*******************************************************************************
 * 名称: generateNavigation
 * 功能: 用于displayTag翻页
 * 输入: 页数
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.generateNavigation = function (per_page_num) 
{
  //左边的信息
  if(document.all._oneitem || document.all._allitems) 
  {
    document.all.total_page.innerText = 1;
    document.all.cur_page.innerText = 1;
  }
  if(document.all._someitem) 
  {
    var pages = document.all._someitem.innerText.split("|");
    var total = pages[0];
    var cur = pages[1];
    total = total.replace(",", ""); //防止里面的科学技术法中的逗号，形式如：1,100
    cur = cur.replace(",", "");
    document.all.total_page.innerText = Math.ceil(total / per_page_num);
    document.all.cur_page.innerText = cur;
  }

  //导航信息
  if (document.all._full) 
  {
    var pages = document.all._full.innerText.split("|");
    this.createLink("list_home", pages[0]);
    this.createLink("list_pre", pages[1]);
    this.createLink("list_next", pages[2]);
    this.createLink("list_end", pages[3]);
  }
  if (document.all._first) 
  {
    var pages = document.all._first.innerText.split("|");
    this.createLink("list_next", pages[0]);
    this.createLink("list_end", pages[1]);
  }
  if (document.all._last) 
  {
    var pages = document.all._last.innerText.split("|");
    this.createLink("list_home", pages[0]);
    this.createLink("list_pre", pages[1]);
  }
};

/*******************************************************************************
 * 名称: createLink
 * 功能: 生成具体的一个连接地址
 * 输入: 域id
 * 输出: 无
 * 返回: url 连接地址
 ******************************************************************************/
Tools.prototype.createLink = function (id, url) 
{
  var test1 = /[d]-.*-[s]/;
  var test2 = /[d]-.*-[o]/;
  var test3 = /[d]-.*-[st]/;
  var newUrl;

  if (typeof (url) != 'undefined' && url != null) 
  {
    var start = url.indexOf(".action?");
    if (start != -1) 
    {
      newUrl = url.substring(0, start + 8);
      var parameter = url.substring(start + 8, url.length);
      var parameters = parameter.split("&");
      for (var i = 0; i < parameters.length; i++) 
      {
        var namevalue = parameters[i].split("=");
        //alert(parameters[i]);
        if (namevalue != null && namevalue.length > 1) 
        {
          if (!(test1.test(namevalue[0]) || test2.test(namevalue[0]) || test3.test(namevalue[0]))) 
          {
            newUrl = newUrl + parameters[i];
            if (i < parameters.length - 1) 
            {
              newUrl = newUrl + "&";
            }
          }
        }
      }
    } 
    else 
    {
      newUrl = url;
    }
  }
  
  document.all[id].style.cursor = "hand";
  //document.all[id].title = document.all[id].tag;
  if ("a" == document.all[id].tagName.toLowerCase()) 
  {
    document.all[id].href = newUrl;
  } 
  else 
  {
    document.all[id].onclick = new Function("window.location.replace('" + newUrl + "')");
  }
};


/*******************************************************************************
 * 名称: generateNavigation4Post
 * 功能: 用于displayTag POST方式翻页
 * 输入: 页数
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.generateNavigation4Post = function (per_page_num) 
{
  //左边的信息
  if(document.all._oneitem || document.all._allitems) 
  {
    document.all.total_page.innerText = 1;
    document.all.cur_page.innerText = 1;
  }
  if(document.all._someitem) 
  {
    var pages = document.all._someitem.innerText.split("|");
    var total = pages[0];
    var cur = pages[1];
    total = total.replace(",", ""); //防止里面的科学技术法中的逗号，形式如：1,100
    cur = cur.replace(",", "");
    document.all.total_page.innerText = Math.ceil(total / per_page_num);
    document.all.cur_page.innerText = cur;
  }

  //导航信息
  if (document.all._full) 
  {
    var pages = document.all._full.innerText.split("|");
    this.createLink4Post("list_home", pages[0]);
    this.createLink4Post("list_pre", pages[1]);
    this.createLink4Post("list_next", pages[2]);
    this.createLink4Post("list_end", pages[3]);
  }
  if (document.all._first) 
  {
    var pages = document.all._first.innerText.split("|");
    this.createLink4Post("list_next", pages[0]);
    this.createLink4Post("list_end", pages[1]);
  }
  if (document.all._last) 
  {
    var pages = document.all._last.innerText.split("|");
    this.createLink4Post("list_home", pages[0]);
    this.createLink4Post("list_pre", pages[1]);
  }
};

/*******************************************************************************
 * 名称: createLink4Post
 * 功能: 生成具体的一个POST提交.
 * 输入: 域id
 * 输出: 无
 * 返回: url 连接地址
 ******************************************************************************/
Tools.prototype.createLink4Post = function (id, url) 
{
  var test1 = /[d]-.*-[s]/;
  var test2 = /[d]-.*-[o]/;
  var test3 = /[d]-.*-[st]/;
  var newUrl;

  if (typeof (url) != 'undefined' && url != null) 
  {
    var start = url.indexOf(".action?");
    if (start != -1) 
    {
      newUrl = url.substring(0, start + 8);
      var parameter = url.substring(start + 8, url.length);
      var parameters = parameter.split("&");
      for (var i = 0; i < parameters.length; i++) 
      {
        var namevalue = parameters[i].split("=");
        //alert(parameters[i]);
        if (namevalue != null && namevalue.length > 1) 
        {
          if (!(test1.test(namevalue[0]) || test2.test(namevalue[0]) || test3.test(namevalue[0]))) 
          {
            newUrl = newUrl + parameters[i];
            if (i < parameters.length - 1) 
            {
              newUrl = newUrl + "&";
            }
          }
        }
      }
    } 
    else 
    {
      newUrl = url;
    }
  }
  
  document.all[id].style.cursor = "hand";
  document.all[id].onclick = new Function("var oForm = document.getElementsByTagName('FORM')[0]; oForm.action='" + newUrl + "'; oForm.submit();  return false;");

};


/*******************************************************************************
 * 名称: getCurrentTime
 * 功能: 取得当前时间
 * 输入: 无
 * 输出: 无
 * 返回: String
 ******************************************************************************/
Tools.prototype.getCurrentTime = function()
{
  var  oNow  =  new Date()
  var  hours  =  oNow.getHours()
  var  minutes  =  oNow.getMinutes()
  var  seconds  =  oNow.getSeconds()
  var  timeValue  =  hours
  timeValue  +=  ((minutes  <  10)  ?  ":0"  :  ":")  +  minutes
  timeValue  +=  ((seconds  <  10)  ?  ":0"  :  ":")  +  seconds
  return timeValue  
};

/*******************************************************************************
 * 名称: showAlert
 * 功能: 弹出显示消息的模态窗口
 * 输入: 无
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.showAlert = function(msg, funName, args, path)
{
  this.m_param = new Array();
  this.m_param[0]="";
  if(funName)
  {
    this.m_param[1]=funName;
  }

  var param = '';
  if(args)
  {
    if(!(args instanceof Array))
    {
      throw new Error('IllegalArgumentException args is not a Array');
    }
    param = '&argslen=' + args.length;
    for(i = 0; i < args.length; i++)
    {
      param = param + '&arg' + i + '=' + encodeURIComponent(args[i]);
    }
  }

  this.m_curwin = window;

  if(!path)
  {
    var t_path = window.location.pathname;

    t_path = t_path.substring(0, t_path.indexOf('/', 1));
    if(t_path.indexOf('/') != 0)//可能获取到的路径不带有/，需要强制的增加/ 
    { 
      t_path='/' + t_path;
    }
    
    return this.showModalWin(t_path + "/jsp/commons/info.jsp?msg=" + msg + param, this, 272, 158);
  }
  else
  {
    return this.showModalWin(path + "?msg=" + msg + param, this, 272, 158);
  }
}

/*******************************************************************************
 * 名称: showError
 * 功能: 弹出error窗口
 * 输入: 无
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.showError = function (msg, funName, args, path)
{
  this.m_param = new Array();
  this.m_param[0]="";
  if(funName)
  {
    this.m_param[1]=funName;
  }

  var t_path = window.location.pathname;

  t_path = t_path.substring(0, t_path.indexOf('/', 1));
  if(t_path.indexOf('/') != 0) //可能获取到的路径不带有/，需要强制的增加/ 
  { 
    t_path='/' + t_path;
  }

  var param = '';
  if(args)
  {
    if(!(args instanceof Array))
    {
      throw new Error('IllegalArgumentException args is not a Array');
    }
    param = '&argslen=' + args.length;
    for(i = 0; i < args.length; i++)
    {
      param = param + '&arg' + i + '=' + encodeURIComponent(args[i]);
    }
  }
  
  this.m_curwin = window;
  
  if(!path)
  {
    var t_path = window.location.pathname;

    t_path = t_path.substring(0, t_path.indexOf('/', 1));
    if(t_path.indexOf('/') != 0)//可能获取到的路径不带有/，需要强制的增加/ 
    { 
      t_path='/' + t_path;
    }
    
    return this.showModalWin(t_path + "/jsp/commons/error.jsp?msg=" + msg + param, this, 515, 158);
  }
  else
  {
    return this.showModalWin(path + "?msg=" + msg + param, this, 515, 158);
  }
}

/*******************************************************************************
 * 名称: showConfirm
 * 功能: 弹出confirm窗口
 * 输入: 无
 * 输出: 无
 * 返回: window 句柄.
 ******************************************************************************/
Tools.prototype.showConfirm = function (msg, funOK, funCancel, args, path)
{
  this.m_param = new Array();
  this.m_param[0]="";
  if(funOK)
  {
    this.m_param[1] = funOK;
  }
  if(funCancel)
  {
  	this.m_param[2] = funCancel;
  }

  var param = '';
  if(args)
  {
    if(!(args instanceof Array))
    {
      throw new Error('IllegalArgumentException args is not a Array');
    }
    param = '&argslen=' + args.length;
    for(i = 0; i < args.length; i++)
    {
      param = param + '&arg' + i + '=' + encodeURIComponent(args[i]);
    }
  }
  
  this.m_curwin = window;

  if(!path)
  {
    var t_path = window.location.pathname;

    t_path = t_path.substring(0, t_path.indexOf('/', 1));
    if(t_path.indexOf('/') != 0)//可能获取到的路径不带有/，需要强制的增加/ 
    { 
      t_path='/' + t_path;
    }
    
    return this.showModalWin(t_path + "/jsp/commons/confirm.jsp?msg=" + msg + param, this, 272 , 158);
  }
  else
  {
    return this.showModalWin(path + "?msg=" + msg + param, this, 272, 158);
  }
}

/*******************************************************************************
 * 名称: getCheckboxValues
 * 功能: 取得Checkbox的值.
 * 输入: 无
 * 输出: 无
 * 返回: string
 ******************************************************************************/
Tools.prototype.getCheckboxValues = function (checkboxGroup)
{
  if(typeof(checkboxGroup[0]) == 'undefined')
  {
    if(checkboxGroup.checked)
    {
      return checkboxGroup.value;
    }
  } 
  else 
  {
    var retValue = '';
    for(i=1; i < checkboxGroup.length; i++)
    {
      if(checkboxGroup[i].checked)
      {
      	if(retValue == '')
      	{
          retValue = checkboxGroup[i].value;
      	}
        else
        {
          retValue = retValue + ',' + checkboxGroup[i].value;
        }
      }
    }

    return retValue;
  }

  return '';
}


/*******************************************************************************
 * 名称: getCheckboxValue
 * 功能: 取得Checkbox的值.
 * 输入: 无
 * 输出: 无
 * 返回: string
 ******************************************************************************/
Tools.prototype.getCheckboxValue = function (checkboxGroup)
{
  if(typeof(checkboxGroup[0]) == 'undefined')
  {
    if(checkboxGroup.checked)
    {
      return checkboxGroup.value;
    }
  } 
  else 
  {
    var retValue = '';
    for(i=0; i < checkboxGroup.length; i++)
    {
      if(checkboxGroup[i].checked)
      {
      	if(retValue == '')
      	{
          retValue = checkboxGroup[i].value;
      	}
        else
        {
          retValue = retValue + ',' + checkboxGroup[i].value;
        }
      }
    }

    return retValue;
  }

  return '';
}


/*******************************************************************************
 * 名称: getGroupValues
 * 功能: 取得Checkbox的值.
 * 输入: 无
 * 输出: 无
 * 返回: string
 ******************************************************************************/
Tools.prototype.getGroupValues = function (group)
{
  if(typeof(group[0]) == 'undefined')
  {
    return group.value;
  } 
  else 
  {
    var retValue = '';
    for(i=1; i < group.length; i++)
    {
      if(retValue == '')
      {
        retValue = group[i].value;
      }
      else
      {
        retValue = retValue + ',' + group[i].value;
      }

    }

    return retValue;
  }

  return '';
}

/*******************************************************************************
 * 名称: getCheckboxBindValues
 * 功能: 取得Checkbox的绑定值.
 * 输入: 无
 * 输出: 无
 * 返回: string
 ******************************************************************************/
Tools.prototype.getCheckboxBindValues = function (checkboxGroup, bindIndex)
{
  if(typeof(checkboxGroup[0]) == 'undefined')
  {
    if(checkboxGroup.checked)
    {
      return checkboxGroup.parentNode.childNodes[bindIndex].value;
    }
  } 
  else 
  {
    var retValue = '';
    for(i=0;i<checkboxGroup.length;i++)
    {
      if(checkboxGroup[i].checked)
      {
        retValue = retValue + ',' + checkboxGroup[i].parentNode.childNodes[bindIndex].value;
      }
    }

    return retValue;
  }

  return '';
}

/*******************************************************************************
 * 名称: getCheckboxValueByIndex
 * 功能: 取得Checkbox的绑定值.
 * 输入: 无
 * 输出: 无
 * 返回: string
 ******************************************************************************/
Tools.prototype.getCheckboxVByI = function (checkboxGroup, txtGroup)
{
  var ret = new Array(2);
  var ids;
  var values;
  if(typeof(checkboxGroup[0]) == 'undefined')
  {
    if(checkboxGroup.checked)
    {
      ids = checkboxGroup.value;
      values = txtGroup.value;
    }
  } 
  else 
  {
    var ids = '';
    for(i=0;i<checkboxGroup.length;i++)
    {
      if(checkboxGroup[i].checked)
      {
      	if(ids == '')
      	{
      	  ids = checkboxGroup[i].value;
      	  values = txtGroup[i].value;
      	}
        else
        {
          ids = ids + ',' + checkboxGroup[i].value;
          values = values + ',' + txtGroup[i].value;
        }
      }
    }
  }

  ret[0] = ids;
  ret[1] = values;
  return ret;
}

/*******************************************************************************
 * 名称: goPage
 * 功能: 页面跳转到第几页
 * 输入: 无
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.goPage = function ()
 { 

 var pages;

 if (document.all._full) 
  {
     pages = document.all._full.innerText.split("|");   
  }
  if (document.all._first) 
  {
     pages = document.all._first.innerText.split("|");
   
  }
  if (document.all._last) 
  {
     pages = document.all._last.innerText.split("|");
   
  }
var check = new Verifier(); 
 var i= document.forms[0].pageNum.value; 
 var number=document.all.total_page.innerText ;
 if(!check.CheckInteger(document.forms[0].pageNum) ||i<=0 || parseInt(i)>parseInt(number)){
  this.showAlert("PageCountErr");
  return false;
 }
      var url; 
    try {
    url = pages[0];
  } catch (e) {
    //history.go(0);
    this.showAlert("CurrentIsOneAlready");
    return false;
  }           
   re= /(d\-\d+\-p=)(\d+)/ 
   if(re.test(url))
   {
     t=RegExp.$1
     url=url.replace(re,t+i);
   }     
   window.location.href=url;
      
 }

/*******************************************************************************
 * 名称: goPage4Post
 * 功能: 页面跳转到第几页
 * 输入: 无
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.goPage4Post = function ()
{ 
 
  var pages;
  if (document.all._full) 
  {
     pages = document.all._full.innerText.split("|");   
  }
  if (document.all._first) 
  {
     pages = document.all._first.innerText.split("|");
  }
  if (document.all._last) 
  {
     pages = document.all._last.innerText.split("|");
  }
  
  var oForm = document.getElementsByTagName('FORM')[0];
  var i= oForm.pageNum.value; 
  
  for (ci = 0; ci < i.length; ci++)
  {
    ch = i.charAt(ci);
    if (ch < '0' || ch > '9') 
    {
       this.showAlert("PageCountErr");
       return false;
    }
  }
  var number=parseInt(document.all.total_page.innerText);
  if(i.substring(0,1) == 0 ||i.substring(0,1) == "0")
  {
    this.showAlert("PageCountErr");
    return false;	
  }
  if(parseInt(i)<0 || parseInt(i)>number)
  {

    this.showAlert("PageCountErr");
    return false;
  }
  
  var url;
  
  try {
    url = pages[0];
  } catch (e) {
    this.showAlert("CurrentIsOneAlready");
    return false;
  }
  
  re= /(d\-\d+\-p=)(\d+)/ 
  if(re.test(url))
  {
    t=RegExp.$1
    url=url.replace(re,t+i);
  }
   
  oForm.action = url;
  oForm.submit();
}

/*******************************************************************************
 * 名称: setFocus
 * 功能: 设置第一个INPUT控件获取焦点.
 * 输入: 无
 * 输出: 无
 * 返回: 无
 ******************************************************************************/
Tools.prototype.setFocus = function()
{
  var oInputs = document.getElementsByTagName("INPUT");
  for(var i=0;i<oInputs.length;i++)
  {
    var oTxt = oInputs[i];
    try{
      //使焦点在每页的第一个文本输入框上
      if(oTxt.type == "text" || oTxt.type == "textarea")
      {
        oTxt.focus();
        break;
      }
    }catch(e){
    }
  }
}
/*******************************************************************************
 * 名称: getPagesUrl
 * 功能: 获得翻页的url
 * 输入: 无
 * 输出: 当前页面url
 * 返回: 无
 ******************************************************************************/
Tools.prototype.getPagesUrl = function()
{
 var url = window.location.href;
  //导航信息
  if (document.all._full) 
  {
    var pages = document.all._full.innerText.split("|");
    url = pages[0];
    
  }
  if (document.all._first) 
  {
    var pages = document.all._first.innerText.split("|");
    url = pages[0];
  }
  if (document.all._last) 
  {
    var pages = document.all._last.innerText.split("|");
    url = pages[0];
  }
  return url;
}

/*******************************************************************************
 * 名称: isSelectAll
 * 功能: 设置全选
 * 输入: size 记录条数,obj 列表checkbox的名称,perObj 标题栏中checkbox 的名称
 * 输出: 无
 * 返回: 
 ******************************************************************************/
Tools.prototype.isSelectAll=function(size,obj,perObj)
{
 
  var checkCount=0;

  if(obj.length >0)
  {
    for(i=0;i<size;i++)
    {
      if(obj[i].checked)
      {
        checkCount++;
      }
    }

    if(checkCount>=size)
    {
      perObj.checked=true;
    }   
    else
    {
  
     perObj.checked=false;
    }
  }
  else
 {
  perObj.checked=obj.checked;
  }
}


Tools.prototype.isHashSelectAll=function(size,obj,perObj)
{
 
  var checkCount=0; 
  if(size > obj.length){
  	size = obj.length;
  }
  if(obj.length >0)
  {
    for(i=0;i<size;i++)
    {
      if(obj[i].checked)
      {
        checkCount++;
      }
    }

    if(checkCount>=size)
    {
      perObj.checked=true;
    }   
    else
    {
  
     perObj.checked=false;
    }
  }
  else
 {
  perObj.checked=obj.checked;
  }
}
/**************************************************************************************************************
 * 名称: showSelectMessage
 * 功能: 下拉框内容完整信息的提示
 * 输入: tips 下拉框的name或者id,flag 是否显示层，如果显示，传1,position 提示框显示未知是否左移30像素，opt不用传调用别的方法使用
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.showSelectMessage = function(tips,flag,position,opt){
	var my_tips=document.getElementById("mytips");
	try{
		if(flag){
			var eleSelectElement;
			var selectValue;
			if(opt==null||opt==""){
	 			eleSelectElement = get_element(tips);
	 			selectValue = eleSelectElement[eleSelectElement.selectedIndex].text;
	 		}else{
	   			eleSelectElement = get_element(opt);
	   			selectValue = eleSelectElement.text
	   		}
	 		
	    	my_tips.innerHTML="<font class='selectword'>"+selectValue+"</font>";
	    	my_tips.style.display="";
	    	
	   	 	my_tips.style.left=event.clientX+document.body.scrollLeft-1;
	    	var topp = event.clientY+10+document.body.scrollTop;
	    	
	    	if(position==1){
	    		topp = event.clientY-30+document.body.scrollTop;
	    	}
	    	my_tips.style.top=topp;
	   		
		}else{
	   		my_tips.style.display="none";
	   	}
   	}catch(e){
   	}
}

/**************************************************************************************************************
 * 名称: noneSelectDisplay
 * 功能: 当鼠标离开下拉框区域，浮现提示框不显示
 * 输入: 无
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.noneSelectDisplay = function (){
	var my_tips=document.getElementById("mytips");
	my_tips.style.display= "none";
}
/**************************************************************************************************************
 * 名称: getElements
 * 功能: 获得页面表单内的所有元素
 * 输入: doc document对象
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.getElements = function (doc){
  var o_obj = doc.getElementsByTagName("INPUT");
  this.disableFormElement(o_obj);
  o_obj = doc.getElementsByTagName("SELECT");
  this.disableFormElement(o_obj);
  o_obj = doc.getElementsByTagName("IMG");
  this.onclickNone(o_obj);
  o_obj = doc.getElementsByTagName("A");
  this.onclickNone(o_obj);
}

/**************************************************************************************************************
 * 名称: disableFormElement
 * 功能: 将元素disabled
 * 输入: o_obj 页面元素数组
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.disableFormElement = function (o_obj){
  for(var i = 0; i < o_obj.length; i ++)
  {
  
    o_obj[i].disabled = true;
  }
}

/**************************************************************************************************************
 * 名称: onclickNone
 * 功能: 将页面所有链接的onclick事件置空
 * 输入: 无
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.onclickNone = function (o_obj){
  for(var i = 0; i < o_obj.length; i ++)
  {
  
    o_obj[i].onclick = "showAlert('PageCountErr','');";
  }
}

/**************************************************************************************************************
 * 名称: addOrderImg
 * 功能: 为displaytag表头加排序的图片
 * 输入: 无
 * 输出: 无
 * 返回: 
 *************************************************************************************************************/
Tools.prototype.addOrderImg = function (){
	
	var pathname = window.location.pathname;
	// 处理模式窗口上下文
	var start = 1;
	if(pathname.substring(0,1)!="/")
	{
		start = 0;
	}
	var context= pathname.substring(start,pathname.indexOf("/",1));
	// 默认排序
	var sortable = document.getElementsByName("sortable");
	for(var i=0;i<sortable.length;i++)
	{
		
		if(sortable[i].getElementsByTagName("img")[0]==undefined)
		{
			var sortableA = sortable[i].getElementsByTagName("a");
			sortableA[0].innerHTML	= sortableA[0].innerHTML + "&nbsp;<img src='/" + context + "/images/px.gif' border='0'>";
		}
	}
	// 正序
	sortable = document.getElementsByName("sortable sorted order1");
	for(var i=0;i<sortable.length;i++)
	{
		if(sortable[i].getElementsByTagName("img")[0]==undefined)
		{
			var sortableA = sortable[i].getElementsByTagName("a");
			sortableA[0].innerHTML	= sortableA[0].innerHTML + "&nbsp;<img src='/" + context + "/images/st-paixu-dq.gif' border='0'>";
		}
	}
	// 倒序
	sortable = document.getElementsByName("sortable sorted order2");
	for(var i=0;i<sortable.length;i++)
	{
		if(sortable[i].getElementsByTagName("img")[0]==undefined)
		{
			var sortableA = sortable[i].getElementsByTagName("a");
			sortableA[0].innerHTML	= sortableA[0].innerHTML + "&nbsp;<img src='/" + context + "/images/st-paixu-xia.gif' border='0'>";
		}
	}
}
window.attachEvent("onload",new Tools().addOrderImg);