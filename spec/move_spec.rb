require_relative '../lib/move.rb'
require_relative '../lib/pokemon.rb'

include Pktool

describe "Move" do

  it "should calculate the damage without any aditional condition in case #1" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("カビゴン", {nature: :ずぶとい, effort_value: :HB})
    m = Move.fetch("げきりん", attacker, defender)
    expect(m.damage).to eq({min: 106, max: 125})
  end

  it "should calculate the damage without any aditional condition in case #2" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB})
    m = Move.fetch("げきりん", attacker, defender)
    expect(m.damage).to eq({min: 72, max: 85})
  end

  it "should calculate the damage with type effect" do
    attacker = Pokemon.fetch("ボーマンダ", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("ナットレイ", {nature: :ずぶとい, effort_value: :HB})
    m = Move.fetch("だいもんじ", attacker, defender)
    # expect(m.damage(attacker, defender)).to eq({min: 144, max: 172})
    expect(m.damage).to eq({min: 148, max: 174})
  end
end
