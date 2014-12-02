require_relative '../lib/move.rb'
require_relative '../lib/pokemon.rb'

describe "Move" do
  it "should get the power and the type" do
    m = Move.where(name: "じしん").first
    expect(m.power).to eq(100)
    expect(m.type).to eq("じめん")
  end

  it "should calculate the damage without any aditional condition in case #1" do
    m = Move.where(name: "げきりん").first
    attacker = Pokemon.where(name: "ガブリアス").first
    attacker.set(:hAS, :いじっぱり)
    defender = Pokemon.where(name: "カビゴン").first
    defender.set(:HB, :ずぶとい)
    expect(m.damage(attacker, defender)).to eq({min: 106, max: 125})
  end

  it "should calculate the damage without any aditional condition in case #2" do
    m = Move.where(name: "げきりん").first
    attacker = Pokemon.where(name: "ガブリアス").first
    attacker.set(:hAS, :いじっぱり)
    defender = Pokemon.where(name: "クレセリア").first
    defender.set(:HB, :ずぶとい)
    expect(m.damage(attacker, defender)).to eq({min: 72, max: 85})
  end

  it "should calculate the damage with type effect" do
    m = Move.where(name: "だいもんじ").first
    attacker = Pokemon.where(name: "ボーマンダ").first
    attacker.set(:hAS, :いじっぱり)
    defender = Pokemon.where(name: "ナットレイ").first
    defender.set(:HB, :ずぶとい)
    expect(m.damage(attacker, defender)).to eq({min: 144, max: 172})
  end
end
