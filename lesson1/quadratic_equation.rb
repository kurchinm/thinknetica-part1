puts "a?"
a = gets.to_f
puts "b?"
b = gets.to_f
puts "c?"
c = gets.to_f
D = b**2 - 4 * a * c
if D > 0
  puts D
  x1 = ( - b + D**0.5) / (2 * a)
  x2 = ( - b - D**0.5) / (2 * a)
  puts "roots are #{x1} #{x2}"
elsif D==0
  puts D
  x = - b / (2 * a)
  puts "root is #{x}"
else
  puts D
  puts "no roots"
end
    