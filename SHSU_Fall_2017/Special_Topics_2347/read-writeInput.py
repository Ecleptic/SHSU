def main():
    numDays = int(input('for how many days do you have sales?'))

    sales_file = open('salesMain.txt', 'w')

    for count in range(1, numDays + 1):
        sales = float(input('Enter the sales for day # ' + str(count) + ': '))
        sales_file.write(str(sales) + '\n')

    sales_file.close()
    print("written to file")


def other():
    sales_file = open('salesOther.txt', 'w')
    sales = float(input('Enter the sales for day # ' + str(count) + ': '))
    while sales != -1:
        count += 1
        sales_file.write(str(sales) + '\n')
        sales = float(input('Enter the sales for day # ' + str(count) + ': '))

    sales_file.close()
    print("written to file")


