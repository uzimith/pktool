require 'sequel'

module Pktool
  DB = Sequel.connect('sqlite://data/pokemonData.sqlite')
end
