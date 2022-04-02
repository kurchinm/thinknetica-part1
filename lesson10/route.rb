# frozen_string_literal: true
require_relative 'accessors'
require_relative 'validation'

class Route
  include InstanceCounter
  include Accessors
  include Validation

  FORMAT_NAME = /\S{7,}/.freeze

  attr_reader :station_list, :name

  validate :start_station, :type, Station
  validate :stop_station, :type, Station


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

  #def valid?
  #  validate!
  #  true
  #rescue StandardError
  #  false
  #end

  private

  #def validate!
  #  raise 'Invalid route name format!' if name !~ FORMAT_NAME
  #end
end
