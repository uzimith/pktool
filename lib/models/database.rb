require 'active_record'

module Pktool
  ActiveRecord::Base.establish_connection(
    :adapter => 'sqlite3',
    :database => __dir__ + '/../../data/pokemon.sqlite3'
  )
end
