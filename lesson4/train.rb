class Train
  attr_reader :name

  def initialize(name)
    @name = name
    @wagons_list = []
  end
  
  #используются из класса menu
  def add_wagon(wagon)
    if wagon.type == self.type 
      @wagons_list << wagon if @speed == 0 && @wagons_list.include?(wagon) == false
    end
  end

  def del_wagon(wagon)
    @wagons_list.delete(wagon) if @speed == 0 && @wagons_list.include?(wagon) == true
  end

  def set_route(route)
    @cur_route = route
    @cur_index = 0
    @cur_route.station_list[@cur_index].take_train(self)
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

  private
  def inc_speed(value)
    @speed += value
  end

  def slow_down
    @speed = 0
  end

  def cur_station
    @cur_route.station_list[@cur_index]
  end

  def prev_station
    @cur_route.station_list[@cur_index-1] if @cur_index-1 >= 0
  end

  def next_station
    @cur_route.station_list[@cur_index+1] if @cur_index+1 <= @cur_route.station_list.size
  end
end

class PassengerTrain < Train
  attr_reader :type
  
  def initialize(name)
    @type = "Passenger"
    super
  end
end

class CargoTrain < Train
  attr_reader :type

  def initialize(name)
    @type = "Cargo"
    super
  end
end

class PassengerWagon
  attr_reader :type, :name

  def initialize(num)
    @type = "Passenger"
    @name = num
  end
end

class CargoWagon
  attr_reader :type, :name

  def initialize(num)
    @type = "Cargo"
    @name = num
  end
end