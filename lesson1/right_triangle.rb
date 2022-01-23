def check_right(a,b,c)
	hyp=a
	cat1=b
	cat2=c
	if b>hyp
		hyp=b
		cat1=a
		cat2=c
	end
	if c>hyp
		hyp=c
		cat1=a
		cat2=b
	end
	if (hyp**2)==(cat1**2+cat2**2)
		puts "Right triangle"
	end
end


puts "a?"
a=gets.to_f
puts "b?"
b=gets.to_f
puts "c?"
c=gets.to_f
if a==b && a==c
	puts "Equilateral triangle"
elsif a==b || a==c || b==c
	puts "Isosceles triangle"
	check_right(a,b,c)
else
	check_right(a,b,c)
end