var GridPanel = function(){
  function innerGridPanel(conf,mvc){
    mvc = mvc ? mvc :{};
    $.extend(conf,mvc);
    this.init(conf,{domStru:mvc.gridpanel_DomStruFn ? mvc.gridpanel_DomStruFn  : "default_gridpanel_DomStruFn",
                    domCtrl:mvc.gridpanel_DomCtrlFn ? mvc.gridpanel_DomCtrlFn : "defatul_gridpanel_DomCtrlFn",
                    compFn:mvc.gridpanel_ComponetFn ? mvc.gridpanel_ComponetFn : "default_gridpanel_ComponetFn"
                  });  
  }
  CFNC.registDomStruFn("default_gridpanel_DomStruFn",default_gridpanel_DomStruFn);
  CFNC.registDomCtrlFn("defatul_gridpanel_DomCtrlFn",defatul_gridpanel_DomCtrlFn);
  CFNC.registComponetFn("default_gridpanel_ComponetFn",default_gridpanel_ComponetFn);
  
  
  return innerGridPanel;
}();


/**
 * 定义组件DOM结构
 * $gridpanel      表格最外层DIV
 * $gridhead       表格头Tr
 * heads           表头列集合{index:i,$head：thJQuery对象，#headtext:表头文字}
 * $gridbodycage   表体外层DIV,用于显示滚动条
 * $gridbody       表体tBody对象
 * rows            表格行集合[[{index:列索引,$td:$td,value:单元格的只,html:单元格显示的文字或HTML}]]
 * 
 * addHead()       添加表头列
 */

function default_gridpanel_DomStruFn(conf){
  var temp = this;
  
  temp.$gridpanel = $("#"+conf.id);
  temp.$gridhead = $(temp.$gridpanel.children("div:eq(0)").children("table").children("thead").children("tr:first"));//表头最外层
  
  //初始化表头
  temp.heads = [];//{}
  var ths = temp.$gridhead.children("th");//表头列s
  for(var i=0;i<ths.length;i++){
      var $th = $(ths[i]);
      var $head = $($th.children("div:first").children("div:first"));
      var $headtext = $($head.children("span:first"));
      temp.heads.push({index:i,$th:$th,$head:$head,$headtext:$headtext});
  }

  
  //表体外层DIV
  temp.$gridbodycage = $(temp.$gridpanel.children("div:eq(1)"));
  //初始化表体 
  temp.$gridbody = $(temp.$gridbodycage.children("table").children("tbody"));
  //表体行
  temp.rows = [];
  var trs = temp.$gridbody.children("tr");
  for(var i=0;i<trs.length;i++){
    var row = [];
    var tds = $(trs[i]).children("td");
    for(var j=0;j<tds.length;j++){
      var $td = $(tds[j]);
      row.push({rowIndex:i,index:j,$td:$td,value:$td.attr("value"),html:$td.text()});
    }
    temp.rows.push(row);
  }
  
  
  
  /**
   * 添加表头列
   */
  temp.addHead = function(conf){
    var $th = $('<th></th>');
    var $div = $("<div></div>");
    if(conf.text){
      var $text = $("<span></span>")
    }
    $th.append($div);
    temp.addAttr($th,conf.attrs);
    temp.heads.push({$thead:$th});
    temp.$gridhead.append($th);    
  }
  //删除表头列
  temp.delHead = function(index,len){
    var $delcols = temp.heads.splice(index,len);
    for(var i=0;i<$delcols.length;i++){
        var $dc = $delcols[i];
        $dc.$thead.unbind();
        $dc.$thead.find("*").unbind();
        temp.$gridhead[0].removeChild($dc.$thead[0]); 
    }
  }
  /**
   * 添加单元格
   */
  temp.addCell = function(index,tdconf){
    var $td =  $('<td><span>'+tdconf.text+'</span></td>');
    temp.setWidth($td,conf.columnWidth[index]);
  }
  
  /**
   * 添加行
   */
  temp.addRow = function(tdConf){
     var $tr = $('<tr></tr>');
     var row = [];
     for(var j=0; j < tdConf.length;j++){
         var td = tdConf[j];             
         var $td =  $('<td><span>'+td.text+'</span></td>');
         temp.setWidth($td,conf.columnWidth[j]);
         $tr.append($td);
         row.push({index:j,$td:$td,value:td.value,html:td.text});
     }
     temp.rows.push(row);
     return $tr;    
  }
  
}




/**
 *定义组件DOM操作，初始化DOM样式
 * 初始化参数：
 * conf.columnWidth  
 * addAttr()    为DOM元素添加属性
 * columnWidth{index:width}
 */
function defatul_gridpanel_DomCtrlFn(conf){
    var temp = this;
    
    
    
    //为DOM元素添加属性
    temp.addAttr = function($obj,attr){
       for(var key in attr){
         $obj.attr(key,attr[key]);
       }
    }
    
    //更改列宽
    temp.setWidth = function($obj,width){
        $obj.css("width",width+"px");
    }
    
    
    /**
     * 设定表格宽度
     * width:num
     */
    temp.setTableWidth = function(width){
       temp.setWidth(temp.$gridpanel,width)
    }
    
    //定义列宽
    temp.setColumWidth = function(columnWidth){
        columnWidth = columnWidth ? columnWidth : conf.columnWidth;
        for(var key in conf.columnWidth){
            temp.setWidth(temp.heads[key].$th,conf.columnWidth[key]);
            for(var i=0;i<temp.rows.length;i++){
                 temp.setWidth(temp.rows[i][key].$td,conf.columnWidth[key]);
            }     
        }
    }
    temp.overLine = function(){
    	temp.$gridbody.find("tr").bind("mouseover",function(){
    		$(this).addClass("blue");
    	}).bind("mouseout",function(){
    		$(this).removeClass("blue");
    	});
    };
    
    temp.setTableWidth(conf.width);
    temp.setColumWidth();
    temp.overLine();
}



/**
 * 组件功能定义
 * checkOverFlow()          判断组件是否需要显示滚动条，更改标题列位置
 * rend()                   单元格内部渲染
 * loadGridData()           加载表格数据
 */
function default_gridpanel_ComponetFn(conf){
  var temp = this;
  //检测表格是否出现滚动条
  temp.checkOverFlow = function(){
      var gbcage = temp.$gridbodycage[0];
      var clientHeight = parseInt(gbcage.clientHeight);
      var scrollHeight = parseInt(gbcage.scrollHeight);    
      if(clientHeight < scrollHeight){  //容器高度小于实际高度
              var offsetWidth  = parseInt(gbcage.offsetWidth); 
              var borderLeftWidth  = parseInt(gbcage.style.borderLeftWidth); 
              var borderRightWidth  = parseInt(gbcage.style.borderRightWidth); 
              var clientWidth  = parseInt(gbcage.clientWidth);
              offsetWidth = isNaN(offsetWidth) ? 0 :offsetWidth;
              borderLeftWidth = isNaN(borderLeftWidth) ? 0 :borderLeftWidth;
              borderRightWidth = isNaN(borderRightWidth) ? 0 :borderRightWidth;
              clientWidth = isNaN(clientWidth) ? 0 :clientWidth;
              var scroll =  offsetWidth-borderLeftWidth-borderRightWidth-clientWidth;
              temp.addHead({attrs:{width:scroll+"px",spacefn:"space"}});                        
      }else{
              
              var $space = temp.heads[temp.heads.length-1];
              if($space.$thead && $space.$thead.attr("spacefn")==="space"){ //最后一个表头列是占位符，没滚动条，删除表头的占位
                temp.delHead(temp.heads.length-1,1);
              }
      }
  }
  
  
  /**
   * 单元格内部渲染
   * rendConf  {index:列索引，fn:渲染函数（$td）}
   */
  temp.rend = function(rendConf){
    temp.rendConf = rendConf ? rendConf : temp.rendConf;
    for(var i=0;i<temp.rendConf.length;i++){
        var rc = temp.rendConf[i];
        for(var j=0;j<temp.rows.length;j++){
            var row = temp.rows[j];
            var cell = row[rc.index];
            var $dom = rc.fn(cell);
            cell.$td.find("*").unbind().empty().append($dom);
        }
    }
  }
  /**
   *根据行号获得某行 
   * */
  temp.getRowByIndex = function(rowIndex){
	  return temp.rows[rowIndex]; 
  };
  
  /**
   * 表格加载数据
   * [[{value:,text:}]]
   */
  temp.loadGridData = function(data){
       var jsondata = (new Function("return " + data))();
       temp.rows= [];
       var $row = null;
       temp.$gridbody.find("*").unbind();
       temp.$gridbody.empty();
      for(var i=0;i<jsondata.length;i++){
          var jd = jsondata[i];
          var $tr = temp.addRow(jd);
          temp.$gridbody.append($tr);
      }
      temp.checkOverFlow();
      temp.rend();
      temp.overLine();
  }
  
  temp.checkOverFlow();
}


$.apply(GridPanel,Componet);


/*
 * 排序插件
 * conf{sortColumns:[{index:num列索引,sortord:string排序类别,defSorttype:bool默认排序列方式}]排序列集合,sortLisntenr:fn排序回调函数}
 */
function SortPlugin(conf){
  var temp = this;
  var scs =  conf.sortColumns;
  var $sorts = {};
  temp.currentSort = null;  //当前排序的按钮
  for(var i=0;i<conf.sortColumns.length;i++){
    var sc = scs[i];
    var $headdiv = temp.heads[sc.index];
    var sortord = sc.sortord;
    var $upa = $('<a  href="#" style="display:none" title="升序" class="theadbar-ico theadbar-ico-up"></a>')
        .attr("sortord",sortord).attr("sorttype","up").bind("click",bindSortEvent);
    var $downa = $('<a  href="#" style="display:none" title="降序" class="theadbar-ico theadbar-ico-down"></a>')
        .attr("sortord",sortord).attr("sorttype","down").bind("click",bindSortEvent);
    
    if(sc.defSorttype==="up"){
      temp.currentSort=$upa;
      $upa.css("display","block");
    }else if(sc.defSorttype==="down"){
      temp.currentSort=$downa;
      $downa.css("display","block");
    }    
    
    $headdiv.$head.append($upa).append($downa).parent().bind({"mouseover":bindMouseOver,"mouseout":bindMouseOut});
  }
  
  
  
  
  //绑定排序事件
  function bindSortEvent(){
    var $a =$(this);
    temp.currentSort.css("display","none");
    temp.currentSort=$a;
    temp.currentSort.css("display","block");
    conf.sortLisntenr($a);
  }
  
  //绑定表头列鼠标悬浮显示排序按钮
  function bindMouseOver(){
    $(this).css("cursor","pointer").find("a").css("display","block");
  }
  function bindMouseOut(){
    var sortAs = $(this).find("a");
    for(var i=0;i<sortAs.length;i++){
      var $sortA = $(sortAs[i]);
      if(temp.currentSort[0]!=$sortA[0]){
        $sortA.css("display","none");
      }
    }
  }

  
  
  
}
