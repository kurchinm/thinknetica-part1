# frozen_string_literal: true

class PassengerWagon
  include Factory
  attr_reader :type, :name, :free_places, :occupied_places

  def initialize(num, places)
    @type = 'Passenger'
    @name = num
    @total_places = places
    @free_places = places
    @occupied_places = 0
  end

  def take_place
    return unless @free_places >= 0

    @free_places -= 1
    @occupied_places += 1
  end

  def info
    " Num - #{name} type - #{type} free - #{free_places} occupied - #{occupied_places}"
  end
end

class CargoWagon
  include Factory
  attr_reader :type, :name, :free_space, :occupied_space

  def initialize(num, space)
    @type = 'Cargo'
    @name = num
    @total_space = space
    @free_space = space
    @occupied_space = 0
  end

  def take_space(space = 1)
    return unless @free_space >= space

    @free_space -= space
    @occupied_space += space
  end

  def info
    " Num - #{name} type - #{type} free - #{free_space} occupied - #{occupied_space}"
  end
end
