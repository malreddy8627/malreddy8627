#python is dynamically typed language. the type of the variable is 
#inferred based on the value assigned to a variable at that time

#int type
x = 15
print x
print type(x) ###type is equalent to the class in R

#float type
y = 15.6
print y
print type(y)

#bool type T should be capital
z = True
print type(z)

#complex type real value like 2, 3,4  and imaginary like 2i, 7h
c = 2  + 1j
print type(c)

#check the object type against target type
isinstance(x,int) 

#cast float to int like sub-string like retrieving the part of float data
c1 = int(y)
print c1

#cast complext to int which is invalid
c2 = int(c)
print c2
#None is special value in python
p3 = None
print type(p3)
print p3

###define the string
st = "hi"
print st
print type(st) 