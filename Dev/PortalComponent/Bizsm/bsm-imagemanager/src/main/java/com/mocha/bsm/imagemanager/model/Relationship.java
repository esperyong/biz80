/**
 * 
 */
package com.mocha.bsm.imagemanager.model;

/**
 * 用来表示一个关联
 * Image<-->Object的关联
 * @author liuyong
 */
public class Relationship implements IRelationship {
	
	private String id;
	
	private Image image;
	
	private String objectId;
	
	private RelationshipType type;
	public Relationship(){
		
	}
	public Relationship(String id,Image image,String objId,RelationshipType type){
		this.id = id;
		this.image = image;
		this.objectId = objId;
		this.type = type;
	}
	
	public void setId(String id) {
		this.id = id;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.model.IRelationship#getId()
	 */
	public String getId() {
		
		return this.id;
	}

	
	
	public void setImage(Image image) {
		this.image = image;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.model.IRelationship#getImage()
	 */
	public Image getImage() {
		return this.image;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.model.IRelationship#getObject()
	 */
	public String getObjectId() {
		return this.objectId;
	}

	
	
	public void setObjectId(String objectId) {
		this.objectId = objectId;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.model.IRelationship#getType()
	 */
	public RelationshipType getType() {
		return this.type;
	}
	
	public void setType(RelationshipType type){
		this.type = type;
	}

	/* 
	 * @see com.mocha.bsm.imagemanager.model.IRelationship#isType(com.mocha.bsm.imagemanager.model.RelationshipType)
	 */
	public boolean isType(RelationshipType type) {
		return this.type.equals(type);
	}

}
