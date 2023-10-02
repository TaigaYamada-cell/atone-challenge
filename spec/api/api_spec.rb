require 'rails_helper'

URL = "/api/porker/judge"

describe "porker judge api", :type => :request do
  it "returns response" do
    post URL
    expect(response.status).to eq 201
  end

  context "役が一種類のみの時" do
    context "役がストレートフラッシュの時" do
      it "returns response" do
        post URL, params: { cards: "H1 H13 H12 H11 H10" }
        expect(response.status).to eq 201
      end

      it "ストレートフラッシュと判定する" do
        post URL, params: { cards: "H1 H13 H12 H11 H10" }
        json = JSON.parse(response.body)
        print(json)
        expect(json["result"]).to include("ストレートフラッシュ")
      end
    end
  end
end
