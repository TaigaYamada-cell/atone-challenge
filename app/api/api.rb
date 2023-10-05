require "json"
require_relative "../service/judge_service.rb"
require_relative "../service/hand_card"

class API < Grape::API
  format :json
 
  resource :porker do
    get "/hello" do
      {hello: "world"}
    end

    desc "ポーカーの役を判定する"
    params do
      requires :cards, type: String, desc: "入力されたポーカーの手札"
    end
    post "/judge" do
      # jsonを受け取る
      request = params[:cards]
      begin
        hand_card = HandCard.new(request)
      rescue => e
        msg = "入力されたカード文字列が不正です"
        error!(error:[card: request, msg: msg])
      end
      result = hand_card.get_hand
      cards = hand_card.get_cards
      cards_str = []
      for card in cards do 
        cards_str.push(card.to_s)
      end
      {
        result:
          [
            hand: result,
            cards: cards_str
          ],
        msg:"OK!"
      }
    end
  end
end