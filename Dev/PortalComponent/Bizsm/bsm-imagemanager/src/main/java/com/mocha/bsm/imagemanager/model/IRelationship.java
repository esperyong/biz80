package com.mocha.bsm.imagemanager.model;

public interface IRelationship
{
    /**
     * Returns the unique id of this relationship. Ids are garbage collected
     * over time so they are only guaranteed to be unique during a specific time
     * span: if the relationship is deleted, it's likely that a new relationship
     * at some point will get the old id. This makes relationship ids brittle as
     * public APIs.
     *
     * @return the id of this node
     */
    public String getId();
    
    /**
     * Returns the start node of this relationship. For a definition of how
     * start node relates to {@link Direction directions} as arguments to the
     * {@link Node#getRelationships() relationship accessors} in Node, see the
     * class documentation of Relationship.
     *
     * @return the start node of this relationship
     */
    public Image getImage();

    /**
     * Returns the end node of this relationship. For a definition of how end
     * node relates to {@link Direction directions} as arguments to the
     * {@link Node#getRelationships() relationship accessors} in Node, see the
     * class documentation of Relationship.
     *
     * @return the end node of this relationship
     */
    public String getObjectId();

    /**
     * Returns the type of this relationship. A relationship's type is an
     * immutable attribute that is specified at Relationship
     * {@link Node#createRelationshipTo creation}. Remember that relationship
     * types are semantically equivalent if their
     * {@link RelationshipType#name() names} are {@link Object#equals(Object)
     * equal}. This is NOT the same as checking for identity equality using the
     * == operator. If you want to know whether this relationship is of a
     * certain type, use the {@link #isType(RelationshipType) isType()}
     * operation.
     *
     * @return the type of this relationship
     */
    public RelationshipType getType();

    /**
     * Indicates whether this relationship is of the type <code>type</code>.
     * This is a convenience method that checks for equality using the contract
     * specified by RelationshipType, i.e. by checking for equal
     * {@link RelationshipType#name() names}.
     *
     * @param type the type to check
     * @return <code>true</code> if this relationship is of the type
     *         <code>type</code>, <code>false</code> otherwise or if
     *         <code>null</code>
     */
    public boolean isType( RelationshipType type );
}
