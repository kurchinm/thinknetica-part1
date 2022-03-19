# frozen_string_literal: true

class Route
  include InstanceCounter

  FORMAT_NAME = /\S{7,}/

  attr_reader :station_list, :name

  def initialize(start_station, stop_station, name)
    @name = name
    validate!
    @station_list = [start_station, stop_station]
  end

  def add_station(station)
    @station_list.insert(-2, station) if @station_list.include?(station) == false
  end

  def del_station(station)
    @station_list.delete(station) if @station_list.include?(station) == true
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def validate!
    raise 'Invalid route name format!' if name !~ FORMAT_NAME
  end
end
