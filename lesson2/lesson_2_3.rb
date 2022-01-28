#lesson 2.3

arr = [0, 1]
num1 = 0
num2 = 1
while (num1 + num2) < 100 
  current_num = num1 + num2
  arr.push(current_num)
  num1, num2 = num2, current_num
end
print arr