require 'thor'
require 'thor/group'
require 'romaji'
require 'romaji/core_ext/string'
require_relative "pokemon"
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

      puts pokemon.base_stat.map{|k,v| "#{k}#{v} "}.join
    end
  end

end
