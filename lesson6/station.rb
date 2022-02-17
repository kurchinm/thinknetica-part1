class Station
  include InstanceCounter
  attr_reader :name, :train_list

  @@all = []

  def self.all
    @@all
  end

  def initialize(name, train_list = [])
    @name = name
    @train_list = train_list
    @@all << self
  end

  def take_train(train)
    @train_list << train if train_list.include?(train) == false
  end

  def send_train(train)
    @train_list.delete(train)
  end
  
  private
  def get_train_list_by_type(type)
    @train_list.select {|train| train.type == type}
  end
end