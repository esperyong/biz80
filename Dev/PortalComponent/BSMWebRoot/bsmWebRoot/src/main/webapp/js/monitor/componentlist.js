
/**
 * 创建GridPanel对象
 * @param {} id 创建的GridPanel ID
 * @return {} config 构建GridPanel对象的参数，width：宽度，render：渲染数组，columnWidth：列宽
 */
var createGridPanel = function(id,config){
  var gp = new GridPanel({
            id : id,
            width : config.width,
            columnWidth : config.columnWidth
          }, {
            gridpanel_DomStruFn : "index_gridpanel_DomStruFn",
            gridpanel_DomCtrlFn : "index_gridpanel_DomCtrlFn",
            gridpanel_ComponetFn : "index_gridpanel_ComponetFn"
          });
  gp.rend(config.render);
  return gp;
}

/**
 * 创建分页对象
 * @param {} pageId 分页对象ID
 * @param {} url 分页传递的url地址
 * @param {} pageCount 总页数
 * @param {} gridPanel 关联的GridPanel对象
 * @return {} 分页对象 Pagination
 */
var createPagination = function(id,url,pageCount,gridPanel){
  var page = new Pagination({
            applyId : id,
            listeners : {
              pageClick : function(page) {
                //page为跳转到的页数 
                //var ajaxParam = $formObj.serialize()+"&currentPage="+page;
                $.ajax({
                  type: "POST",
                  dataType:'json',
                  url: url+"&currentPage="+page,
                  data: {},
                  success: function(data, textStatus){
                   // if(data.dataList){
                    //  var jsondata = (new Function("return " + data.dataList))();
                    //  var len = jsondata.length;
                    //  if( len > 0 ){
                         //var jd = jsondata[i][AllowMonitor];
                    //  }
                      gridPanel.loadGridData(data.dataList);
                    //}  
                  }
                });
              }
            }
          });
  page.pageing(pageCount, 1);
  return page;
}

/**
 * 创建AccordionPanel对象
 * @param {} id AccordionPanel ID
 * @return {} AccordionPanel Object
 */
var createAccordionPanel = function(id){
  var accordionPanel = new AccordionPanel({
        id : id
      }, {
        DomStruFn : "addsub_accordionpanel_DomStruFn",
        DomCtrlFn : "addsub_accordionpanel_DomCtrlFn"
      });
  return accordionPanel;
}

  