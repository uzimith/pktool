require_relative "database"
require_relative "exceptions"

module Pktool
  class Nature < ActiveRecord::Base
    def to_s
      self.name.to_s
    end
    def to_sym
      self.name.to_sym
    end
  end
end
