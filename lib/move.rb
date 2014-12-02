require_relative "database"

module Pktool
  class Move < Sequel::Model(:move)
    def damage(attacker, defender)
      level  = 50.0
      effect = 1.0
      effect *= 1.5 if [attacker.type1, attacker.type2].include?(self.type)

      type_effect = open("data/type.json") do |io|
        JSON.load(io)
      end
      type = 1.0
      type *= type_effect[defender.type1][self.type]
      type *= type_effect[defender.type2][self.type] if defender.type2

      vital = 1.0
      case move_type
      when "ぶつり"
        attack_stat = :A
        defence_stat = :B
      when "とくしゅ"
        attack_stat = :C
        defence_stat = :D
      end
      # this equation may be mistake.
      base   = ((power * attacker.statistics(attack_stat) * (level * 2.0 / 5.0 + 2.0 )) / defender.statistics(defence_stat) / 50.0 * effect + 2.0) * type
      min    = base * vital * 0.85
      max    = base * vital * 1.0
      {min: min.floor, max: max.floor}
    end
  end
end
