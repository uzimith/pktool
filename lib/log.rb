require 'termcolorlight'

module Pktool

  class Log

    def self.warn(str)
      puts str
    end

    def self.error(str)
      puts("<bold><red>[ERROR]</red></bold> #{str.escape}".termcolor)
    end

  end
end
