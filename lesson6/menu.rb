require_relative 'instance_counter'
require_relative 'train'
require_relative 'station'
require_relative 'route'

class Menu

  def initialize
    @station_list = []
    @train_list = []
    @route_list = []
  end

  def main
    status = "0"
    loop do
      case status 
      when "00"
        break
      when "0"
        self.main_menu
      when "01"
        self.create_station
        status = "0"
        self.main_menu
      when "02"
        self.create_train
        status = "0"
        self.main_menu
      when "03"
        self.route_menu
        status = "0"
        self.main_menu
      when "04"
        self.edit_train_menu
        status = "0"
        self.main_menu
      when "05"
        self.move_train
        status = "0"
        self.main_menu
      when "06"
        self.show_stations_trains
        status = "0"
        self.main_menu
      else
        puts "Error input"
        status = "0"
      end
      status += gets.chomp
    end
  end
  
  private
    # массив экземпляров созданных объектов должен быть доступен для чтения.изменения только изнутри класса через соответствующие методы
  attr_reader :station_list, :train_list, :route_list
  attr_writer :station_list, :train_list, :route_list

  #внутренний метод класса для поиска объекта в массиве по параметру name
  def get_obj_by_name?(list, name)
    obj = false
    list.each {
      |object|
      if object.name == name
        obj = object
        break
      end
    }
    return obj
  end

  #внутренний метод класса для отображения меню создания и редактирования маршрута, доступен только черер public метод .main_menu
  def route_menu_show
    system('clear')
    puts "Press button to:"
    puts "1 - Create new route"
    puts "2 - Add station to the route"
    puts "3 - Delete station from the route"
    puts "0 - Exit to main menu"
  end

  #внутренний метод класса для создания нового маршрута, доступен только черер public метод .route_menu
  def create_route
    system('clear')
    puts "Input new route name..."
    route_name = gets.chomp
    if get_obj_by_name?(@route_list, route_name) == false
      puts "Input start station..."
      station_name = gets.chomp
      start_station = get_obj_by_name?(@station_list, station_name)
      if start_station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        puts "Success"
        err = false
      end
      if err == false 
        puts "Input stop station..."
        station_name = gets.chomp
        stop_station = get_obj_by_name?(@station_list, station_name)
        if start_station == false
          puts "Station with name #{station_name} isn't exist!"
          err = true
        else
          puts "Success"
          err = false
        end
      end
      if err == false
        route = Route.new(start_station, stop_station, route_name) 
        @route_list << route
        puts "New route is created!"
      end
    else
      puts "Route with #{route_name} is already exist!"
    end
  end

  #внутренний метод класса для добавки станции к существующему маршруту, доступен только черер public метод .route_menu
  def add_station_to_route
    system('clear')
    puts "Adding station to the route"
    puts "Input route name..."
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list,route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts "Success"
    end
    if err == false
      puts "Input station name..."
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list,station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
    end
    if err == false
      route.add_station(station)
    else
      puts "Error!"
    end
  end

  #внутренний метод класса для удаления станции из существующего маршрута, доступен только черер public метод .route_menu
  def del_station_from_route
    system('clear')
    puts "Delete station from the route"
    puts "Input route name..."
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list,route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts "Success"
    end
    if err == false
      puts "Input station name..."
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list,station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
    end
    if err == false
      route.del_station(station)
    else
      puts "Error!"
    end
  end

  #внутренний метод класса для отображения подменю, доступен через метод edit_train_menu
  def edit_train_menu_show
    system('clear')
    puts "Press button to:"
    puts "1 - Set route to the train"
    puts "2 - Add wagons to the train"
    puts "3 - Delete wagons from the train"
    puts "0 - Exit to main menu"
  end

  #внутренний метод класса для добавки существующего маршрута к существующему поезду, доступен только черер edit_train_menu
  def set_route_to_train
    system('clear')
    puts "Set route to the train"
    puts "Input route name..."
    route_name = gets.chomp
    route = get_obj_by_name?(@route_list,route_name)
    if route == false
      puts "Route with name #{route_name} isn't exist!"
      err = true
    else
      err = false
      puts "Success"
    end
    if err == false
      puts "Input train name..."
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list,train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
    end
    if err == false
      train.set_route(route)
    else
      puts "Error!"
    end
  end

  #внутренний метод класса для добавки вагона к поезду
  def add_wagons_to_train
    system('clear')
    puts "Add wagons to the train"
    puts "Input train name..."
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list,train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts "Success"
    end
    if err == false
      puts "Input wagon num"
      wagon_num = gets.to_i
      if train.type == "Cargo"
        wagon = CargoWagon.new(wagon_num)
      elsif train.type == "Passenger"
        wagon = PassengerWagon.new(wagon_num)
      else
        puts "Erorr"
      end
    end
    if err == false
      train.add_wagon(wagon)
    else
      puts "Error"
    end
  end

  #внутренний метод класса для удаления вагона из поезда
  def del_wagons_from_train
    system('clear')
    puts "Delete wagons from the train"
    puts "Input train name..."
    train_name = gets.chomp
    train = get_obj_by_name?(@train_list,train_name)
    if train == false
      puts "Train with name #{train_name} isn't exist!"
      err = true
    else
      err = false
      puts "Success"
    end
    if err == false
      puts "Input wagon num"
      wagon_num = gets.to_i
      wagon = get_obj_by_name?(train.wagons_list,wagon_num)
      if wagon == false
        puts "Wagon with num #{wagon_num} isn't belongs to train #{train_name}"
      else
        train.del_wagon(wagon)
      end
    else
      puts "Error"
    end
  end

  def main_menu
    system('clear')
    puts "Press button to:"
    puts "1 - Create station"
    puts "2 - Create train"
    puts "3 - Create and edit routes"
    puts "4 - Edit train"
    puts "5 - Move train"
    puts "6 - Show stations and trains"
    puts "0 - Exit programm"
  end

  def create_station
    system('clear')
    puts "Creating new station"
    puts "Input new station name..."
    new_name = gets.chomp
    if get_obj_by_name?(@station_list, new_name) == false
      station = Station.new(new_name) 
      @station_list << station
      puts "Success!"
    else
      puts "Station with #{new_name} is already exist!"
    end
    puts "Press 1 to create new station, press any else button to exit to main menu"
    status = gets.chomp
    if status == "1"
      create_station
    end
  end

  def create_train
    system('clear')
    puts "Creating new train"
    puts "Input new train name..."
    new_name = gets.chomp
    if get_obj_by_name?(@train_list, new_name) == false
      puts "Input train type...Cargo or Passenger"
      type = gets.chomp
      if type == "Cargo"
        puts "Input train num"
        num = gets.to_i
        train = CargoTrain.new(new_name, num)
        err = false
      elsif type == "Passenger"
        puts "Input train num"
        num = gets.to_i
        train = PassengerTrain.new(new_name, num)
        err = false
      else
        puts "Error!"
        err = true
      end
      if err == false
        @train_list << train
        puts "Success!"
      else
        puts "Erorr train type"
      end
    else
      puts "Train with #{new_name} is already exist!"
    end
    puts "Press 1 to create new train, press any else button to exit to main menu"
    status = gets.chomp
    if status == "1"
      create_train
    end
  end

  def route_menu
    system('clear')
    status = "0"
    loop do
      case status 
      when "00"
        break
      when "0"
        route_menu_show
      when "01"
        create_route
        status = "0"
        route_menu_show
      when "02"
        add_station_to_route
        status = "0"
        route_menu_show
      when "03"
        del_station_from_route
        status = "0"
        route_menu_show
      else
        puts "Error input"
        status = "0"
      end
      status += gets.chomp
    end    
  end

  def edit_train_menu
    system('clear')
    status = "0"
    loop do
      case status 
      when "00"
        break
      when "0"
        edit_train_menu_show
      when "01"
        set_route_to_train
        status = "0"
        edit_train_menu_show
      when "02"
        add_wagons_to_train
        status = "0"
        edit_train_menu_show
      when "03"
        del_wagons_from_train
        status = "0"
        edit_train_menu_show
      else
        puts "Error input"
        status = "0"
      end
      status += gets.chomp
    end     
  end

  def move_train
    system('clear')
    puts "To move train forward press 1, back - 2, exit - any else button"
    status = gets.chomp
    if status == "1"
      puts "Input train name..."
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list,train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
      if err == false
        train.move_train_forward        
      end
    elsif status == "2"
      puts "Input train name..."
      train_name = gets.chomp
      train = get_obj_by_name?(@train_list,train_name)
      if train == false
        puts "Train with name #{train_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
      if err == false
        train.move_train_back    
      end
    end
  end

  def show_stations_trains
    system('clear')
    puts "To show station list press 1, train list on the station - 2, exit - any else button"
    status = gets.chomp
    if status == "1"
      puts station_list
      sleep 2
    elsif status == "2"
      puts "Input station name to see trains"
      station_name = gets.chomp
      station = get_obj_by_name?(@station_list,station_name)
      if station == false
        puts "Station with name #{station_name} isn't exist!"
        err = true
      else
        err = false
        puts "Success"
      end
      if err == false
        puts station.train_list
        sleep 2    
      end
    end
  end
end