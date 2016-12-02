package TreePackage;
import java.util.Iterator;
import java.util.NoSuchElementException;
import StackAndQueuePackage.*;
/**
   This class implements a binary tree by using an array.
   A display method is defined for testing.
   
   Exercise 17 in Chapter 24 suggests that entries in the tree be assigned
   to locations in the array in a level-order fashion beginning at index 0 
   of the array. Gaps in the array correspond to missing nodes in the tree.

   The left child of the node at  a[i] is a[2 * i + 1].
   The right child of the node at a[i] is a[2 * i + 2].
   The parent of the node at a[i] is a[(i - 1) / 2].
   
   @author Charles Hoot 
   @version 4.0
*/
public class ArrayBinaryTree<T> implements BinaryTreeInterface<T>
{
    private T[] theData;
    private int height; // Of tree
    private int size;   // Number of locations in array for
    							// a full tree of this height
    
    public ArrayBinaryTree()
    {
        theData = null;
        height = 0;
        size = 0;
    } // end default constructor
    
    public ArrayBinaryTree(T rootData)
    {
        // The cast is safe because the new array contains null entries
        @SuppressWarnings("unchecked")
        T[] temp = (T[])new Object[1]; // Unchecked cast
        theData = temp;

        height = 1;
        size = 1;
        theData[0] = rootData;
    } // end constructor
    
    public ArrayBinaryTree(T rootData, ArrayBinaryTree<T> leftTree,
                                       ArrayBinaryTree<T> rightTree)
    {
        privateSetTree(rootData, leftTree, rightTree);
    } // end constructor

    public void setTree(T rootData)
    {
        privateSetTree(rootData, new ArrayBinaryTree<T>(), new ArrayBinaryTree<T>());
    } // end setTree

    public void setTree(T rootData, BinaryTreeInterface<T> leftTree,
                                    BinaryTreeInterface<T> rightTree)
    {
        if (leftTree == null)
            leftTree = new ArrayBinaryTree<T>();
        if (rightTree == null)
            rightTree = new ArrayBinaryTree<T>();
            
        privateSetTree(rootData, (ArrayBinaryTree<T>)leftTree,
                                 (ArrayBinaryTree<T>)rightTree);
    } // end setTree

    private void privateSetTree(T rootData, ArrayBinaryTree<T> leftTree,
                                            ArrayBinaryTree<T> rightTree)
    {
        height = 1 + Math.max(leftTree.height, rightTree.height);
        size = getSizeFromHeight(height);
        
        // The cast is safe because the new array contains null entries
        @SuppressWarnings("unchecked")
        T[] temp = (T[])new Object[size]; // Unchecked cast
        theData = temp;

        theData[0] = rootData;
        setLeftSubtree(leftTree);
        setRightSubtree(rightTree);
    } // end privateSetTree
    
	 // Finds the size of the array necessary to
    // fit a tree of height h.
    private int getSizeFromHeight(int h)
    {
        // size is 2^h - 1
        int result = 0;
        for (int i = 0; i < h; i++)
            result = 2 * result + 1;
            
        return result;
    } // end getSizeFromHeight
        
    // Copies the data values from the given subtree into the leftsubtree.
    // Precondition: The array is large enough to hold the new values.
    private void setLeftSubtree(ArrayBinaryTree<T> subTree)
    {
        int diff = 1;
        int index = 0;
        
        for (int i = 0; i < subTree.height; i++)
        {
            for (int nodeInLevel = 0; nodeInLevel < diff; nodeInLevel++)
            {
                theData[index + diff] = subTree.theData[index];
                index++;
            } // end
            diff *= 2;
        } // end for
    } // end setLeftSubtree
    
    // Copies the data values from the given subtree into the rightsubtree. 
    // Precondition: The array is large enough to hold the new values.
    private void setRightSubtree(ArrayBinaryTree<T> subTree)
    {
        int diff = 1;
        int index = 0;
        
        for (int i = 0; i < subTree.height; i++)
        {
            for (int nodeInLevel = 0; nodeInLevel < diff; nodeInLevel++)
            {
                theData[index + 2 * diff] = subTree.theData[index];
                index++;
            } // end
            diff *= 2;
        } // end for
    } // end setRightSubtree
    
    public T getRootData()
    {
        T rootData = null;
        if (theData != null)
            rootData = theData[0];
        return rootData;
    } // end getRootData
    
    public boolean isEmpty()
    {
        return theData == null;
    } // end isEmpty

    public void clear()
    {
        theData = null;
        height = 0;
        size = 0;
    } // end clear

    protected void setRootData(T rootData)
    {
        assert theData != null;
        theData[0] = rootData;
    } // end setRootData

    public int getHeight()
    {
        return getHeight(0);
    } // end getHeight
    
    private int getHeight(int root)
    {
        int result = 0;
        
        if (nodeExists(root))
        {
            int rightHeight = getHeight(getRightChild(root));
            int leftHeight = getHeight(getLeftChild(root));
            result = 1 + Math.max(leftHeight, rightHeight);
        } // end if
        return result;
    } // end getHeight
    
    public int getNumberOfNodes()
    {
        int result = 0;
        
        for (int i =  0; i < size; i++)
            if (theData[i] != null)
                result++;
        return result;
    } // end getNumberOfNodes
    
    // The following operations allow one to move in the tree and
    // to test whether a child exists.

    protected boolean hasLeftChild(int i)
    {
        return nodeExists(getLeftChild(i));
    } // end hasLeftChild
    
    protected int getLeftChild(int i)
    {
        return 2 * i + 1;
    } // end getLeftChild

    protected boolean hasRightChild(int i)
    {
        return nodeExists(getRightChild(i));
    } // end hasRightChild
    
    protected int getRightChild(int i)
    {
        return 2 * i + 2;
    } // end getRightChild
    
    protected boolean nodeExists(int i)
    {
        return (i >= 0 && i < size)  && (theData[i] != null);
    } // end nodeExists
    
    protected int getParent(int i)
    {
        return (i - 1) / 2;
    } // end getParent
    
    protected T getData(int i)
    {
        T result = null;
        
        if (nodeExists(i))
            result = theData[i];
        return result;
    } // end getData
    
    // The following operation allows one to set a node in the tree.... 
    // it is fairly dangerous.... we will require that if a node is set 
    // to non-null, its parent must either exist or be the root. 
    // (This requirement guarantees that we only have to extend by at
    // most one level.)
    protected void setNode(int i, T entry)
    {
        assert (entry == null) || (i == 0) || nodeExists(getParent(i));
        
        if ((entry == null) && (i < size))
        {
            theData[i] = null;
        }
        else 
        {
            if (i >= size)
                resizeArray();
            theData[i] = entry;
        } // end if
    } // end setNode
    
    private void resizeArray()
    {
        int newSize = getSizeFromHeight(height + 1);
        
        // The cast is safe because the new array contains null entries
        @SuppressWarnings("unchecked")
        T[] larger = (T[])new Object[newSize]; // Unchecked cast

        for (int i = 0; i < size; i++)
        {
            larger[i] = theData[i];
        } // end for
       
        theData = larger;
        height = height + 1;
        size = newSize;
    } // end resizeArray

    public Iterator<T> getInorderIterator()
    {
        return new InorderIterator();
    } // end getInorderIterator
    
    private class InorderIterator implements Iterator<T>
    {
        private StackInterface<Integer> nodeStack;
        private Integer currentNode;
        
        public InorderIterator()
        {
            nodeStack = new LinkedStack<Integer>();
            currentNode = 0;
        } // end default constructor
        
        public boolean hasNext()
        {
            return !nodeStack.isEmpty() || nodeExists(currentNode);
        } // end hasNext
        
        public T next()
        {
            Integer nextNode = -1;
            
            // Find leftmost node with no left child
            while (nodeExists(currentNode))
            {
                nodeStack.push(currentNode);
                currentNode = getLeftChild(currentNode);
            } // end while
                        
            // Get leftmost node, then move to its right subtree
            if (!nodeStack.isEmpty())
            {
                nextNode = nodeStack.pop();
                assert nodeExists(nextNode); // Since nodeStack was not empty before the pop
                currentNode = getRightChild(nextNode); // Right subchild
            }
            else
                throw new NoSuchElementException();
                
            return theData[nextNode];
        } // end next
        
        public void remove()
        {
            throw new UnsupportedOperationException();
        } // end remove
    } // end InorderIterator

    public Iterator<T> getPreorderIterator()
    {
        return new PreorderIterator();
    } // end getPreorderIterator
    
    private class PreorderIterator implements Iterator<T>
    {
        private StackInterface<Integer> nodeStack;
        
        public PreorderIterator()
        {
            nodeStack = new LinkedStack<Integer>();
            if (!isEmpty())
                nodeStack.push(0);
        } // end default constructor
        
        public boolean hasNext()
        {
            return !nodeStack.isEmpty();
        } // end hasNext
        
        public T next()
        {
            T result = null;
            if (nodeStack.isEmpty())
            {
                throw new NoSuchElementException();
            }
            else
            {
                Integer top = nodeStack.pop();
                result = theData[top];
                
                // Push the children on the stack: Right then left
                
                if (hasRightChild(top))  // Has right child
                    nodeStack.push(getRightChild(top));
                if (hasLeftChild(top))  // Has left child
                    nodeStack.push(getLeftChild(top));
            } // end if
           
            return result;
        } // end next
        
        public void remove()
        {
            throw new UnsupportedOperationException();
        } // end remove
    } // end PreorderIterator
    
    public Iterator<T> getPostorderIterator()
    {
        return new PostorderIterator();
    } // end getPostorderIterator
    
    private class PostorderIterator implements Iterator<T>
    {
        private StackInterface<PostOrderNode> nodeStack;
        
        public PostorderIterator()
        {
            nodeStack = new LinkedStack<PostOrderNode>();
            if (!isEmpty())
                nodeStack.push(new PostOrderNode(0, PostOrderState.LEFT));
        } // end default constructor
        
        public boolean hasNext()
        {
            return !nodeStack.isEmpty();
        } // end hasNext
        
        public T next()
        {
            T result = null;
            if (nodeStack.isEmpty())
            {
                throw new NoSuchElementException();
            }
            else
            {
                PostOrderNode top = nodeStack.pop();
                PostOrderState state = top.state;
                
                while (state != PostOrderState.TOP)
                {
                    if (state == PostOrderState.LEFT)
                    {
                        top.state = PostOrderState.RIGHT;
                        nodeStack.push(top);
                        
                        if (hasLeftChild(top.node))
                            nodeStack.push(new PostOrderNode(getLeftChild(top.node), PostOrderState.LEFT));
                    }
                    else
                    {
                        assert state == PostOrderState.RIGHT;
                        top.state = PostOrderState.TOP;
                        nodeStack.push(top);
                        
                        if (hasRightChild(top.node))
                            nodeStack.push(new PostOrderNode(getRightChild(top.node), PostOrderState.LEFT));
                    } // end if
                    top = nodeStack.pop();
                    state = top.state;
                } // end while
                result = theData[top.node];
            } // end if
           
            return result;
        } // end next
        
        public void remove()
        {
            throw new UnsupportedOperationException();
        } // end remove
    } // end PostorderIterator 
    
    private enum PostOrderState {TOP, LEFT, RIGHT};
    
    private class PostOrderNode
    {
        public Integer node;
        public PostOrderState state;
        
        PostOrderNode(Integer theNode, PostOrderState theState)
        {
            node = theNode;
            state = theState;
        } // end constructor
    } // end PostOrderNode
    
    public Iterator<T> getLevelOrderIterator()
    {
        return new LevelOrderIterator();
    } // end getLevelOrderIterator
    
    private class LevelOrderIterator implements Iterator<T>
    {
        private QueueInterface<Integer> nodeQueue;
         
        public LevelOrderIterator()
        {
            nodeQueue = new LinkedQueue<Integer>();
            if (!isEmpty())
                nodeQueue.enqueue(0);
        } // end default constructor
         
        public boolean hasNext() 
        {
            return !nodeQueue.isEmpty();
        } // end hasNext
         
        public T next()
        {
            Integer nextNode;
            if (hasNext())
            {
               nextNode = nodeQueue.dequeue();

               // add to queue in order of recursive calls
               if (hasLeftChild(nextNode))
                   nodeQueue.enqueue(getLeftChild(nextNode));
 
               if (hasRightChild(nextNode))
                   nodeQueue.enqueue(getRightChild(nextNode));
            }
            else
            {
               throw new NoSuchElementException();
            } // end if
         
            return getData(nextNode);
        } // end next
        
        public void remove()
        {
            throw new UnsupportedOperationException();
        } // end remove
    } // end LevelOrderIterator
    
    // For testing.
    public void display()
    {
        for (int i = 0; i < size; i++)
        {
            if (nodeExists(i))
                System.out.println("index: " + i + " has " + getData(i));
        } // end for
    } // end display
} // end
    

