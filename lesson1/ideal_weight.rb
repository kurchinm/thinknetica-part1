puts "Input your name?.."
name = gets.chomp
puts "Input your height?.."
height = gets.to_i
ideal_weight = ( height - 110 ) * 1.15
if ideal_weight < 0 
	puts "Your weight is already optimal"
else
	puts "#{name}, your ideal weight is #{ideal_weight}"
end
