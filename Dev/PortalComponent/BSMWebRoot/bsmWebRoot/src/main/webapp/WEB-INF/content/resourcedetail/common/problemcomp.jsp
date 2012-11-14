<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<style type="text/css">
  span.elli-name{width:100px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal;word-break:normal;display:block;}
  span.elli-throld{width:40px;text-overflow:ellipsis;white-space:nowrap;overflow:hidden;word-spacing:normal;word-break:normal;display:block;}
</style>
  <s:set var="availKey" value="%{@com.mocha.bsm.detail.util.Constants@AVAILABILITY_METRIC}" />
  <s:set var="performKey" value="%{@com.mocha.bsm.detail.util.Constants@PERFORMANCE_METRIC}" />
  <s:set var="configKey" value="%{@com.mocha.bsm.detail.util.Constants@CONFIGURATION_METRIC}" />
  <s:if test="problemComp[#availKey]==null && problemComp[#performKey]==null && problemComp[#configKey]==null">
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
  <s:if test="problemComp[#availKey]!=null">
  <div style="width:96%;">
    <p class="rightct-h1"><span class="ico ico-minus" divID="availMetic"></span><span class="txt-white"><s:text name="detail.availmetric" /></span></p>
    <div id="availMetic">
    <div class="business-grid02-topbottom"></div>
    <div class="business-grid02-mid">
      <table class="business-grid02-grid">
        <tr>
          <th width="40%"><s:text name="detail.metricname" /></th>
          <th width="30%"><s:text name="detail.confirmstatus" /></th>
          <th width="30%"><s:text name="detail.typical.coltime" /></th>
        </tr>
        <s:iterator value="problemComp[#availKey]" var="metricBean">
          <tr class="business-grid02-tr-02">
            <td><s:property value="#metricBean.metricName" default="-" /></td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
            <td><s:property value="#metricBean.collectTime" default="-" /></td>
          </tr>
        </s:iterator>
      </table>
    </div>
    <div class="business-grid02-topbottom"></div>
    </div>
  </div>
  </s:if>
  <s:if test="problemComp[#performKey]!=null">
  <div style="width:96%;">
    <p class="rightct-h1"><span class="ico ico-minus" divID="performMetic"></span><span class="txt-white"><s:text name="detail.performmetric" /></span></p>
    <div id="performMetic">
    <div class="business-grid02-topbottom"></div>
    <div class="business-grid02-mid">
      <table class="business-grid02-grid" id="performTab">
        <tr>
          <th width="8%"><s:text name="detail.metricname" /></th>
          <th width="15%"><s:text name="detail.confirmstatus" /></th>
          <th width="15%"><span class="lamp lamp-lingyellow" style="cursor:default;"></span><s:text name="detail.threshold" /></th>
          <th width="15%"><span class="lamp lamp-lingred" style="cursor:default;"></span><s:text name="detail.threshold" /></th>
          <th width="13%"><s:text name="detail.currentvalue1" /></th>
          <th width="29%"><s:text name="detail.typical.coltime" /></th>
        </tr>
        <s:iterator value="problemComp[#performKey]" var="metricBean" status="idx">
          <tr class="<s:if test="#idx.isEven()">business-grid02-tr-02</s:if> <s:if test="#idx.getIndex()==0">business-grid02-tr-on</s:if>" metricId="<s:property value="#metricBean.metricId" />" metricName="<s:property value="#metricBean.metricName" />">
            <td>
             <span class="elli-name" title="<s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>">
               <s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>
             </span>
            </td>
            <td style="text-align:center;"><span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
            <td>
              <span class="elli-throld" title="<s:property value="#metricBean.yellowValue" default="-" /><s:if test="#metricBean.yellowValue!=null && #metricBean.yellowValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
               <s:property value="#metricBean.yellowValue" default="-" /><s:if test="#metricBean.yellowValue!=null && #metricBean.yellowValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
              </span>
            </td>
            <td>
              <span class="elli-throld" title="<s:property value="#metricBean.redValue" default="-" /><s:if test="#metricBean.redValue!=null && #metricBean.redValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
                <s:property value="#metricBean.redValue" default="-" /><s:if test="#metricBean.redValue!=null && #metricBean.redValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
              </span>
            </td>
            <td>
              <span class="elli-throld" title="<s:property value="#metricBean.currentValue" default="-" /><s:if test="#metricBean.currentValue!=null && #metricBean.currentValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>">
                <s:property value="#metricBean.currentValue" default="-" /><s:if test="#metricBean.currentValue!=null && #metricBean.currentValue!=''"><s:property value="#metricBean.unit" default="" /></s:if>
              </span>
            </td>
            <td><s:property value="#metricBean.collectTime" default="-" /></td>
          </tr>
        </s:iterator>
      </table>
    </div>
    <div class="business-grid02-topbottom"></div>
    <!-- 下部为汇总数据图表 
    <div class="separated10"></div>
    <div style="height:284px;overflow:hidden;">
	    <div class="business-grid02-topbottom"></div>
	    <div class="business-grid02-mid">
        <div class="business-grid02-title underline-gray margin5"><span class="right vertical-middle">单位：秒</span><span id="metricDesc"></span></div>
        <div class="margin5" id="toolsdiv">
          <span class="ico ico-eyes right" id="eyes"></span>
          <span class="ico ico-pdf right" id="pdf"></span>
          <span class="ico ico-excel02 right" id="execl"></span>
          <span class="ico ico-clock right" id="clock"></span>
          <span name="freqDiv" id="365h" class="data-l right"><span class="data-r"><span class="data-m">365d</span></span></span>
          <span name="freqDiv" id="30d" class="data-l right"><span class="data-r"><span class="data-m">30d</span></span></span>
          <span name="freqDiv" id="14d" class="data-l right"><span class="data-r"><span class="data-m">14d</span></span></span>
          <span name="freqDiv" id="7d" class="data-l right"><span class="data-r"><span class="data-m">7d</span></span></span>
          <span name="freqDiv" id="1h" class="data-on-l right"><span class="data-r"><span class="data-m">1h</span></span></span>
          <div class="clear"></div>
        </div>
        <div class="margin5" style="height:220px;overflow:hidden;margin:0;padding:0;">
          <img id="summarizemd" src="${ctx}/detail/summarized.action?instanceId=${instanceId}&metricId=${metricId}&freq=1h" complete="complete" width="465" height="220"/>
        </div>
        <div></div>
	    </div>
	    <div class="business-grid02-topbottom"></div>
    </div>
          下部为汇总数据图表 -->
    </div>
  </div>
  </s:if>
  <s:if test="problemComp[#configKey]!=null">
  <div style="width:96%;">
    <p class="rightct-h1"><span class="ico ico-minus" divID="cinfigMetic"></span><span class="txt-white"><s:text name="detail.configmetric" /></span></p>
    <div id="cinfigMetic">
	    <div class="business-grid02-topbottom"></div>
	    <div class="business-grid02-mid">
      <table class="business-grid02-grid">
        <tr>
          <th width="30%"><s:text name="detail.metricname" /></th>
          <th width="15%"><s:text name="detail.confirmstatus" /></th>
          <th width="20%"><s:text name="detail.currentvalue1" /></th>
          <th width="30%"><s:text name="detail.typical.coltime" /></th>
        </tr>
        <s:iterator value="problemComp[#configKey]" var="metricBean">
          <tr class="business-grid02-tr-02">
            <td>
              <span class="elli-name" title="<s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>">
                <s:property value="#metricBean.metricName" default="-" /><s:if test="#metricBean.unit!=null && #metricBean.unit!=''">(<s:property value="#metricBean.unit" default="" />)</s:if>
              </span>
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;<span class="<s:property value="#metricBean.state" default="lamp lamp-linggrey" />" style="cursor:default;"></span></td>
            <td>
              <span class="elli-throld" title="<s:property value="#metricBean.currentValue" default="-" />">
                <s:property value="#metricBean.currentValue" default="-" />
              </span>
            </td>
            <td><s:property value="#metricBean.collectTime" default="-" /></td>
          </tr>
        </s:iterator>
      </table>
	    </div>
	    <div class="business-grid02-topbottom"></div>
    </div>
  </div>
  </s:if>
  </s:else>

<script type="text/javascript">
	$(function(){
	  $("p.rightct-h1 span.ico").bind("click",function(){
	    var $span = $(this);
	    var classVal = $span.attr("class");
	    var divID = $span.attr("divID");
	    if(classVal.indexOf("ico-minus") != -1){
	      $span.attr("class","ico ico-plus");
	      $("#"+divID).hide();
	    }else{
	      $span.attr("class","ico ico-minus");
	      $("#"+divID).show();
	    }
	  });
	  
	  //性能指标单击事件
	  $("#performTab tr").slice(1).bind("click",function(){
	    $("#performTab tr").attr("class","business-grid02-tr-02");
	    var $tr = $(this);
	    //$tr.attr("class","business-grid02-tr-02 business-grid02-tr-on");
	    var metricId = $tr.attr("metricId");
	    var metricName = $tr.attr("metricName");
	    $("#metricDesc").html(metricName);
		});
	  // 点击汇总频度按钮
	  $("#toolsdiv span[name=freqDiv]").bind("click",function(){
	    $("#toolsdiv span[name=freqDiv]").attr("class","data-l right");
	    $(this).attr("class","data-on-l right");
	    $("#summarizemd").get(0).src="${ctx}/detail/summarized.action?instanceId=${instanceId}&metricId=${metricId}&freq=" + this.id;
	  });
    //默认选中第一行
    $("#performTab tr").eq(1).click();
	});
</script>

