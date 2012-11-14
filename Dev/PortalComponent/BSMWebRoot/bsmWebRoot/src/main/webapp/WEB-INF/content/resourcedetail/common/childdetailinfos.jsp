<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli{width:100%;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal; word-break:normal;display:block;line-height:24px;}
</style>
  <!-- start -->
  <s:if test="childInfos==null || childInfos.size()==0">
  <div class="grid-gray" style="height:450px;">
    <div class="formcontent" style="height:450px;">
      <table style="height:450px;">
        <tbody>
          <tr>
           <td class="nodata vertical-middle">
             <span class="nodata-l">
                <span class="nodata-r">
                  <span class="nodata-m"> <span class="icon"><s:text name="i18n.nodata" /></span> </span>
                </span>
              </span>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
  </s:if>
  <s:else>
  <s:iterator value="childInfos" var="tmpList" status="idx">
    <s:if test="#idx.isFirst()">
      <s:set var="tmpData" value="value['metrics']" />
      <s:set var="displayProfile" value="value['displayProfile']" />
      <s:set var="displayDesc" value="value['displayDesc']" />
    </s:if>
  </s:iterator>
  <div style="overflow-x:auto;overflow-y:hidden;height:470px;">
  <div class="business-grid02">
    <div class="business-grid02-mid">
      <table class="business-grid02-grid" id="detailinfotab">
        <thead>
        <tr>
          <th style="width:15px;"><span id="customCol" class="ico-21 ico-21-setting" title="<s:text name="detail.custom.column" />"></span></th>
          <th><nobr><s:property value="childResourceName" /><s:text name="detail.name" />&nbsp;&nbsp;</nobr></th>
          <s:iterator value="#tmpData" var="m">
            <th style=""><span class="elli" title="<s:property value="#m.metricName" />"><s:property value="#m.metricName" />&nbsp;&nbsp;</span></th>
          </s:iterator>
          <s:if test="#displayProfile!=null">
            <th style=""><nobr><s:text name="detail.info.strategy" />&nbsp;&nbsp;</nobr></th>
          </s:if>
          <s:if test="#displayDesc!=null">
            <th style=""><nobr><s:text name="detail.info.remark" />&nbsp;&nbsp;</nobr></th>
          </s:if>
        </tr>
        </thead>
        <tbody id="sumtab">
        <s:iterator value="childInfos" var="rowMap" status="idx">
          <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if>">
            <td colspan="2">
              <span class="elli">&nbsp;&nbsp;
              <span class="<s:property value="value['childState']" />" style="cursor:default;"></span>
              <span name="childInst" id="<s:property value="value['child'].id" />" title="<s:property value="value['child'].name" default="-" />" style="cursor:pointer;">
               <s:property value="value['child'].name" default="-" />
              </span>
              </span>
            </td>
            <s:iterator value="value['metrics']" var="mb">
            <td>
            <s:if test="#mb.isMonitored() == false">
              <span class="ico ico-stop" style="cursor:default;" title="<s:text name="detail.nonmonitor" />"></span>
            </s:if>
            <s:else>
              <s:if test="#mb.getMetricType()==0"><!-- 属性 -->
                <span class="elli" title="<s:text name="detail.currentvalue" /><s:if test="#mb.getCurrentValue()!=null"><s:property value="#mb.getCurrentValue()" default="-" /><s:property value="#mb.getUnit()" /></s:if><s:else>-</s:else>">
              </s:if>
	            <s:elseif test="#mb.getMetricType()==1"><!-- 可用性指标 -->
	              <span class="elli" style='color:<s:property value="#mb.getValueColor()" />;' title="<s:text name="detail.nearest.coltime" /><s:property value="#mb.getCollectTime()" default="-" />">
	            </s:elseif>
	            <s:else>
	              <span class="elli" style='color:<s:property value="#mb.getValueColor()" />;' title="<s:text name="detail.currentvalue" /><s:if test="#mb.getCurrentValue()!=null"><s:property value="#mb.getCurrentValue()" default="-" /><s:property value="#mb.getUnit()" /></s:if><s:else>-</s:else><s:property value="'\r\n'" /><s:text name="detail.nearest.coltime" /><s:property value="#mb.getCollectTime()" default="-" />">
	            </s:else>
               <s:if test="#mb.getMetricType()==0 || #mb.getMetricType()==3 || #mb.getMetricType()==4"><!-- 属性，信息或者性能指标 -->
                 <s:if test="#mb.getCurrentValue()!=null"><s:property value="#mb.getCurrentValue()" default="-" /><s:property value="#mb.getUnit()" /></s:if><s:else>-</s:else>
               </s:if>
               <s:else>
                 &nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#mb.getState()" default="lamp lamp-linggrey" />" style="cursor:default;"></span>
               </s:else>
             </span>
             </s:else>
            </td>
            </s:iterator>
            <s:if test="#displayProfile!=null">
              <td><span class="elli" title="<s:property value="value['profile']" default="-" />"><s:property value="value['profile']" default="-" /></span></td>
            </s:if>
            <s:if test="#displayDesc!=null">
              <td><span class="elli" title="<s:property value="value['desc']" default="-" />"><s:property value="value['desc']" default="-" /></span></td>
            </s:if>
          </tr>
        </s:iterator>
        <s:set var="P_SIZE" value="%{@com.mocha.bsm.detail.business.ChildDetailMgr@PAGE_SIZE}" />
        <s:if test="childInfos.size() < #P_SIZE">
          <s:bean name="org.apache.struts2.util.Counter" id="counter">
            <s:param name="first" value="childInfos.size()" />
            <s:param name="last" value="#P_SIZE - 1" />
            <s:iterator>
              <tr class="<s:if test="current%2==0">business-grid02-tr-02</s:if>">
	              <td>&nbsp;</td>
	              <td>&nbsp;</td>
	              <s:iterator value="#tmpData">
	                <td>&nbsp;</td>
	              </s:iterator>
	              <s:if test="#displayProfile!=null">
	                <td>&nbsp;</td>
	              </s:if>
	              <s:if test="#displayDesc!=null">
	                <td>&nbsp;</td>
	              </s:if>
	              </tr>
            </s:iterator>
          </s:bean>
        </s:if>
        </tbody>
    </table>
    </div>
    <div id="pageid" style="position:absolute;width:685px;"></div><!-- 分页组件 -->
  </div>
  </div>
  </s:else>
  <!-- end -->
<script type="text/javascript">
//创建分页对象
var page = new Pagination({
  applyId : "pageid",
  listeners : {
    pageClick : function(page) {
      //page为跳转到的页数 
      $.blockUI({message:$('#loading')});
      var url = ctxpath + "/detail/childdetail!detailinfos.action";
      $.loadPage("childDiv",url,"POST",{parentInstanceId:"${parentInstanceId}",childResourceId:"${childResourceId}",currentPage:page}); 
    }
  }
});
page.pageing(${pageCount}, ${currentPage});
$.unblockUI();
$("#detailinfotab span[name=childInst]").bind("click",function(){
  var url =  ctxpath + "/detail/childinstancedetail.action?childInstanceId=" + this.id;
  winOpen({url:url,width:710,height:550,name:'childinstancedetailWin'});
});
$("#customCol").bind("click",function(){
  var url = ctxpath + "/detail/childdetail!columnCustom.action?parentInstanceId=${parentInstanceId}&childResourceId=${childResourceId}";
  var offset = $(this).offset();
  selectPanel = new winPanel({
         id:"selectColumnPanel",
         isautoclose:true,
         isDrag:false,
         width:250,//必须给宽度，否则上部会缺一部分
         x:offset.left,
         y:offset.top+20,
         url:url
     },{
    winpanel_DomStruFn:"blackLayer_winpanel_DomStruFn"
  });
});
</script>
