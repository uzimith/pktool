require_relative 'pokemon'
require_relative 'log'

module Pktool

    class PokemonBuilder

      def initialize
        readline
      end

      def readline
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
        @pokemon = Pokemon.fetch(name, feature)
      end


      def fetch(name, completion = [])
        Readline.completion_append_character = ""
        Readline.completion_proc = proc {|s|
          completion.grep(/^#{Romaji.romaji2kana(s)}|#{Romaji.romaji2kana(s, :kana_type => :hiragana)}/)
        }
        begin
          fetch = Readline.readline(name + '>', true)
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

      def fetch_name

      end

      def pokemon
        return @pokemon
      end

    end

end
