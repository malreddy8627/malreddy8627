#list is an indexed container that holds heterogeneous elements
list1 = [10, 30, 20, 40, 60, 70]
print type(list1)
print list1

#create a list with elements in the range of 1 to 10 with step size of 1
###that means it will give us list of 9 (it should be < 10, 10th value excluded) elements and each element will increase by 1 by using range()
list2 = range(1,10,1)
print list2
print type(list2)

list3 = range(1,10,5) ### it will give the value of <10 0nly 10th value excluded
print list3
print type(list12)

#sliced or sub-setting of list access to elements 
list1[0]
list1[-1] # 1st elemnet from end
list1[0:2]### 2 nd elemnet will be excluded
list1[0:]
list1[:3]
list1[0::2] #### it is retrieving the element incremnet by 2
list1[0] = 100
list1[0]     

#modifying the contents of list
list3 = []
print list3
list3.append(10)
list3.append(20)
list3.insert(3,70)
list3.append(True)
list3.append(list1)
print list3
#sort the elements of list1
list1.sort()
print list1

len(list1)

#iterate through the list elements
for x in list1:
    print x

#### checking missing values
list4 = [10, 30, 20, 40, 60, 70, None]
import numpy as np
## a = [1, np.nan, 2, 3]
### np.nanmean(a)
##2.0
## np.nansum(a)
##6.0
#np.isnan(list4)
##array([False,  True, False, False], dtype=bool)