require_relative '../lib/pokemon.rb'

include Pktool

describe "Pokemonn" do
  it "should calculate status without nature effect" do
    p = Pokemon.where(name: "ガブリアス").first
    p.set(:hAS, :がんばりや)
    expect(p.stats).to eq({:H=>184, :A=>182, :B=>115, :C=>100, :D=>105, :S=>154})
  end
  it "should calculate status with nature effect" do
    p = Pokemon.where(name: "ガブリアス").first
    p.set(:hAS, :いじっぱり)
    expect(p.stats).to eq({:H=>184, :A=>200, :B=>115, :C=>90, :D=>105, :S=>154})
  end
end

