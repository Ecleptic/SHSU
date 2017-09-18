total = 0
loop = True
while (loop == True):
    num = float(input("Number?? "))
    if num >= 0:
        total += num
    else:
        loop = False

print(total)
