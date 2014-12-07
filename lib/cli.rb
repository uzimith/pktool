require 'thor'
require 'thor/group'
require 'romaji'
require 'romaji/core_ext/string'
require_relative "pokemon"
require_relative "pokemon_builder"
require_relative "move"
require_relative "exceptions"

Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "command", "*.rb"))) do |path|
  require path
end

module Pktool

  class Cli < Thor
    register(Pktool::Command::Party, "party", "party [COMMAND]", "パーティを編成する")
    desc "info", "ポケモンの情報を見る"
    def info

      Readline.completion_append_character = ""
      pokemons = Pktool::Pokemon.select_map(:name)
      Readline.completion_proc = proc {|s| pokemons.grep(/^#{s.kana!}/) }

      
      begin
        pokemon = Pktool::Pokemon.fetch(Readline.readline('name>', true))
      rescue Error => e
        puts "<red>#{e.message}</red>".termcolor
        retry
      end

      puts pokemon.base_stat.map{|k,v| "<bold>#{k}</bold>:#{v} ".termcolor}.join

      #TODO: 相性
    end

    desc "damage", "ダメージ計算する"
    def damage

      puts "<underline>攻撃側の指定</underline>".termcolor
      builder = PokemonBuilder.new
      attacker = builder.pokemon

      puts "<underline>防御側の指定</underline>".termcolor
      builder = PokemonBuilder.new
      defender = builder.pokemon

      puts "<underline>技の指定</underline>".termcolor

      moves = Pktool::Move.select_map(:name)
      Readline.completion_append_character = ""
      Readline.completion_proc = proc {|s|
        moves.grep(/^#{Romaji.romaji2kana(s)}|#{Romaji.romaji2kana(s, :kana_type => :hiragana)}/)
      }
      begin
        move = Pktool::Move.fetch(Readline.readline('move>', true))
      rescue Error => e
        puts "<red>#{e.message}</red>".termcolor
        retry
      end

      p move.damage(attacker,defender)

    end

  end

end
