require 'active_record'
require 'nokogiri'
require 'open-uri'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => 'pokemon.sqlite3'
)

if ActiveRecord::Base.connection.table_exists? :pokemons
  ActiveRecord::Migration.drop_table :pokemons
end
if ActiveRecord::Base.connection.table_exists? :moves
  ActiveRecord::Migration.drop_table :moves
end
if ActiveRecord::Base.connection.table_exists? :natures
  ActiveRecord::Migration.drop_table :natures
end
if ActiveRecord::Base.connection.table_exists? :acquisitions
  ActiveRecord::Migration.drop_table :acquisitions
end

ActiveRecord::Migration.create_table :pokemons do |t|
  t.string  :pokemon_id
  t.string  :name
  t.integer :H
  t.integer :A
  t.integer :B
  t.integer :C
  t.integer :D
  t.integer :S
  t.string  :type1
  t.string  :type2
  t.string  :ability1
  t.string  :ability2
  t.string :hidden_ability
  t.float   :weight
  t.float   :height
  t.boolean :last_evolution
end

ActiveRecord::Migration.create_table :moves do |t|
  t.string  :name
  t.string  :attack_type
  t.integer :power
  t.integer :accuracy
  t.integer :pp
  t.integer :priority
  t.string :move_type
end

ActiveRecord::Migration.create_table :natures do |t|
  t.string  :name
  t.float :A
  t.float :B
  t.float :C
  t.float :D
  t.float :S
end

ActiveRecord::Migration.create_table :acquisitions do |t|
  t.string :pokemon_id
  t.integer :move_id
end

class Pokemon < ActiveRecord::Base
end
class Move < ActiveRecord::Base
end
class Nature < ActiveRecord::Base
end
class Acquisition < ActiveRecord::Base
end

pokemon_url = 'http://pokedb.com/pokemon/'
move_url = 'http://pokedb.com/move/'

Nokogiri::HTML.parse(open(move_url), nil).css("#moveTbl tr")[1..-1].each do |tr|
  puts tr.children[0].text
  Move.create(
    name: tr.children[0].text,
    attack_type: tr.children[1].text,
    power: tr.children[2].text,
    accuracy: tr.children[3].text,
    pp: tr.children[4].text,
    priority: tr.children[5].text == "-" ? 0 : tr.children[5].text,
    move_type: tr.children[6].text
  )
end

Nokogiri::HTML.parse(open(pokemon_url), nil).css("#pokemonTbl tr")[1..-1].each do |tr|
  puts tr.children[0].text
  href = tr.css("a").first.attribute('href').value
  detail = Nokogiri::HTML.parse(open(URI.join(pokemon_url, href)), nil)
  infomation = detail.xpath("id('biLeft')/section[1]//table//tr")
  abilities = detail.xpath("id('biLeft')/section[3]//table//tr")
  pokemon = Pokemon.create(
    pokemon_id: tr.children[0].text,
    name: tr.children[1].text,
    type1: tr.children[2].text,
    type2: tr.children[3].text,
    H: tr.children[4].text,
    A: tr.children[5].text,
    B: tr.children[6].text,
    C: tr.children[7].text,
    D: tr.children[8].text,
    S: tr.children[9].text,
    ability1: abilities[0].children[1].text,
    ability2: abilities[1].children[1].text,
    hidden_ability: abilities[2].children[1].text,
    height: infomation[3].children[1].text,
    weight: infomation[4].children[1].text.match(/(.*)kg/)[1]
  )
  detail.css("#moveTbl tr")[1..-1].each do |move_tr|
    Acquisition.create(
      pokemon_id: pokemon.id,
      move_id: Move.where(name:move_tr.children[0].text).first.id
    )
  end
end

nature_url = 'http://yakkun.com/data/seikaku.htm'

def convert_nature_effect(label)
  case label
  when "○"
    return 1.1
  when "×"
    return 0.9
  else
    return 1.0
  end
end

Nokogiri::HTML.parse(open(nature_url), nil).css("table[summary='性格リスト'] tr")[2..-1].each do |tr|
  Nature.create(
    name: tr.children[0].text,
    A: convert_nature_effect(tr.children[1].text),
    B: convert_nature_effect(tr.children[2].text),
    C: convert_nature_effect(tr.children[3].text),
    D: convert_nature_effect(tr.children[4].text),
    S: convert_nature_effect(tr.children[5].text),
  )
end
