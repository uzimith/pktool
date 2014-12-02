require_relative 'spec_helper'
require_relative '../lib/pokemon.rb'

describe "Pokemonn" do
  it "should calculate status without nature value" do
    p = Pokemon.where(name: "ガブリアス").first
    p.set(:hAS)
    binding.pry
    expect(p.status_all).to eq({:H=>184, :A=>182, :B=>115, :C=>100, :D=>105, :S=>154})
  end
end

