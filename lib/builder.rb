require_relative 'pokemon'
require_relative 'party'
require_relative 'move'
require_relative 'log'

module Pktool

    class Builder

      def self.pokemon
        party = Party.new
        command = fetch("command")
        if(command == "new")
          return self.new_pokemon
        end
        if(command =~ /^\d+$/)
          return party[command.to_i]
        end
        warn "Not found."
      end

      def self.new_pokemon
        pokemons = Pokemon.select_map(:name)
        natures = Pokemon::Nature.select_map(:name)
        name = fetch("なまえ", pokemons)
        feature = {} 
        feature[:nature] = fetch("せいかく", natures) do |input| input.to_sym end
        feature[:effort_value] = fetch("努力値(default: 0)") do |input|
          if(Pokemon.ways.include?(input.to_sym))
            input.to_sym
          else
            { H: 0, A: 0, B: 0, C: 0, D: 0, S: 0 }
          end
        end
        feature[:individual_value] = fetch("個体値(default: 6V)") do |input|
          { H: 31, A: 31, B: 31, C: 31, D: 31, S: 31 }
        end
        return Pokemon.fetch(name, feature)
      end

      def self.move(attacker, defender)
        moves = Move.select_map(:name)
        move = fetch("わざ", moves)
        move = Move.fetch(move, attacker, defender)
      end

      def self.fetch(name, completion = [])
        Readline.completion_append_character = ""
        Readline.completion_proc = proc {|s|
          completion.grep(/^#{Romaji.romaji2kana(s)}|#{Romaji.romaji2kana(s, :kana_type => :hiragana)}/)
        }
        begin
          fetch = ::Readline.readline(name + '>', true)
          raise Error, "対象が見つかりません" unless completion.empty? or completion.include?(fetch)
          if block_given?
            return yield(fetch)
          else
            return fetch
          end
        rescue Error => e
          Log::error e.message
          retry
        end

      end

    end

end
