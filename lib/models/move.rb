require_relative "database"
require_relative "move"
require_relative "acquisition"

module Pktool

  class Move < ActiveRecord::Base
    has_many :acquisitions
    has_many :pokemons, through: :acquisitions

  end

end
