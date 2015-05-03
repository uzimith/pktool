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
    # register(Pktool::Command::Party, "party", "party [COMMAND]", "自分のパーティを編成する")

    desc "info", "ポケモンの情報を見る"
    def info
      pokemon = Builder.default_pokemon
      puts "<underline>図鑑番号</underline>".termcolor
      puts pokemon.pokemon_id
      puts "<underline>種族値</underline>".termcolor
      puts pokemon.base_stat.map{|k,v| "<bold>#{k}</bold>:<red>#{v}</red> ".termcolor}.join
      puts "<underline>相性</underline>".termcolor
      puts pokemon.types.select{|k,v| v > 1 }.map{|k,v| "<bold>#{k}</bold>:<red>#{v}</red> ".termcolor}.join
      puts pokemon.types.select{|k,v| v < 1 }.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
    end

    desc "status", "ポケモンのステータスを見る"
    def status
      pokemon = Builder.new_pokemon
      puts "<underline>種族値</underline>".termcolor
      puts pokemon.base_stat.map{|k,v| "<bold>#{k}</bold>:<red>#{v}</red> ".termcolor}.join
      puts "<underline>能力値</underline>".termcolor
      puts pokemon.stats.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
      puts "<underline>相性</underline>".termcolor
      puts pokemon.types.select{|k,v| v > 1 }.map{|k,v| "<bold>#{k}</bold>:<red>#{v}</red> ".termcolor}.join
      puts pokemon.types.select{|k,v| v < 1 }.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
    end

    desc "damage", "ダメージ計算する"
    def damage
      puts "<underline>攻撃側の指定</underline>".termcolor
      attacker = Builder.new_pokemon

      puts "<underline>防御側の指定</underline>".termcolor
      defender = Builder.new_pokemon

      puts "<underline>技の指定</underline>".termcolor
      move = Builder.move(attacker, defender)

      puts ""
      puts "<underline>攻撃側</underline>".termcolor
      puts attacker.name + " " + attacker.stats.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
      puts "<underline>防御側</underline>".termcolor
      puts defender.name + " " + defender.stats.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
      puts
      puts move.damage.map{|k,v| "<bold>#{k}</bold>:<blue>#{v}</blue> ".termcolor}.join
      defeat = move.defeat
      puts "<bold>確定数</bold>:<red>#{defeat[:num]}回</red> (#{'%.2f' % (defeat[:rate] * 100)}%) ".termcolor

    end

    desc "version", "バーションを確認する。"
    def version
      puts VERSION
    end

  end

end
