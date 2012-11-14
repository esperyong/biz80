
<%@ page language="java" pageEncoding="UTF-8"%>
<%@page
	import="com.mocha.bsm.resource.respository.factory.RespositoryObjectFactory"%>
<%@page import="com.mocha.bsm.service.proxy.ServiceProxy"%>
<%@page
	import="com.mocha.bsm.resource.respository.ResourceInstanceRespository"%>
<%@page
	import="com.mocha.bsm.resource.respository.instance.obj.ExtendProp"%>
<%@page import="com.mocha.bsm.location.enums.LocationTypeEnum"%>
<%@page import="java.util.List"%>
<%@page import="com.mocha.bsm.location.impl.service.LocationEquipRelationService"%>
<%@page import="com.mocha.bsm.location.api.service.ILocationEquipRelationService"%>
<%
/**
RespositoryObjectFactory t_resFactory = (RespositoryObjectFactory) ServiceProxy
			.getService(RespositoryObjectFactory.class);
	ResourceInstanceRespository t_resService = t_resFactory
			.instanceofRespository();

	String instanceid = "5CA62B4E2C345D7BEF77ECF9C83BF33B";
	String LocationType = "location_office";//LocationTypeEnum.LOCATION_FLOOR.getKey();

	List<ExtendProp> list = t_resService.getResourceInstanceById(
			instanceid).getExtendProps();
	out.println("当前资源id为" + instanceid + "<br>");
	out.println("当前输出的属性key为： " + LocationType + "<br>");
	out.println("根据资源id 获取资源实例后再获取资源的扩展属性列表如下：" + "<br>");
	for (ExtendProp l : list) {
		out.println("l.getPropKey()=" + l.getPropKey() + "<br>");
	}
	out.println("直接根据资源实例id及属性key获取结果为" + "<br>");
	ExtendProp extendProp = t_resService.getExtendProp(instanceid,
			LocationType);
	if (extendProp != null) {
		out.println("extendProp.getId()=" + extendProp.getId()+ "<br>");
		out.println("extendProp.getPropKey()="+ extendProp.getPropKey() + "<br>");
		out.println("extendProp.getResourceInstanceId()="+ extendProp.getResourceInstanceId() + "<br>");
		out.println("extendProp.getValues()="+ extendProp.getValues()[0] + "<br>");
	} else {
		out.println("extendProp is =" + extendProp + "<br>");
	}
	**/
	ILocationEquipRelationService ilers= (ILocationEquipRelationService)ServiceProxy.getService(ILocationEquipRelationService.class);
	
	ilers.getAllInstance();
	
%>