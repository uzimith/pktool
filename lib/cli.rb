require 'thor'
require 'thor/group'
require 'romaji'
require 'romaji/core_ext/string'
require_relative "log"
require_relative "version"
require_relative "pokemon"
require_relative "move"
require_relative "builder"
require_relative "exceptions"

Dir.glob(File.expand_path(File.join(File.dirname(__FILE__), "command", "*.rb"))) do |path|
  require path
end

module Pktool

  class Cli < Thor
    register(Pktool::Command::Party, "party", "party [COMMAND]", "自分のパーティを編成する")

    desc "info", "ポケモンの情報を見る"
    def info

      builder = PokemonBuilder.new
      pokemon = builder.pokemon

      puts "<underline>種族値</underline>".termcolor
      puts pokemon.base_stat.map{|k,v| "<bold>#{k}</bold>:<red>#{v}</red> ".termcolor}.join
      puts "<underline>能力値</underline>".termcolor
      puts pokemon.stats.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join

      #TODO: 相性
    end

    desc "damage", "ダメージ計算する"
    def damage

      puts "<underline>攻撃側の指定</underline>".termcolor
      attacker = Builder.pokemon

      puts "<underline>防御側の指定</underline>".termcolor
      defender = Builder.pokemon

      puts "<underline>技の指定</underline>".termcolor
      move = Builder.move(attacker, defender)


      puts move.damage.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join

    end

    desc "version", "バーションを確認する。"
    def version
      puts VERSION
    end

  end

end
