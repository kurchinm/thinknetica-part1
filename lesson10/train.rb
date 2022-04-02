# frozen_string_literal: true
require_relative 'accessors'
require_relative 'validation'

module Factory
  def factory_name_set(name)
    self.factory_name = name
  end

  # def factory_name
  #  factory_name
  # end

  protected

  attr_accessor :factory_name
end

class Train
  include Factory
  include InstanceCounter
  include Validation

  FORMAT_NUM = /(\d|\w){3}-?(\d|\w){2}/.freeze

  attr_reader :name, :num

  @@all = []

  def self.find(num)
    @@all.find { |train| train.num == num }
  end

  def initialize(name, num)
    @name = name
    @num = num
    @speed = 0
    validate!
    @wagons_list = []
    @@all << self
  end

  #def valid?
  #  validate!
  #  true
  #rescue StandardError
  #  false
  #end

  # используются из класса menu
  def add_wagon(wagon)
    @wagons_list << wagon if wagon.type == type && (@speed.zero? && @wagons_list.include?(wagon) == false)
  end

  def del_wagon(wagon)
    @wagons_list.delete(wagon) if @speed.zero? && @wagons_list.include?(wagon) == true
  end

  def _set_route(route)
    @cur_route = route
    @cur_index = 0
    @cur_route.station_list[@cur_index].take_train(self)
  end

  def move_train_forward
    cur_station.send_train(self)
    @cur_index += 1 unless next_station.nil?
    cur_station.take_train(self)
  end

  def move_train_back
    cur_station.send_train(self)
    @cur_index -= 1 unless prev_station.nil?
    cur_station.take_train(self)
  end

  def each_wagons(&block)
    @wagons_list.each { |wagon| block.call(wagon) }
  end

  def info
    " Num - #{num} type - #{type} wagons - #{@wagons_list.size}"
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
    @cur_route.station_list[@cur_index - 1] if @cur_index - 1 >= 0
  end

  def next_station
    @cur_route.station_list[@cur_index + 1] if @cur_index + 1 <= @cur_route.station_list.size
  end

  #def validate!
  #  raise 'Invalid train num format!' if num !~ FORMAT_NUM
  #end
end

class PassengerTrain < Train
  attr_reader :type

  def initialize(name, num)
    register_instance
    @type = 'Passenger'
    super
  end
end

class CargoTrain < Train
  attr_reader :type

  def initialize(name, num)
    register_instance
    @type = 'Cargo'
    super
  end
end
