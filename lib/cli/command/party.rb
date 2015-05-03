require_relative "../../party"
require_relative "../../models/pokemon"
require 'termcolorlight'

module Pktool
  module Command
    class Party < Thor
      desc "list", "一覧を表示する"
      def list
        Pktool::Party.new.list.each_with_index do |p,index|
          puts "<bold>#{index+1} #{p.name}#{"(#{p.description})" unless p.description.empty?}</bold> #{p.nature} #{p.ability} #{p.item}".termcolor
          puts "努力値:#{p.ev.map{|k,v| "#{k}#{v} "}.join} 個体値:#{p.iv.map{|k,v| "#{k}#{v} "}.join}".termcolor
          puts ""
        end
      end

      desc "add [NAME]", "ポケモンを追加する"
      def add(name, description = "", nature = "", effort_value = "", individual_value = "", ability = "", item = "", level = "")
        feature = {}
        # feature = {
        #   description: description,
        #   nature: nature,
        #   effort_value: effort_value.to_sym,
        #   individual_value: individual_value,
        #   ability: ability,
        #   item: item,
        #   level: level
        # }
        party = Pktool::Party.new
        pokemon = Pktool::Pokemon.fetch(name, feature)
        party.add(pokemon)
        party.save
      end

      desc "delete [ID]", "ポケモンを削除する"
      def delete(id)
        party = Pktool::Party.new
        # todo: raise error
        party.delete( - 1)
        party.save
      end

      desc "update", "ポケモンを更新する"
      def update
        party = Pktool::party.new
      end

    end
  end
end
