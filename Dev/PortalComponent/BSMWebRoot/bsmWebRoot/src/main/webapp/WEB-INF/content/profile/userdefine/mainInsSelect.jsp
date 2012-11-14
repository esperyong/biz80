<!-- content/profile/userdefine/mainInsSelect.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ include file="/WEB-INF/common/taglibs.jsp" %>
<div id="resourceInstanceSelect">
<!--<fieldset class="blue-border" style="width:630px;">-->
<!--<legend>选择${basicInfo.resourceType}</legend>-->
<br/>
<div style="padding: 5px;">
<div class="select-lr" >			
							<div class="left-n" style="width: 280px;height: 400px;" id="prAddins">
							<div style="height: 20px;vertical-align: top;margin-bottom: 5px;">可选设备: <s:radio list="resInsSelect.stateRaidos" name="stateRaidos" listKey="key" listValue="value"/></div>
							<div class="panel-gray">
							<div class="panel-gray-top">
								<table id="resInsDiv" width="100%"><thead>
									<th width="8%"><input type="checkbox" id="ChooseResInsAll" /></th>
									<th width="36%">显示名称</th>
									<th width="32%">IP地址</th>
									<th width="1%">&nbsp;</th>
									<th width="23%">当前策略</th>
								</thead></table></div>
							  <div class="gray-border" style="overflow: scroll;height: 350px;" id="left_resIns">
								<s:iterator value="resInsSelect.leftResIns" id="ins">
								<table state="${ins.state}" canMove="${ins.canMove}"><tbody><tr>
								<td width="8%">
									<input type="checkbox" name="resInsSelect.leftResIns.instanceId"  value="<s:property value="#ins.instanceId"/>" <s:if test="#ins.canMove != 'true'">disabled</s:if>/>
								
								</td>
								<td width="38%">
									<div style="width: 90px; text-overflow: ellipsis; overflow: hidden;">
									<nobr>
										<s:if test="#ins.state"><s:text name="1in18.profile.instance.monitor"/></s:if>
										<s:else><s:text name="1in18.profile.instance.unmonitor"/></s:else>
										<span class="insName"><s:property value="#ins.instanceName"/></span></nobr></div></td>
								<td width="34%"><s:property value="#ins.ip"/></td>
									<td width="1%">&nbsp;</td>
								<td width="19%"><div style="width: 50px; text-overflow: ellipsis; overflow: hidden;" title="<s:property value="#ins.profileName"/>"><nobr><s:property value="#ins.profileName"/></nobr></div></td></tr></tbody></table>
								</s:iterator>
							  </div>
							</div></div>
							<div class="middle" >
								<span class="turn-right" id="resins-turn-right"></span>
								<span class="turn-left" id="resins-turn-left"></span>
							</div>
							<div class="right-n" style="width:280px;height: 400px;">
							<div style="height: 20px;vertical-align: top;margin-bottom: 5px;line-height:20px;">使用当前监控策略的设备：</div>
							<div class="panel-gray">
							<div class="panel-gray-top">
								<table id="resInsDiv" width="100%"><thead>
								<th width="8%"><input type="checkbox" id="ChooseResInsMine" /></th>
								<th width="30%" >显示名称</th>
								<th width="42%">IP地址</th>
								<th width="1%">&nbsp;</th>
								<th width="19%" style="display: none;">当前策略</th>
								</thead></table></div>
								<div class="gray-border" style="overflow: scroll;height: 350px;" id="right_resIns">
								<s:iterator value="resInsSelect.rightResIns" id="insMine">
								<table canMove="${insMine.canMove}"><tbody><tr>
								<td width="8%"><input type="checkbox" name="resInsSelect.instanceIds"  value="<s:property value="#insMine.instanceId"/>" /> </td>
								<td width="38%" >
										<div style="width: 90px; text-overflow: ellipsis; overflow: hidden;"><nobr>
										<s:if test="#insMine.state"><s:text name="1in18.profile.instance.monitor"/></s:if>
										<s:else><s:text name="1in18.profile.instance.unmonitor"/></s:else>
										<span class="insName"><s:property value="#insMine.instanceName"/></span></nobr></div></td>
								<td width="34%"><s:property value="#insMine.ip"/></td>
								<td width="1%">&nbsp;</td>
								<td width="19%" ><div style="width: 50px; text-overflow: ellipsis; overflow: hidden;display: none;" title="<s:property value="#insMine.profileName"/>"><nobr><s:property value="#insMine.profileName"/></nobr></div></td></tr></tbody></table>
								</tr></tbody></table>
								</s:iterator>
							</div>
							  </div>
							</div>
						</div>
<!--</fieldset>-->
</div>
</div>