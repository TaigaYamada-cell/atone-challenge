class TopController < ApplicationController
  def index
    @message = "半角区切りで5枚のカードを入力してください"
    render template:"top/index"
  end

  def judge
    data = params[:porker]
    begin
      res = JudgeService.new.judge(data)
    rescue => e
      @message = e.message
      render template:"top/error"
      return
    end
    @message = "結果"
    @hand = hand_to_str(res[0])
    @cards = res[1]
    render template:"top/index"
  end

  private
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
end
