/**
 * 
 */
package com.mocha.bsm.imagemanager.model;

/**
 * A relationship type is mandatory on all relationships and is used to navigate
 * the node space. RelationshipType is in particular a key part of the
 * {@link Traverser traverser framework} but it's also used in various
 * {@link Node#getRelationships() relationship operations} on Node.
 * <p>
 * Relationship types are declared by the client and can be handled either
 * dynamically or statically in a Neo4j-based application. Internally,
 * relationship types are dynamic. This means that every time a client invokes
 * {@link Node#createRelationshipTo(Node,RelationshipType)
 * node.createRelationshipTo(anotherNode, newRelType)} and passes in a new
 * relationship type then the new type will be transparently created. So
 * instantiating a RelationshipType instance will not create it in the
 * underlying storage, it is persisted only when the first relationship of that
 * type is created.
 * <p>
 * However, in case the application does not need to dynamically create
 * relationship types (most don't), then it's nice to have the compile-time
 * benefits of a static set of relationship types. Fortunately, RelationshipType
 * is designed to work well with Java 5 enums. This means that it's very easy to
 * define a set of valid relationship types by declaring an enum that implements
 * RelationshipType and then reuse that across the application. For example,
 * here's how you would define an enum to hold all your relationship types:
 * 
 * <pre>
 * <code>
 * enum MyRelationshipTypes implements {@link RelationshipType}
 * {
 *     CONTAINED_IN, KNOWS
 * }
 * </code>
 * </pre>
 * 
 * Then later, it's as easy to use as:
 * 
 * <pre>
 * <code>
 * node.{@link Node#createRelationshipTo(Node, RelationshipType) createRelationshipTo}( anotherNode, {@link RelationshipType MyRelationshipTypes.KNOWS} );
 * for ( {@link Relationship} rel : node.{@link Node#getRelationships(RelationshipType...) getRelationships}( MyRelationshipTypes.KNOWS ) )
 * {
 * 	// ...
 * }
 * </code>
 * </pre>
 * 
 * <p>
 * It's very important to note that a relationship type is uniquely identified
 * by its name, not by any particular instance that implements this interface.
 * This means that the proper way to check if two relationship types are equal
 * is by invoking <code>equals()</code> on their {@link #name names}, NOT by
 * using Java's identity operator (<code>==</code>) or <code>equals()</code> on
 * the relationship type instances. A consequence of this is that you can NOT
 * use relationship types in hashed collections such as
 * {@link java.util.HashMap HashMap} and {@link java.util.HashSet HashSet}.
 * <p>
 * However, you usually want to check whether a specific relationship
 * <i>instance</i> is of a certain type. That is best achieved with the
 * {@link Relationship#isType Relationship.isType} method, such as: <code><pre>
 * if ( rel.isType( MyRelationshipTypes.CONTAINED_IN ) )
 * {
 *     ...
 * }
 * </pre></code>
 */
public interface RelationshipType
{
    /**
     * Returns the name of the relationship type. The name uniquely identifies a
     * relationship type, i.e. two different RelationshipType instances with
     * different object identifiers (and possibly even different classes) are
     * semantically equivalent if they have {@link String#equals(Object) equal}
     * names.
     * 
     * @return the name of the relationship type
     */
    public String name();
}
