# frozen_string_literal: true

class Station
  include InstanceCounter

  FORMAT_NAME = /\S{3,}/.freeze

  attr_reader :name, :train_list

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, train_list = [])
    @name = name
    validate!
    @train_list = train_list
    @@all << self
  end

  def take_train(train)
    @train_list << train if train_list.include?(train) == false
  end

  def send_train(train)
    @train_list.delete(train)
  end

  def each_trains(&block)
    @train_list.each { |train| block.call(train) }
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  private

  def get_train_list_by_type(type)
    @train_list.select { |train| train.type == type }
  end

  def validate!
    raise 'Invalid station name format!' if name !~ FORMAT_NAME
  end
end
