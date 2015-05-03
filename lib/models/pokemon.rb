require 'json'
require_relative "database"
require_relative "nature"


module Pktool

  class Pokemon < ActiveRecord::Base

    attr_accessor :nature, :effort_value, :individual_value, :ability, :item
    attr_accessor :description
    alias :ev :effort_value
    alias :iv :individual_value

    @@ways = [:AS, :CS, :hAS, :hCS, :HB, :HD, :HAs, :HCs]

    def self.fetch(name, feature = {})
      pokemon = self.find_by_name(name)
      raise Error, "存在ないポケモンです。" unless pokemon
      pokemon.set(feature)
      return pokemon
    end

    def self.ways
      return @@ways
    end

    def base_stat
      { H: self.H, A: self.A, B: self.B, C: self.C, D: self.D, S: self.S, 重さ: self.weight}
    end

    def set(feature)
      @description = feature[:description] || ""
      @nature = Nature.find_by_name(feature[:nature]) || Nature.find_by_name("がんばりや")
      @effort_value = feature[:effort_value] ||  { H: 0, A: 0, B: 0, C: 0, D: 0, S: 0 }
      @individual_value = feature[:individual_value] ||  { H: 31, A: 31, B: 31, C: 31, D: 31, S: 31 }
      @ability = feature[:ability] ||  1
      @item = feature[:item] ||  ""
      @level = feature[:level] || 50
      @rank = feature[:rank] || 1

      if effort_value.instance_of?(Symbol) && @@ways.include?(effort_value)
        case effort_value
        when :AS
          @effort_value     = { H: 0, A: 252, B: 0, C: 0, D: 0, S: 252 }
        when :CS
          @effort_value     = { H: 0, A: 0, B: 0, C: 252, D: 0, S: 252 }
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

    def statistics(name)
      case name
      when :H
        statistics = ((self.H * 2 + @individual_value[:H] + @effort_value[:H] / 4 ) * @level / 100 ) + 10 + @level
      else
        statistics = (((self.send(name) * 2 + @individual_value[name] + @effort_value[name] / 4 ) * @level / 100 ) + 5) * @nature.send(name)
      end
      statistics.floor
    end

    def stats
      [:H, :A, :B, :C, :D, :S].map { |name| [name, statistics(name)]}.to_h
    end

    def effected_statistics(name)
      effected = statistics(name)
      effected *= rank_effect
      effected *= 1.5 if name == :A && @item == "こだわりハチマキ"
      effected *= 1.5 if name == :C && @item == "こだわりメガネ"

      effected
    end

    def rank_effect
      if @rank == 1
        1.0
      else
        @rank > 0 ? (@rank.abs + 2.0) / 2.0 : 2.0 / (@rank.abs + 2.0)
      end
    end

    def types
      type_effect = open("data/type.json") do |io|
        JSON.load(io)
      end
      Hash[type_effect.keys.map do |t|
        [t, type_effect[type1][t] * type_effect[type2][t]]
      end]
    end

    def to_h
      {
        name: name,
        description: @description,
        nature: @nature.to_sym,
        effort_value: @effort_value,
        individual_value: @individual_value,
        ability: @ability,
        item: @item
      }
    end
  end
end
