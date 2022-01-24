#lesson 2.1
months = Hash.new
months["january"] = 31
months["february"] = 28
months["march"] = 31
months["april"] = 30
months["may"] = 31
months["june"] = 30
months["july"] = 31
months["august"] = 31
months["september"] = 30
months["october"] = 31
months["november"] = 30
months["december"] = 31
keys = months.keys
for item in (0..keys.size) do
  if months[keys[item]] == 30
    puts keys[item]
  end
end