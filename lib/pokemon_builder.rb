require_relative 'pokemon'

module Pktool

    class PokemonBuilder

      @feature = {}

      def initialize
        @pokemon = Pokemon.fetch(readline)
      end

      def readline
        pokemons = Pktool::Pokemon.select_map(:name)
        Readline.completion_append_character = ""
        Readline.completion_proc = proc {|s| pokemons.grep(/^#{s.kana}/) }
        begin
          return Readline.readline('name>', true)
        rescue Error => e
          puts "<red>#{e.message}</red>".termcolor
          retry
        end
      end

      def pokemon
        return @pokemon
      end

    end

end
