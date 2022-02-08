#lesson 4

require_relative 'menu'

menu = Menu.new


status = "0"
loop do
  case status 
  when "00"
    break
  when "0"
    menu.main_menu
  when "01"
    menu.create_station
    status = "0"
    menu.main_menu
  when "02"
    menu.create_train
    status = "0"
    menu.main_menu
  when "03"
    menu.route_menu
    status = "0"
    menu.main_menu
  when "04"
    menu.edit_train_menu
    status = "0"
    menu.main_menu
  when "05"
    menu.move_train
    status = "0"
    menu.main_menu
  when "06"
    menu.show_stations_trains
    status = "0"
    menu.main_menu
  else
    puts "Error input"
    status = "0"
  end
  status += gets.chomp

end

