class Route
  attr_reader :station_list, :name

  def initialize(start_station, stop_station, name)
    @station_list = [start_station, stop_station]
    @name = name
  end

  def add_station(station)
    @station_list.insert(-2, station) if @station_list.include?(station) == false
  end

  def del_station(station)
    @station_list.delete(station) if @station_list.include?(station) == true
  end
end