// ********************************************************
// Reference-based implementation of the ADT Sorted List.
// *********************************************************
/**
 * class SortedListReferenceBased
 *
 *    A class that implements the SortedListInterface using a linked list
 *
 */

public class SortedListReferenceBased extends ListReferenceBased
{

public SortedListReferenceBased()
// creates an empty list
{
								super();
}     // end default constructor


public void add(String item) throws ListException
// Inserts item into its proper position in a sorted list
// Throws an exception if the item connot be placed on the list
{
								try
								{
																this.add(locateIndexToAdd(item), item);
								}
								catch(Exception e)
								{
																throw new ListException("Add to List failed:  " + e.toString());
								}

}


public void remove(String item) throws ListException
// Removes the item from a sorted list.
// Throws an exception if the item is not found.
{
								try
								{
																if(locateIndexToRemove(item) != -1)
																{
																								this.remove(locateIndexToRemove(item));
																}
								}
								catch(Exception e)
								{
																throw new ListException("Remove " + item.toString() + " from List failed:  " + e.toString());
								}
}

public int locateIndexToAdd(String item)
// Returns the position where the item belongs or exists in a sorted list;
// item and the list are unchanged.
{
								for(int i = 0; i < this.size(); i++)
								{
																if (this.get(i).toString().compareTo(item.toString()) >= 0)
																{
																								return i;
																}
								}
								return this.size();
}

public int locateIndexToRemove(String item)
// Returns the position where the item belongs or exists in a sorted list;
// item and the list are unchanged.
{
								for (int i = 0; i < this.size(); i++)
								{
																if(this.get(i).equals(item))
																{
																								return i;
																}
								}
								return -1;
}

}  // end SortedListReferenceBased
