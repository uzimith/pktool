require 'json'
require_relative "pokemon"

module Pktool

  class Party
    attr_accessor :list

    @@json_path = "data/user/party.json"

    def initialize
      json = open(@@json_path) do |io|
        JSON.load(io, nil, { symbolize_names: true})
      end
      @list = json.map {|j| Pokemon.fetch(j[:name], j)}
    end

    def save
      open(@@json_path, 'w') do |io|
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
