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
    @train_list.delete(train)
  end

  def get_train_list_by_type(type)
    train_list_by_type = @train_list.select {|train| train.type == type}
    return train_list_by_type
  end

end

class Route
  attr_reader :station_list

  def initialize(start_station, stop_station)
    @station_list = [start_station, stop_station]
  end

  def add_station(station)
    @station_list.insert(-2, station) if station_list.include?(station) == false
  end

  def del_station(station)
    @station_list.delete(station)
  end

end

class Train
  attr_reader :type, :num, :wagons, :speed, :cur_route, :cur_index

  def initialize(type, num, wagons)
    @type = type
    @num = num
    @wagons = wagons
    @speed = 0
    @cur_route
    @cur_index
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
    @cur_index = 0
    @cur_route.station_list[@cur_index].take_train(self)
  end

  def cur_station
    return @cur_route.station_list[@cur_index]
  end

  def prev_station
    return @cur_route.station_list[@cur_index-1] if @cur_index-1 >= 0
  end

  def next_station
    return @cur_route.station_list[@cur_index+1] if @cur_index+1 <= @cur_route.station_list.size
  end

  def move_train_forward
    cur_station.send_train(self)
    @cur_index +=1 if next_station != nil
    cur_station.take_train(self)
  end

  def move_train_back
    cur_station.send_train(self)
    @cur_index -=1 if prev_station != nil
    cur_station.take_train(self)
  end

end