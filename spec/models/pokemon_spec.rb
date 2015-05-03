require_relative '../../lib/models/pokemon.rb'

include Pktool

describe "Nature" do
  it "should fecth nature effect" do
    n = Nature.find_by_name(:まじめ)
    expect(n.A).to eq 1.0
  end
end

describe "Pokemon" do
  it "should calculate status without nature effect" do
    p = Pokemon.fetch("ガブリアス", {nature: :がんばりや, effort_value: :hAS})
    expect(p.stats).to eq({:H=>184, :A=>182, :B=>115, :C=>100, :D=>105, :S=>154})
  end

  it "should calculate status with nature effect" do
    p = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    expect(p.stats).to eq({:H=>184, :A=>200, :B=>115, :C=>90, :D=>105, :S=>154})
  end

  it "should be converted to hash" do
    p = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    expect(p.to_h).to eq(
      {
        name: "ガブリアス",
        description: "",
        nature: :いじっぱり,
        effort_value:{ H: 6, A: 252, B: 0, C: 0, D: 0, S: 252 } ,
        individual_value:{ H: 31, A: 31, B: 31, C: 31, D: 31, S: 31 },
        ability: 1,
        item: ""
      }
    )
  end

  it "should has type effect"  do
    p = Pokemon.fetch("ガブリアス", {nature: :いじっぱり, effort_value: :hAS})
    expect(p.types["氷"]).to eq(4)
  end
end

