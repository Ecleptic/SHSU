package TreePackage;
/**
   An interface for the ADT general tree.
   
   @author Charles Hoot
   @version 4.0
*/
public interface GeneralTreeInterface<T> extends TreeInterface<T>,
                                                 TreeIteratorInterface<T>
{
    /** Sets an existing general tree to a new one-node tree.
        @param rootData  An object that is the data in the root of
                         the new tree. */
    public void setTree(T rootData);
    
    /** Sets an existing general tree to a new general tree.
        @param rootData  An object that is the data in the root of
                         the new tree.
        @param children  An array of subtrees of the root. */
    public void setTree(T rootData, GeneralTreeInterface<T>[] children);
} // end GeneralTreeInterface