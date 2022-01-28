#lesson 2.6
shopping_list = {}
loop do
  puts "Input name"
  title = gets.chomp.to_s
  break if title == "stop" 
  puts "Input price"
  price = gets.to_f
  puts "Input number"
  num = gets.to_i
  hash_temp = {}
  hash_temp["price"]=price
  hash_temp["num"]=num
  shopping_list[title] = hash_temp
end
amount = 0
shopping_list.each_pair {
  |key,value| 
  sum = (value["price"] * value["num"]).round(2) 
  puts "#{key}: #{value}, sum=#{sum}"
  amount +=sum
} 
puts "Total price #{amount}"