require 'thor'
require 'thor/group'
require 'romaji'
require 'romaji/core_ext/string'
require_relative "pokemon"

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

      name = Readline.readline('name>', true)
      pokemon = Pktool::Pokemon.fetch(name)

      puts pokemon.base_stat.map{|k,v| "#{k}#{v} "}.join
    end
  end

end
