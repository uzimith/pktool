require_relative "models/move"

module Pktool

  class Attack
    def initialize(move, attacker, defender)
      move = Move.where(name: move).first
      raise Error, "存在ない技です。" unless move
      @move = move
      @attacker = attacker
      @defender = defender
      @effects = []
      @level  = 50.0
      if [@attacker.type1, @attacker.type2].include?(@move.attack_type)
        @effect_rate = 1.5
      else
        @effect_rate = 1.0
      end
      @type_rate = 1.0
      @vital_rate = 1.5
    end

    def add_effect(effect)
    end

    def type_effect
      type_effect = open("data/type.json") do |io|
        JSON.load(io)
      end
      @type_rate *= type_effect[@defender.type1][@move.attack_type]
      @type_rate *= type_effect[@defender.type2][@move.attack_type] unless @defender.type2.empty?
    end

    def select_move_type
      case @move.move_type
      when "物理"
        @attack_stat = :A
        @defence_stat = :B
      when "特殊"
        @attack_stat = :C
        @defence_stat = :D
      end
    end

    def fetch_base_damage
      ((@move.power * @attacker.statistics(@attack_stat) * (@level * 2.0 / 5.0 + 2.0 )) / @defender.statistics(@defence_stat) / 50.0 * @effect_rate + 2.0) * @type_rate
    end

    def damage
      type_effect
      select_move_type
      base = fetch_base_damage
      min = base * 0.85
      max = base * 1.0
      {min: min.floor, max: max.floor}
    end

    def defeat
      hp = @defender.statistics(:H)
      return {num: (hp.to_f / damage[:min]).ceil, rate: (damage[:min] / hp.to_f)}
    end

  end

end
