#lesson 2.5

year = {}
year[1] = 31
year[2] = 28
year[3] = 31
year[4] = 30
year[5] = 31
year[6] = 30
year[7] = 31
year[8] = 31
year[9] = 30
year[10] = 31
year[11] = 30
year[12] = 31

year_leap = year
year_leap[2] = 29

cur_year = gets.to_i
cur_month = gets.to_i
cur_day = gets.to_i

days_sum = cur_day
if (cur_year%4 == 0) || ((cur_year%100 == 0) && (cur_year%400 == 0))
  year_leap.each_pair {|key, value| days_sum += value if key < cur_month}
else
  year.each_pair {|key, value| days_sum += value if key < cur_month}
end
print days_sum
