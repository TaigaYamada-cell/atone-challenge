require 'rails_helper'

URL = "/api/porker/judge"

# describe "porker judge api", :type => :request do
describe 'POST /api/porker/judge' do
  # URLにpostすると、responseが返ってくる
  it "returns response" do
    post URL, cards: ["H2 C3 H4 C5 H6"]
    expect(response.status).to eq(201)
  end

  # 不正なパラメータを送信した場合、400が返ってくる
  it "returns 400" do
    post URL, paramus: ["H2 C3 H4 C5 H6"]
    expect(response.status).to eq(400)
  end
end
