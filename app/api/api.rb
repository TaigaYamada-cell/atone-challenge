require "json"
require_relative "../service/judge_service.rb"
require_relative "../service/hand_card"

def hand_to_str(hand)
  result = nil
  case hand
  when 1 then 
    result = "ストレートフラッシュ"
  when 2 then
    result = "フォー・オブ・ア・カインド"
  when 3 then
    result = "フルハウス"
  when 4 then 
    result = "フラッシュ"
  when 5 then 
    result = "ストレート"
  when 6 then 
    result = "スリー・オブ・ア・カインド"
  when 7 then
    result = "ツーペア"
  when 8 then
    result = "ワンペア"
  when 9 then
    result = "ハイカード"
  end
  return result
end

class API < Grape::API
  format :json
  resource :porker do
    get "/hello" do
      {hello: "world"}
    end

    desc "ポーカーの役を判定する"
    params do
      requires :cards, type: Array, desc: "入力されたポーカーの手札"
    end
    post "/judge" do
      # jsonを受け取る
      request = params[:cards]
      result = []
      # もしrequestが二要素以上の配列だったら以下の処理を行う
      if request.length > 1 then
        # requestの要素数をカウンタにして、ループで回す
        for d in request do
          begin
            hand_card = HandCard.new(d)
          rescue => e
            # todo:エラーの内容に応じて、エラーメッセージを変える
            msg = "入力されたカード文字列が不正です"
            error!(error:[card: d, msg: msg])
          end
          # Cardインスタンスを文字列に変換
          cards = hand_card.get_cards
          cards_str = []
          for card in cards do 
            cards_str.push(card.to_s)
          end
          # 配列にhashとしてデータを追加
          result << {card: cards_str, hand: hand_card.get_hand, best: false}
        end
        # resultの各要素の[:hand]を比較して、[:hand]が最も数字が小さいresultのbestをtrueにする。ただし、[:hand]が同じになることは制約上ありえない。
        result.sort_by!{|d| d[:hand]}
        result[0][:best] = true
        # resultの各要素の[:hand]を文字列に変換
        for d in result do
          d[:hand] = hand_to_str(d[:hand])
        end
      else 
        begin
          hand_card = HandCard.new(request[0])
        rescue => e
          # todo:エラーの内容に応じて、エラーメッセージを変える
          msg = "入力されたカード文字列が不正です"
          error!(error:[card: d, msg: msg])
        end
        cards = hand_card.get_cards
        cards_str = []
          for card in cards do 
            cards_str.push(card.to_s)
          end
        result << {card: cards_str, hand: hand_to_str(hand_card.get_hand), best: true}
      end
      
      {
        result:
          result,
          msg:"OK!"
      }
    end
  end
end
