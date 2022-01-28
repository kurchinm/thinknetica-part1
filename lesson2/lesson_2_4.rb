#lesson 2.4

arr_vowels = ["a","e","i","o","u","y"]
arr_letters = ("a".."z").to_a
my_hash = {}
arr_letters.each_with_index do |element, index|
  if arr_vowels.include?(element)
    my_hash[element] = index + 1
  end
end
print my_hash