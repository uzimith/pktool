require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'pokemon.sqlite3'
)

ActiveRecord::Migration.create_table :pokemon do |t|
  t.string :name
  t.integer :H
  t.integer :A
  t.integer :B
  t.integer :D
  t.integer :S
  t.string :type1
  t.string :type2
  t.string :ability1
  t.string :ability2
  t.boolean :hidden_ability
  t.boolean :last_evolution
  t.float :weight
end
