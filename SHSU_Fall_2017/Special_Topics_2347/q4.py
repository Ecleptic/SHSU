num = input("num?")
unallowedchars = ["g","h","i"] # etc.....
valid = True

for i in num:
    for j in unallowedchars:
        if (i.lower() == j):
            print("invalid characters")
            valid = False



if(valid):
    j=len(num)
    for i in num:
        if(i.lower() == 'a'):
            i = 10
        elif(i.lower() == b):
            i = 11
        elif(i.lower() == 'c'):
            i = 12
        
        val = (16**j * i)       
    
