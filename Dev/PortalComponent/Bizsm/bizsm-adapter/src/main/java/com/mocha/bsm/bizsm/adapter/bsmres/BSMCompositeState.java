package com.mocha.bsm.bizsm.adapter.bsmres;
import com.thoughtworks.xstream.annotations.XStreamAlias;
import com.thoughtworks.xstream.annotations.XStreamConverter;
import com.thoughtworks.xstream.converters.enums.EnumConverter;

@XStreamAlias("BSMCompositeState")
public class BSMCompositeState {
	
	@XStreamAlias("availState")
	@XStreamConverter(EnumConverter.class)	
	private BSMAvailState availState;
	
	@XStreamAlias("perfState")
	@XStreamConverter(EnumConverter.class)
	private BSMPerfState perfState;
	
	public BSMCompositeState(){
		this.availState = BSMAvailState.AVAILUNKNOWN;
		this.perfState = BSMPerfState.PERFUNKNOWN;
	}
	
	public BSMCompositeState(BSMAvailState availState,BSMPerfState perfState){
		this.availState = availState;
		this.perfState = perfState;		
	}
	
	public BSMAvailState getAvailState() {
		return availState;
	}
	public void setAvailState(BSMAvailState availState) {
		this.availState = availState;
	}
	public BSMPerfState getPerfState() {
		return perfState;
	}
	public void setPerfState(BSMPerfState perfState) {
		this.perfState = perfState;
	}
	
	public boolean equals(Object anObject) {
    	if (this == anObject) {
    	    return true;
    	}
    	if (anObject instanceof BSMCompositeState) {
    		BSMCompositeState anotherResource = (BSMCompositeState)anObject;
    	    if(anotherResource.getAvailState().equals(this.availState) 
    	    		&& anotherResource.getPerfState().equals(this.perfState)){
    	    	return true;	
    	    }
    		
    	}
    	return false;
    }
    
    public int hashCode(){
    	return this.availState.hashCode() * this.perfState.hashCode();
    }	
	
}
