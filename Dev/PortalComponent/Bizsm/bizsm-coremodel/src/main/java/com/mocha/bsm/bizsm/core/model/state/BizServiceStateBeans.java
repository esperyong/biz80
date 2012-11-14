package com.mocha.bsm.bizsm.core.model.state;

import java.util.ArrayList;
import java.util.List;
import com.mocha.bsm.bizsm.core.model.BizService;
import com.mocha.bsm.bizsm.core.model.BizServices;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;


@XStreamAlias("BizServices")
public class BizServiceStateBeans {
	
	@XStreamConverter(com.thoughtworks.xstream.converters.collections.CollectionConverter.class)
	@XStreamAlias("services")
	private List<BizServiceStateBean> serviceBeans;	
	
	public BizServiceStateBeans(BizServices services){
		this.serviceBeans = new ArrayList<BizServiceStateBean>();
		if(services.getServices()!=null){
			for (BizService service:services.getServices()) {
				this.serviceBeans.add(new BizServiceStateBean(service));
			}
		}
	}
}
