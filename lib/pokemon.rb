require_relative "database"

class Pokemon < Sequel::Model(:pokemon)
  attr_accessor :effort_value, :individual_value

  def set(way)
    @level = 50
    @nature = "timid"
    @individual_value = { H: 31, A: 31, B: 31, C: 31, D: 31, S: 31 }
    
    case way
    when :hAS
      @effort_value     = { H: 6, A: 252, B: 0, C: 0, D: 0, S: 252 }
    else
      @effort_value     = { H: 0, A: 0, B: 0, C: 0, D: 0, S: 0 }
    end
  end

  def nature_value(name)
    return 1.0
  end

  def status(name)
    case name
    when :H
      ((self.H * 2 + @individual_value[:H] + @effort_value[:H] / 4 ) * @level / 100 ) + 10 + @level
    else
      ((self.send(name) * 2 + @individual_value[name] + @effort_value[name] / 4 ) * @level / 100 ) + 5 # + nature_value(:none)
    end
  end

  def status_all
    [:H, :A, :B, :C, :D, :S].map { |name| [name, status(name)]}.to_h
  end
end
