require 'json'
require_relative "pokemon"

module Pktool

  class Party
    attr_accessor :list

    @@party_path = "data/user/"

    def initialize(name = "party")
      @file_path = @@party_path + "#{name}.json"
      json = open(@file_path) do |io|
        JSON.load(io, nil, { symbolize_names: true})
      end
      @list = json.map {|j| Pokemon.fetch(j[:name], j)}
    end

    def save
      open(@file_path, 'w') do |io|
        JSON.dump(@list.map{|p| p.to_h}, io)
      end
    end

    def add(pokemon)
      @list.push(pokemon)
    end

    def [](id)
      return @list[id]
    end

    def delete(id)
      @list.delete_at(id)
    end

    def update(id, pokemon)
      $list[id] = pokemon
    end

  end

end
