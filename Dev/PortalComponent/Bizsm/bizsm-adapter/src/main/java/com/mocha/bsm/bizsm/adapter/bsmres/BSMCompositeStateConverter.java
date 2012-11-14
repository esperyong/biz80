package com.mocha.bsm.bizsm.adapter.bsmres;
import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

public class BSMCompositeStateConverter implements Converter {

    public boolean canConvert(Class clazz) {
            return clazz.equals(BSMCompositeState.class);
    }

    public void marshal(Object value, HierarchicalStreamWriter writer,
                    MarshallingContext context) {
    		BSMCompositeState state = (BSMCompositeState) value;
            writer.startNode("availState");
            writer.setValue(state.getAvailState().toString());
            writer.endNode();
            writer.startNode("perfState");
            writer.setValue(state.getPerfState().toString());
            writer.endNode();
    }

    public Object unmarshal(HierarchicalStreamReader reader,
                    UnmarshallingContext context) {
    		BSMCompositeState state = new BSMCompositeState();
            while (reader.hasMoreChildren()) {
                reader.moveDown();
                if ("availState".equals(reader.getNodeName())) {
                	state.setAvailState(BSMAvailState.valueOf(reader.getValue()));
                } else if ("perfState".equals(reader.getNodeName())) {
                    state.setPerfState(BSMPerfState.valueOf(reader.getValue()));
                }
                reader.moveUp();
            }
            return state;
    }

}

