require_relative '../lib/attack'
require_relative '../lib/models/pokemon'

include Pktool

describe "Move" do

  it "should calculate the damage without any aditional condition in case #1" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("カビゴン", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 106, max: 125})
  end

  it "should calculate the damage without any aditional condition in case #2" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 72, max: 85})
  end

  it "should calculate the damage with type effect" do
    attacker = Pokemon.fetch("ボーマンダ", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("ナットレイ", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("だいもんじ", attacker, defender)

    expect(a.damage).to eq({min: 148, max: 174})
    # pokemon-trainer: expect(m.damage(attacker, defender)).to eq({min: 144, max: 172})
  end

  it "should calculate the damage without any aditional condition in case #1" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("カビゴン", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 106, max: 125})
  end

  it "should calculate the damage with attack rank 2" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS, rank: 2})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 144, max: 169})
  end

  it "should calculate the damage with defence rank 2" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB, rank: 2})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 37, max: 43})
    # pokemon-trainer: expect(a.damage).to eq({min: 36, max: 43})
  end

  it "should calculate the damage with こだわりハチマキ" do
    attacker = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS, item: "こだわりハチマキ"})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("げきりん", attacker, defender)

    expect(a.damage).to eq({min: 108, max: 127})
    # pokemon-trainer: expect(a.damage).to eq({min: 36, max: 43})
  end

  it "should calculate the damage with こだわりハチマキ" do
    attacker = Pokemon.fetch("ラティオス", {nature: :ひかえめ, effort_value: :hCS, item: "こだわりメガネ"})
    defender = Pokemon.fetch("クレセリア", {nature: :ずぶとい, effort_value: :HB})
    a = Attack.new("りゅうせいぐん", attacker, defender)

    expect(a.damage).to eq({min: 147, max: 173})
    # pokemon-trainer: expect(a.damage).to eq({min: 147, max: 174})
  end
end
