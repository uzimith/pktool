require_relative '../lib/pokemon.rb'

include Pktool

describe "Nature" do
  it "should fecth nature effect" do
    n = Pokemon::Nature[:まじめ.to_s]
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
    expect(p.types).to eq({"ノーマル"=>1, "ほのお"=>0.5, "みず"=>1.0, "でんき"=>0.0, "くさ"=>1.0, "こおり"=>4, "かくとう"=>1, "どく"=>0.5, "じめん"=>1, "ひこう"=>1, "エスパー"=>1, "むし"=>1, "いわ"=>0.5, "ゴースト"=>1, "ドラゴン"=>2, "あく"=>1, "はがね"=>1, "フェアリー"=>2})
  end
end

