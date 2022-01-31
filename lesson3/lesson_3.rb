#lesson 3

class Station
  
  attr_reader :name, :train_list

  def initialize(name, train_list = [])
    @name = name
    @train_list = train_list
  end

  def take_train(train)
    @train_list << train if train_list.include?(train) == false
  end

  def send_train(train)
    @train_list.delete(train) {"train wasn't found on the station"}
  end

  def get_train_list_by_type(type)
    if type == "cargo" || type == "pass"
      train_list_by_type = []
      @train_list.each {
        |train|
        train_list_by_type << train if train.type == type
      }
      return train_list_by_type
    else
      puts "unknown type"
    end
  end

end

class Route
  attr_reader :start_station, :stop_station, :station_list

  def initialize(start_station, stop_station)
    @start_station = start_station
    @stop_station = stop_station
    @station_list = [start_station, stop_station]
  end

  def add_station(station)
    @station_list.insert(-2, station)
  end

  def del_station(station)
    @station_list.delete(station) {"station wasn't found on the route"}
  end

end

class Train

  attr_reader :type, :num, :wagons, :speed, :cur_station, :prev_station, :next_station, :cur_route

  def initialize(type, num, wagons)
    @type = type
    @num = num
    @wagons = wagons
    @speed = 0
    @cur_station = "unknown"
    @prev_station = "unknown"
    @next_station = "unknown"
    @cur_route = "unknown"
  end

  def inc_speed(value)
    @speed += value
  end

  def slow_down
    @speed = 0
  end

  def inc_wagons
    @wagons += 1 if @speed == 0
  end

  def dec_wagons
    @wagons -= 1 if @speed == 0 && @wagons != 0
  end

  def set_route(route)
    @cur_route = route
    @cur_station = route.start_station
    @cur_station.take_train(self)
    @next_station = route.station_list[1]
  end

  def move_train(direction)
    if direction == "forward"
      @cur_station.send_train(self)
      @prev_station = @cur_station
      @cur_station = @next_station
      @cur_station.take_train(self)
      #find index of current station
      index = @cur_route.station_list.find_index(@cur_station)
      @next_station = @cur_route.station_list[index+1] if index+1 <= @cur_route.station_list.size
    elsif direction == "back"
      @cur_station.send_train(self)
      temp = @cur_station
      @cur_station = @prev_station
      @cur_station.take_train(self)
      @prev_station = temp
      #find index of current station
      index = @cur_route.station_list.find_index(@cur_station)
      @next_station = @cur_route.station_list[index-1] if index-1 >= 0
    else
      puts "error direction"
    end
  end
end


train1 = Train.new("pass", 1234, 10)
train2 = Train.new("cargo", 555, 3)
st1 = Station.new("Moscow")
st2 = Station.new("Tver")
st3 = Station.new("Snt. P")
route1 = Route.new(st1, st3)
route1.add_station(st2)
route1.station_list.each {|station| puts station.name}
puts ""
train1.set_route(route1)
train2.set_route(route1)
train2.move_train("forward")
route1.station_list.each {
  |station| 
  print station.name
  print " "
  station.train_list.each {
    |train|
    print train.cur_station.name
    print " "
    print train.num
    puts " "
  }
}
