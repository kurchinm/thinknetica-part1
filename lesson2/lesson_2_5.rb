#lesson 2.5

year = 
{
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31
}
cur_year = gets.to_i
cur_month = gets.to_i
cur_day = gets.to_i
if (cur_year%4 == 0) || ((cur_year%100 == 0) && (cur_year%400 == 0))
  year[2] = 29
end
days_sum = cur_day
year.each_pair {|month, days| days_sum += days if month < cur_month}
print days_sum
