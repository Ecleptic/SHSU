tuplex = (4,6,2,8,3,1)
print (tuplex)          #(4, 6, 2, 8, 3, 1)

tuplex = tuplex + (9,)
print(tuplex)           #(4, 6, 2, 8, 3, 1, 9)

tuplex = tuplex[:5] + (15,20,25) + tuplex[:5]
print(tuplex)           #(4, 6, 2, 8, 3, 15, 20, 25, 4, 6, 2, 8, 3)

listx = list(tuplex)

listx.append(30)
tuplex = tuple(listx)
print(tuplex)           #(4, 6, 2, 8, 3, 15, 20, 25, 4, 6, 2, 8, 3, 30)