<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<%@ include file="/WEB-INF/common/meta.jsp" %>
<!-- 监控数量阈值定义 -->
<s:set id="MONITOR_WARNING" value="50000"/>
<s:set id="MONITOR_CRITICAL" value="70000"/>
<!-- VM使用率阈值定义 -->
<s:set id="USAGERATE_WARNING" value="90.00"/>
<s:set id="USAGERATE_CRITICAL" value="95.00"/>

<div class="panel-gray clear">
	<div class="panel-gray-top txt-center" style="text-align: center;">
		<span class="panel-gray-title">系统自检报告${occurDate }</span>
	</div>
	<div class="panel-gray-content">
		<s:iterator id="list" value="result">
			<p class="bold margin3"><s:property value="#list.title"/>
				<%-- s:if test="#list.avail_state == @com.mocha.bsm.systemnode.diagnose.obj.State@red.toString()">
					<span class="red">异常</span>
				</s:if>--%>：
			</p>
			<div class="grayborder margin3">
				<ul class="fieldlist-n">
					<!-- 可用性 -->
					<s:if test="#list.avail_state == @com.mocha.bsm.systemnode.diagnose.obj.State@green.toString()">
					<li><span class="field-middle">可用性</span><span class="lamp lamp-green-ncursor"/></li>
					</s:if>
					<s:if test="#list.avail_state == @com.mocha.bsm.systemnode.diagnose.obj.State@red.toString()">
					<li><span class="field-middle">可用性</span><span class="lamp lamp-red-ncursor"/> &nbsp;&nbsp;&nbsp;&nbsp;建议：请检查组件服务是否启动。</li>
					</s:if>
					<s:if test="#list.avail_state == @com.mocha.bsm.systemnode.diagnose.obj.State@gray.toString()">
					<li><span class="field-middle">可用性</span><span class="lamp lamp-gray-ncursor"/> &nbsp;&nbsp;&nbsp;&nbsp;建议：请检查网络连接是否正常，或Agent服务是否启动。</li>
					</s:if>
					<!-- 监控负载 -->
					<s:if test="#list.monitor_count != null">
						<li>
							<span class="field-middle">监控负载</span><s:if test="#list.monitor_count > #MONITOR_WARNING and #list.monitor_count < #MONITOR_CRITICAL "><span class="lamp lamp-yellow-ncursor"></span>
							</s:if><s:if test="#list.monitor_count > #MONITOR_CRITICAL"><span class="lamp lamp-red-ncursor"></span>
							</s:if><s:if test="#list.monitor_count < #MONITOR_WARNING"><span class="lamp lamp-green-ncursor"></span>
							</s:if>
							<span class="suojin1em">监控指标数量：<s:property value="#list.monitor_count" /></span>
							<s:if test="#list.monitor_count > #MONITOR_WARNING and #list.monitor_count < #MONITOR_CRITICAL "><span>(>黄色阈值5万监控指标)</span>
							</s:if><s:if test="#list.monitor_count > #MONITOR_CRITICAL"><span>(>红色阈值7万监控指标)</span>
							</s:if><s:if test="#list.monitor_count < #MONITOR_WARNING">
							</s:if>
						</li>
						<s:if test="#list.monitor_count > #MONITOR_WARNING and #list.monitor_count < #MONITOR_CRITICAL ">
							<li><span class="suojin1em">监控负载将要达到系统极限，可能出现取值延时、告警延时等情况，请减少监控资源个数或减少监控指标数量。</span></li>
						</s:if>
						<s:if test="#list.monitor_count > #MONITOR_CRITICAL">
							<li><span class="suojin1em">监控负载已超过系统极限，可能出现取值延时、告警延时等情况，请减少监控资源个数或减少监控指标数量。</span></li>
						</s:if>
						<s:if test="#list.monitor_count < #MONITOR_WARNING">
						</s:if>
					</s:if>
					<s:if test="#list.jvm_rate != null">
						<li>
							<span class="field-middle">JVM使用率</span><s:if test="#list.jvm_rate > #USAGERATE_WARNING and #list.jvm_rate < #USAGERATE_CRITICAL "><span class="lamp lamp-yellow-ncursor"></span>
							</s:if><s:if test="#list.jvm_rate > #USAGERATE_CRITICAL"><span class="lamp lamp-red-ncursor"></span>
							</s:if><s:if test="#list.jvm_rate < #USAGERATE_WARNING"><span class="lamp lamp-green-ncursor"></span>
							</s:if>
							<span class="suojin1em">当前值：</span><s:property value="#list.jvm_rate"/>%<span class="suojin1em">已使用：</span><s:property value="#list.jvm_used"/>MB
							<s:if test="#list.jvm_rate > #USAGERATE_WARNING and #list.jvm_rate < #USAGERATE_CRITICAL "><span>(>黄色阈值90%)</span>
							</s:if><s:if test="#list.jvm_rate > #USAGERATE_CRITICAL"><span>(>红色阈值95%)</span>
							</s:if><s:if test="#list.jvm_rate < #USAGERATE_WARNING">
							</s:if>
						</li>
						<s:if test="#list.jvm_rate > #USAGERATE_WARNING and #list.jvm_rate < #USAGERATE_CRITICAL ">
						</s:if>
						<s:if test="#list.jvm_rate > #USAGERATE_CRITICAL">
							<li><span class="suojin1em">JVM使用率较大，请减少监控资源个数或减少监控指标降低JVM使用率。</span></li>
						</s:if>
						<s:if test="#list.jvm_rate < #USAGERATE_WARNING">
						</s:if>
					</s:if>
					
				</ul>
			</div>
		</s:iterator>
	</div>
</div>