# frozen_string_literal: true
# frozen_string_literal: trueC

require_relative 'instance_counter'
require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'wagons'
class Menu
  def initialize
    @station_list = []
    @train_list = []
    @route_list = []
  end

  def main
    status = '0'
    loop do
      case status
      when '00'
        break
      when '0'
        main_menu
      when '01'
        create_station
        status = '0'
        main_menu
      when '02'
        create_train
        status = '0'
        main_menu
      when '03'
        route_menu
        status = '0'
        main_menu
      when '04'
        edit_train_menu
        status = '0'
        main_menu
      when '05'
        move_train
        status = '0'
        main_menu
      when '06'
        show_stations_trains
        status = '0'
        main_menu
      else
        puts 'Error input'
        status = '0'
      end
      status += gets.chomp
    end
  end

  private

  # массив экземпляров созданных объектов должен быть доступен для чтения.изменения только изнутри класса через соответствующие методы
  attr_accessor :station_list, :train_list, :route_list

  # внутренний метод класса для поиска объекта в массиве по параметру name
  def get_obj_by_name?(list, name)
    obj = false
    list.each do |object|
      if object.name == name
        obj = object
        break
      end
    end
    obj
  end

  # внутренний метод класса для отображения меню создания и редактирования маршрута, доступен только черер public метод .main_menu
  def route_menu_show
    system('clear')
    puts 'Press button to:'
    puts '1 - Create new route'
    puts '2 - Add station to the route'
    puts '3 - Delete station from the route'
    puts '0 - Exit to main menu'
  end

  # внутренний метод класса для создания нового маршрута, доступен только черер public метод .route_menu
  def create_route
    system('clear')
    puts 'Input new route name...'
    route_name = gets.chomp
    if get_obj_by_name?(@route_list, route_name) == false
      puts 'Input start station...'
      station_name = gets.chomp
      start_station = get_obj_by_name?(@station_list, station_name)
      if start_station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        puts 'Success'
        err = false
      end
      if err == false
        puts 'Input stop station...'
        station_name = gets.chomp
        stop_station = get_obj_by_name?(@station_list, station_name)
        if start_station == false
          puts "Station with name #{station_name} isn't exist!"
          err = true
        else
          puts 'Success'
          err = false
        end
      end
      if err == false
        route = Route.new(start_station, stop_station, route_name)
        @route_list << route
        puts 'New route is created!'
      end
    else
      puts "Route with #{route_name} is already exist!"
    end
  rescue StandardError => e
    puts e
    sleep 2
    retry
  end

  # внутренний метод класса для добавки станции к существующему маршруту, доступен только черер public метод .route_menu
  def add_station_to_route
    system('clear')
    puts 'Adding station to the route'
    puts 'Input route name...'
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list, route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'Input station name...'
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list, station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
    end
    if err == false
      route.add_station(station)
    else
      puts 'Error!'
    end
  end

  # внутренний метод класса для удаления станции из существующего маршрута, доступен только черер public метод .route_menu
  def del_station_from_route
    system('clear')
    puts 'Delete station from the route'
    puts 'Input route name...'
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list, route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'Input station name...'
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list, station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
    end
    if err == false
      route.del_station(station)
    else
      puts 'Error!'
    end
  end

  # внутренний метод класса для отображения подменю, доступен через метод edit_train_menu
  def edit_train_menu_show
    system('clear')
    puts 'Press button to:'
    puts '1 - Set route to the train'
    puts '2 - Add wagons to the train'
    puts '3 - Delete wagons from the train'
    puts '4 - Show all wagons on the train'
    puts '5 - Take places in wagons'
    puts '0 - Exit to main menu'
  end

  # внутренний метод класса для добавки существующего маршрута к существующему поезду, доступен только черер edit_train_menu
  def _set_route_to_train
    system('clear')
    puts 'Set route to the train'
    puts 'Input route name...'
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list, route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'Input train name...'
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list, train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
    end
    if err == false
      train._set_route(route)
    else
      puts 'Error!'
    end
  end

  # внутренний метод класса для добавки вагона к поезду
  def add_wagons_to_train
    system('clear')
    puts 'Add wagons to the train'
    puts 'Input train name...'
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list, train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'Input wagon num'
      wagon_num = gets.to_i
      case train.type
      when 'Cargo'
        puts 'Input cargo space'
        space = gets.to_i
        wagon = CargoWagon.new(wagon_num, space)
      when 'Passenger'
        puts "Input passenger's places"
        places = gets.to_i
        wagon = PassengerWagon.new(wagon_num, places)
      else
        puts 'Erorr'
      end
    end
    if err == false
      train.add_wagon(wagon)
    else
      puts 'Error'
    end
  end

  # внутренний метод класса для удаления вагона из поезда
  def del_wagons_from_train
    system('clear')
    puts 'Delete wagons from the train'
    puts 'Input train name...'
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list, train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'Input wagon num'
      wagon_num = gets.to_i
      wagon = get_obj_by_name?(train.wagons_list, wagon_num)
      if wagon == false
        puts "Wagon with num #{wagon_num} isn't belongs to train #{train_name}"
      else
        train.del_wagon(wagon)
      end
    else
      puts 'Error'
    end
  end

  def show_wagons
    system('clear')
    puts 'Show all wagons on the train'
    puts 'Input train name...'
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list, train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      puts 'wagons:'
      block = lambda do |wagon|
        puts wagon
        puts wagon.info
      end
      train.each_wagons(&block)
    end
    sleep 2
  end

  def take_places_in_wagons
    system('clear')
    puts 'Take places in wagons'
    puts 'Input train name...'
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list, train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts 'Success'
    end
    if err == false
      case train.type
      when 'Cargo'
        puts 'Input cargo space:'
        space = gets.to_i
        block = lambda do |wagon|
          if space > wagon.free_space
            wagon.take_space(wagon.free_space)
            space -= wagon.occupied_space
          else
            wagon.take_space(space)
            space = 0
          end
          puts wagon.info
          return if space.zero?
        end
        train.each_wagons(&block)
      when 'Passenger'
        puts 'Input number of passengers:'
        places = gets.to_i
        block = lambda do |wagon|
          if places > wagon.free_places
            wagon.take_place(wagon.free_places)
            places -= wagon.occupied_places
          else
            wagon.take_place(places)
            places = 0
          end
          puts wagon.info
          return if places.zero?
        end
        train.each_wagons(&block)
      end
    end
    sleep 3
  end

  def main_menu
    system('clear')
    puts 'Press button to:'
    puts '1 - Create station'
    puts '2 - Create train'
    puts '3 - Create and edit routes'
    puts '4 - Edit train'
    puts '5 - Move train'
    puts '6 - Show stations and trains'
    puts '0 - Exit programm'
  end

  def create_station
    system('clear')
    puts 'Creating new station'
    puts 'Input new station name...'
    new_name = gets.chomp
    if get_obj_by_name?(@station_list, new_name) == false
      station = Station.new(new_name)
      @station_list << station
      puts 'Success!'
    else
      puts "Station with #{new_name} is already exist!"
    end
  rescue StandardError => e
    puts e
    sleep 2
    retry
  else
    puts 'Press 1 to create new station, press any else button to exit to main menu'
    status = gets.chomp
    create_station if status == '1'
  end

  def create_train
    system('clear')
    puts 'Creating new train'
    puts 'Input new train name...'
    new_name = gets.chomp
    if get_obj_by_name?(@train_list, new_name) == false
      puts 'Input train type...Cargo or Passenger'
      type = gets.chomp
      case type
      when 'Cargo'
        puts 'Input train num'
        num = gets.chomp
        train = CargoTrain.new(new_name, num)
        err = false
      when 'Passenger'
        puts 'Input train num'
        num = gets.chomp
        train = PassengerTrain.new(new_name, num)
        err = false
      else
        puts 'Error!'
        err = true
      end
      if err == false
        @train_list << train
        puts 'Success!'
      else
        puts 'Erorr train type'
      end
    else
      puts "Train with #{new_name} is already exist!"
    end
  rescue StandardError => e
    puts e
    sleep 2
    retry
  else
    puts 'Press 1 to create new train, press any else button to exit to main menu'
    status = gets.chomp
    create_train if status == '1'
  end

  def route_menu
    system('clear')
    status = '0'
    loop do
      case status
      when '00'
        break
      when '0'
        route_menu_show
      when '01'
        create_route
        status = '0'
        route_menu_show
      when '02'
        add_station_to_route
        status = '0'
        route_menu_show
      when '03'
        del_station_from_route
        status = '0'
        route_menu_show
      else
        puts 'Error input'
        status = '0'
      end
      status += gets.chomp
    end
  end

  def edit_train_menu
    system('clear')
    status = '0'
    loop do
      case status
      when '00'
        break
      when '0'
        edit_train_menu_show
      when '01'
        _set_route_to_train
        status = '0'
        edit_train_menu_show
      when '02'
        add_wagons_to_train
        status = '0'
        edit_train_menu_show
      when '03'
        del_wagons_from_train
        status = '0'
        edit_train_menu_show
      when '04'
        show_wagons
        status = '0'
        edit_train_menu_show
      when '05'
        take_places_in_wagons
        status = '0'
        edit_train_menu_show
      else
        puts 'Error input'
        status = '0'
      end
      status += gets.chomp
    end
  end

  def move_train
    system('clear')
    puts 'To move train forward press 1, back - 2, exit - any else button'
    status = gets.chomp
    case status
    when '1'
      puts 'Input train name...'
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list, train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
      train.move_train_forward if err == false
    when '2'
      puts 'Input train name...'
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list, train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
      train.move_train_back if err == false
    end
  end

  def show_stations_trains
    system('clear')
    puts 'To show station list press 1, train list on the station - 2, exit - any else button'
    status = gets.chomp
    case status
    when '1'
      puts station_list
      sleep 2
    when '2'
      puts 'Input station name to see trains'
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list, station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts 'Success'
      end
      if err == false
        puts 'trains:'
        block = lambda do |train|
          puts train
          puts train.info
        end
        station.each_trains(&block)
      end
      sleep 2
    end
  end
end
