require 'rails_helper'

RSpec.describe TopController, type: :controller do
  describe "#index" do
    it "returns a success response" do
      get :index
      expect(response).to be_success
    end
    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#judge" do
    context "OK pattern" do
      it "returns a success response" do
        post :judge, porker: "H1 H13 H12 H11 H10"
        expect(response).to be_success
      end
      it "returns a 200 response" do
        post :judge, porker: "H1 H13 H12 H11 H10"
        expect(response).to have_http_status "200"
      end
      it "has a message: 結果" do
        post :judge, porker: "H1 H13 H12 H11 H10"
        expect(assigns(:message)).to eq "結果"
      end
      it "has a hand: フラッシュ" do
        post :judge, porker: "H8 H13 H12 H11 H10"
        expect(assigns(:hand)).to eq "フラッシュ"
      end
      it "render template: top/index" do
        post :judge, porker: "H1 H13 H12 H11 H10"
        expect(response).to render_template :index
      end
    end
    # feature-develop-apiをまだマージしていないので、このテストはパスしない
    context "NG pattern" do
      it "returns a success response" do
        post :judge, porker: "H1 H13 H12 H11"
        expect(response).to be_success
      end
      it "returns a 200 response" do
        post :judge, porker: "H1 H13 H12 H11"
        expect(response).to have_http_status "200"
      end
      it "raise ArugumentError" do
        post :judge, porker: "H1 H13 H12 H11"
        expect(assigns(:message)).to eq "引数の要素数が不正です"
      end
      it "render template: top/error" do
        post :judge, porker: "f"
        expect(response).to render_template :error
      end
    end
  end
end
