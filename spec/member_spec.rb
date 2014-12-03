require_relative '../lib/member.rb'

include Pktool

describe "Member" do
  it "" do
    member = Member.new
    p member.list[1]
    member.list[1][:pokemon] = "ボーマンダ"
    member.save
  end
end
