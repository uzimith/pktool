require 'json'
require_relative "database"

module Pktool
  class Pokemon < Sequel::Model(:pokemon)
    attr_accessor :nature, :effort_value, :individual_value, :ability, :item
    attr_accessor :description
    alias :ev :effort_value
    alias :iv :individual_value

    def self.fetch(name, feature = {})
      pokemon = self.where(name: name).first
      pokemon.set(feature)
      return pokemon
    end

    def base_stat
      { H: self.H, A: self.A, B: self.B, C: self.C, D: self.D, S: self.S, 重さ: self.weight}
    end

    def set(feature)
      @description = feature[:description] || ""
      @nature = feature[:nature] || :がんばりや
      @effort_value = feature[:effort_value] ||  { H: 0, A: 0, B: 0, C: 0, D: 0, S: 0 }
      @individual_value = feature[:individual_value] ||  { H: 31, A: 31, B: 31, C: 31, D: 31, S: 31 }
      @ability = feature[:ability] ||  1
      @item = feature[:item] ||  ""
      @level = feature[:level] || 50

      if effort_value.instance_of?(Symbol)
        case effort_value
        when :hAS
          @effort_value     = { H: 6, A: 252, B: 0, C: 0, D: 0, S: 252 }
        when :hCS
          @effort_value     = { H: 6, A: 0, B: 0, C: 252, D: 0, S: 252 }
        when :HB
          @effort_value     = { H: 252, A: 0, B: 252, C: 0, D: 0, S: 0 }
        when :HD
          @effort_value     = { H: 252, A: 0, B: 0, C: 0, D: 252, S: 0 }
        when :HAs
          @effort_value     = { H: 252, A: 252, B: 0, C: 0, D: 0, S: 6 }
        when :HCs
          @effort_value     = { H: 252, A: 0, B: 0, C: 252, D: 0, S: 6 }
        else
          @effort_value     = { H: 0, A: 0, B: 0, C: 0, D: 0, S: 0 }
        end
      end
    end

    def nature_effect(name)
      nature_effect = open("data/nature.json") do |io|
        JSON.load(io, nil, { symbolize_names: true})
      end
      return 1.0 unless nature_effect[@nature]
      return nature_effect[@nature][name]
    end

    def statistics(name)
      case name
      when :H
        statistics = ((self.H * 2 + @individual_value[:H] + @effort_value[:H] / 4 ) * @level / 100 ) + 10 + @level
      else
        statistics = (((self.send(name) * 2 + @individual_value[name] + @effort_value[name] / 4 ) * @level / 100 ) + 5) * nature_effect(name)
      end
      statistics.floor
    end

    def stats
      [:H, :A, :B, :C, :D, :S].map { |name| [name, statistics(name)]}.to_h
    end

    def to_h
      {
        name: name,
        description: @description,
        nature: @nature,
        effort_value: @effort_value,
        individual_value: @individual_value,
        ability: @ability,
        item: @item
      }
    end
  end
end
