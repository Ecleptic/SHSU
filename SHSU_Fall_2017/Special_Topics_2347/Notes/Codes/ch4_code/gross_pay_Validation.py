# This program displays gross pay.
# Get the number of hours worked.
hours = int(input('Enter the hours worked this week: '))
while hours>50 or hours<1:
     print("Error Input: ")
     hours = int(input('Enter the hours worked this week: '))
# Get the hourly pay rate.
pay_rate = float(input('Enter the hourly pay rate: '))
#Validate Input
  

# Calculate the gross pay.
gross_pay = hours * pay_rate

# Display the gross pay.
print('Gross pay: $', format(gross_pay, ',.2f'))

