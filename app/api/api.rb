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

def best_checker(result)
  result.sort_by!{|d| d[:hand]}
  result[0][:best] = true
  # result[0]とresultの他の要素が同じ値だった場合、その要素の[:best]をtrueにする
  for i in 1..result.length-1 do
    if result[0][:hand] == result[i][:hand]
      result[i][:best] = true
    end
  end
    # resultの各要素の[:hand]を文字列に変換
    for d in result do
      d[:hand] = hand_to_str(d[:hand])
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
      error = []
      # もしrequestが二要素以上の配列だったら以下の処理を行う
      if request.length > 1 then
        # requestの要素の数だけループで回す
        for d in request do
          begin
            hand_card = HandCard.new(d)
          rescue => e
            error << {card: d, msg: e.message}
            next
          end
          # Cardインスタンスを文字列に変換
          cards = hand_card.get_cards
          # cards_strにCardインスタンスを文字列に変換したものを半角スペース区切りで代入
          cards_str = cards.join(" ")
          # 配列にhashとしてデータを追加
          result << {card: cards_str, hand: hand_card.get_hand, best: false}
        end

        # request全てがエラーだった場合は以下の処理を行う
        # 上記の場合はresultが空の配列になるので、best_checkerメソッドは実行しないでレスポンスを返す
        if result.empty?
          return {
            result: result,
            error: error
          }
        end

        # resultの各要素の[:hand]を比較して、[:hand]が最も数字が小さいresultのbestをtrueにする。ただし、[:hand]が同じになることは制約上ありえない。
        best_checker(result)

      # errorがあった場合は以下の処理を行う
      if error.any?
        return {
          result: result,
          error: error
        }
      else
        return {result: result}
      end

      # requestが一要素の配列だったら以下の処理を行う
      else 
        begin
          hand_card = HandCard.new(request[0])
        rescue => e
          return {card: request[0], msg: e.message}
        end
        cards = hand_card.get_cards
        cards_str = cards.join(" ")
        result << {card: cards_str, hand: hand_to_str(hand_card.get_hand), best: true}
        return {result: result}
      end
    end
  end
end
