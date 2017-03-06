#tuple: immutable list, here we can not modify the tuple , is it fixed or constant or pure imutable

tuple1 = (10, 20, 30, 40, 50)
type(tuple1)
tuple1[0]
tuple1[-2]
tuple1[0:3]
tuple1[2] = 100 #### here it will give error coz we can not update tuple value

for x in tuple1:
    print x ** 2