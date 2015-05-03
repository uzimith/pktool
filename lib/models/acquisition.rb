require_relative "database"
require_relative "pokemon"
require_relative "move"

module Pktool

  class Acquisition < ActiveRecord::Base
    belongs_to :pokemon
    belongs_to :move

  end

end
