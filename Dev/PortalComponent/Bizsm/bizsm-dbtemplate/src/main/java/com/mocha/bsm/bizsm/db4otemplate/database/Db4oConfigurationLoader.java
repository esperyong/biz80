package com.mocha.bsm.bizsm.db4otemplate.database;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.configuration.Configuration;
import org.apache.commons.configuration.ConfigurationException;
import org.apache.commons.configuration.XMLConfiguration;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.io.Resource;

import com.db4o.config.CommonConfiguration;
import com.db4o.config.EmbeddedConfiguration;
import com.db4o.config.FileConfiguration;
import com.db4o.config.QueryEvaluationMode;
import com.mocha.bsm.bizsm.db4otemplate.exception.DBConfigFileException;

public class Db4oConfigurationLoader implements IDb4oConfigurationLoader {
	
	/**
	 * Log Instance.
	 */
	private Log log = LogFactory.getLog(Db4oConfigurationLoader.class);
	
	private Resource[] resources;
	
	
	public Resource[] getResources() {
		return this.resources;
	}
	
	/**
	 * Injected
	 * @param resource
	 */
	public void setResources(Resource[] resources) {
		this.resources = resources;
	}
	
	/**
	 * @param path 所有配置的根路径
	 */
	public Db4oConfigurationLoader(){
		
	}
	
	/* (non-Javadoc)
	 * @see com.mocha.bsm.bizsm.db4otemplate.database.IDb4oConfigurationLoader#loadDbConfig(com.db4o.config.EmbeddedConfiguration)
	 */
	public void loadDbConfig(EmbeddedConfiguration dbConfig){
		try {
			Configuration[] configs = this.loadConfiguration();
			this.loadDbCommonConfig(dbConfig.common(), configs);
			this.loadDbFileConfig(dbConfig.file(), configs);
		} catch (DBConfigFileException e) {
			log.error(e);
		}
	}
	
	/**
	 * 
	 * @param dbCommonConfig
	 * @param configs
	 */
	protected void loadDbCommonConfig(CommonConfiguration dbCommonConfig,Configuration[] configs){
		log.info(" Begin of db4o Common Configuration");
		for (int i = 0; i < configs.length; i++) {
			this.loadDbCommonConfig(dbCommonConfig, configs[i]);
		}
		log.info(" End of db4o Common Configuration");		
	}

	/**
	 * 
	 * @param dbFileConfig
	 * @param configs
	 */
	protected void loadDbFileConfig(FileConfiguration dbFileConfig,Configuration[] configs){
		log.info("Begin of db4o File Configuration");
		for (int i = 0; i < configs.length; i++) {
			this.loadDbFileConfig(dbFileConfig, configs[i]);
		}
		log.info("End of db4o File Configuration");
	}	
	
	/**
	 * 在一个配置文件中加载db4o的FileConfiguration
	 * @param dbFileConfig
	 * @param config
	 */
	protected void loadDbFileConfig(FileConfiguration dbFileConfig,Configuration config){
		
		String blockSizeIndex = "file-config.blockSize";
		
		if(config.containsKey(blockSizeIndex)){
			int blockSize = config.getInt("file-config.blockSize");
			dbFileConfig.blockSize(blockSize);
			log.info("Set DbFile blockSize to :" + blockSize);
		}
		
	}

	/**
	 * 设置数据库Common配置
	 * @param path
	 * @return
	 */
	protected void loadDbCommonConfig(CommonConfiguration dbCommonConfig,Configuration config){
		    
			String globalEvaluationModeKey = "common-config.global.evaluationMode";
			if(config.containsKey(globalEvaluationModeKey)){
				//LAZY,IMMEDIATE,SNAPSHOT
				String globalEvaluationMode = config.getString(globalEvaluationModeKey);
				if("IMMEDIATE".equals(globalEvaluationMode)){
					dbCommonConfig.queries().evaluationMode(QueryEvaluationMode.IMMEDIATE);
				}else if("SNAPSHOT".equals(globalEvaluationMode)){
					dbCommonConfig.queries().evaluationMode(QueryEvaluationMode.SNAPSHOT);
				}else{//LAZY
					dbCommonConfig.queries().evaluationMode(QueryEvaluationMode.LAZY);
				}
				log.info("Db4o global configuration queryEvaluationMode:"+globalEvaluationMode);
			}
			
			String globalActivationDepthKey = "common-config.global.activationDepth";
			if(config.containsKey(globalActivationDepthKey)){
				int globalActivationDepth = config.getInt(globalActivationDepthKey);
				dbCommonConfig.activationDepth(globalActivationDepth);
				log.info("Db4o global configuration globalActivationDepth:"+globalActivationDepth);
			}			
			
			this.configurateClasses(dbCommonConfig,config);
	}
	
	/**
	 * 配置Class相关的CommonConfiguration
	 * @param config
	 */
	protected void configurateClasses(CommonConfiguration dbCommonConfig,Configuration config){
		String classConfigsIndex = "common-config.object-classes.object-class[@name]";
		if(config.containsKey(classConfigsIndex)){
			List classConfigs = config.getList(classConfigsIndex);
			int commonClassConfigSize = classConfigs.size();
			for (int i = 0; i < commonClassConfigSize; i++) {
				String className = (String)classConfigs.get(i);
				this.configurateClass(dbCommonConfig,config, className, i);
			}			
		}
	}
	
	/**
	 * 配置某一个Class的数据库设置
	 * @param config
	 * @param className
	 * @param classIndex
	 */
	protected void configurateClass(CommonConfiguration dbCommonConfig,Configuration config,String className,int classIndex){
		
		//Class Configuration
		String cascadeOnUpdateKey = "common-config.object-classes.object-class(" + classIndex + ").cascadeOnUpdate";
		if(config.containsKey(cascadeOnUpdateKey)){
			boolean cascadeOnUpdate = config.getBoolean(cascadeOnUpdateKey);
			dbCommonConfig.objectClass(className).cascadeOnUpdate(cascadeOnUpdate);
			log.info(className+" Class cascadeOnUpdate:"+cascadeOnUpdate);			
		}
		String cascadeOnDeleteKey = "common-config.object-classes.object-class(" + classIndex + ").cascadeOnDelete";
		if(config.containsKey(cascadeOnDeleteKey)){
			boolean cascadeOnDelete = config.getBoolean(cascadeOnDeleteKey);
			dbCommonConfig.objectClass(className).cascadeOnDelete(cascadeOnDelete);
			log.info(className+" Class cascadeOnDelete:"+cascadeOnDelete);		
		}
		String maximumActivationDepthKey = "common-config.object-classes.object-class(" + classIndex + ").maximumActivationDepth";
		if(config.containsKey(maximumActivationDepthKey)){
			int maximumActivationDepth = config.getInt(maximumActivationDepthKey);
			dbCommonConfig.objectClass(className).maximumActivationDepth(maximumActivationDepth);
			log.info(className+" Class maximumActivationDepth:"+maximumActivationDepth);
		}
		//Class Properties Configuration
		this.configurateFields(dbCommonConfig,config,className,classIndex);
		
	}
	
	/**
	 * 配置某一个类型的Fields相关的CommonConfiguration
	 * @param config
	 */
	protected void configurateFields(CommonConfiguration dbCommonConfig,Configuration config,String className,int classIndex){
		String fieldConfigsIndex = "common-config.object-classes.object-class("+classIndex+").fields.field[@name]";
		if(config.containsKey(fieldConfigsIndex)){
			List fieldConfigs = config.getList(fieldConfigsIndex);
			int commonFieldConfigSize = fieldConfigs.size();
			for (int i = 0; i < commonFieldConfigSize; i++) {
				String fieldName = (String)fieldConfigs.get(i);
				this.configurateField(dbCommonConfig,config,className, fieldName,classIndex,i);
			}			
		}
	}	
	/**
	 * 配置某一个类型的Fields某一个Field相关的CommonConfiguration
	 * @param config
	 */	
	protected void configurateField(CommonConfiguration dbCommonConfig,Configuration config,String className,String fieldName,int classIndex,int fieldIndex){
		//Field configuration
		String indexedKey = "common-config.object-classes.object-class("+classIndex+").fields.field("+fieldIndex+").indexed";
		if(config.containsKey(indexedKey)){
			boolean indexed = config.getBoolean(indexedKey);
			dbCommonConfig.objectClass(className).objectField(fieldName).indexed(indexed);
			log.info("Class [" + className + "]'s property:["+fieldName+"] add indexed:"+indexed);
		}
		
		String cascadeOnUpdateKey = "common-config.object-classes.object-class("+classIndex+").fields.field("+fieldIndex+").cascadeOnUpdate";
		if(config.containsKey(cascadeOnUpdateKey)){
			boolean cascadeOnUpdate = config.getBoolean(cascadeOnUpdateKey);
			dbCommonConfig.objectClass(className).objectField(fieldName).cascadeOnUpdate(cascadeOnUpdate);
			log.info("Class [" + className + "]'s property:[" + fieldName + "] configurate cascadeOnUpdate:"+cascadeOnUpdate);
		}
		
		String cascadeOnDeleteKey = "common-config.object-classes.object-class("+classIndex+").fields.field("+fieldIndex+").cascadeOnDelete";
		if(config.containsKey(cascadeOnDeleteKey)){
			boolean cascadeOnDelete = config.getBoolean(cascadeOnDeleteKey);
			dbCommonConfig.objectClass(className).objectField(fieldName).cascadeOnDelete(cascadeOnDelete);
			log.info("Class [" + className + "]'s property:[" + fieldName + "] configurate cascadeOnDelete:"+cascadeOnDelete);
		}
		
	}
	

	
	/**
	 * 加载配置到Configuration中
	 * @return
	 */
	protected Configuration[] loadConfiguration() throws DBConfigFileException{
		List<Configuration> configs = new ArrayList<Configuration>();
		try{
			for (int i = 0; i < this.resources.length; i++) {
				if(this.resources[i].exists() && this.resources[i].isReadable()){
					configs.add(new XMLConfiguration(resources[i].getURL()));
				}
			}
		}
		catch(ConfigurationException cex){
			throw new DBConfigFileException("loadConfiguration Exception",cex);
		}
		catch(IOException ioe){
			throw new DBConfigFileException("loadConfiguration Exception",ioe);
		}		
		return (Configuration[])configs.toArray(new Configuration[0]);
	}
	
}
