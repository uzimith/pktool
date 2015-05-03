require_relative "models/move"

module Pktool

  class Attack
    def initialize(move, attacker, defender)
      move = Move.where(name: move).first
      raise Error, "存在ない技です。" unless move
      @move = move
      @attacker = attacker
      @defender = defender
    end

    def damage
      level  = 50.0
      effect = 1.0
      effect *= 1.5 if [@attacker.type1, @attacker.type2].include?(@move.attack_type)

      # type effect
      type_effect = open("data/type.json") do |io|
        JSON.load(io)
      end
      type = 1.0
      type *= type_effect[@defender.type1][@move.attack_type]
      type *= type_effect[@defender.type2][@move.attack_type] unless @defender.type2.empty?

      vital = 1.0
      case @move.move_type
      when "物理"
        attack_stat = :A
        defence_stat = :B
      when "特殊"
        attack_stat = :C
        defence_stat = :D
      end
      # todo: this equation may be mistake.
      base   = ((@move.power * @attacker.statistics(attack_stat) * (level * 2.0 / 5.0 + 2.0 )) / @defender.statistics(defence_stat) / 50.0 * effect + 2.0) * type
      min    = base * vital * 0.85
      max    = base * vital * 1.0
      {min: min.floor, max: max.floor}
    end

    def defeat
      hp = @defender.statistics(:H)
      damage = @move.damage
      return {num: (hp.to_f / damage[:min]).ceil, rate: (damage[:min] / hp.to_f)}
    end

  end

end
