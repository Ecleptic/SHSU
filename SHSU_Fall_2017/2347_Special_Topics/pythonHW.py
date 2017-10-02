def getInputs():
    loanCost = int(input("what is the monthly cost for loan payments? \n"))
    insuranceCost = int(input("what is the monthly cost for insurance? \n"))
    gasCost = int(input("what is the monthly cost for gas \n"))
    oilCost = int(input("what is the monthly cost for oil \n"))
    tireCost = int(input("what is the monthly cost for tires \n"))
    maintenanceCost = int(input("what is the monthly cost for maintainence \n"))
    return loanCost , insuranceCost ,  gasCost , oilCost , tireCost , maintenanceCost

def doMath(loanCost , insuranceCost ,  gasCost , oilCost , tireCost , maintenanceCost):
    monthlyTotal = loanCost + insuranceCost +  gasCost + oilCost + tireCost + maintenanceCost
    annualTotal = monthlyTotal * 12
    return monthlyTotal, annualTotal

def main():
    loanCost , insuranceCost ,  gasCost , oilCost , tireCost , maintenanceCost = getInputs()
    monthlyTotal, annualTotal = doMath(loanCost , insuranceCost ,  gasCost , oilCost , tireCost , maintenanceCost)

    print ("Monthly Cost is: %i" % (monthlyTotal))
    print("Annual cost is: %i" % annualTotal)


main()