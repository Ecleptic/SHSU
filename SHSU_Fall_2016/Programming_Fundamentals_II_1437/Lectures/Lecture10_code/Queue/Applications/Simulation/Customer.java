// immutable class
public class Customer
{
  private int arrivalTime;
  private int serviceTime;
  private int customerNumber;
  
  public Customer(int arrivalTime, int serviceTime, int customerNumber)
  {
    this.arrivalTime = arrivalTime;
    this.serviceTime = serviceTime;
    this.customerNumber = customerNumber;
  } // end constructor
  
  public int getArrivalTime()
  {
    return arrivalTime;
  } // end getArrivalTime
  
  public int getTransactionTime()
  {
    return serviceTime;
  } // end getServiceTime
  
  public int getCustomerNumber()
  {
    return customerNumber;
  } // end getCustomerNumber
} // end Customer