require_relative "database"

class Move

  attr_accessor :power, :type

  def initialize(power, type)
    @power = power
    @type = type
  end

  def damage(atacker, defender)
    return (22 * power * atacker.a / defender.b / 50 + 2) * 1
  end
end
