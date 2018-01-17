import random

lines = 1000
outfile = open('Salary.txt',"a")

jobs = ["Assistant","Associate","Full"]


for i in range(lines):
    num = random.randint(0,2)
    job = jobs[num]
    pay = int
    if(num == 0):
        pay = random.randint(50000,80000)
        paydec=random.randint(00,99)
    if(num == 1):
        pay = random.randint(60000,110000)
        paydec=random.randint(00,99)
    if(num == 2):
        pay = random.randint(750000,130000)
        paydec=random.randint(00,99)
    
    print("FirstName"+str(i)+"\t"+"LastName"+str(i)+"\t"+ str(job) +"\t"+str(pay)+str(paydec))  




