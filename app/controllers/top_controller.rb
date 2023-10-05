class TopController < ApplicationController
  protect_from_forgery
  skip_before_action :verify_authenticity_token
  def index
    @message = "ようこそ"
    render template:"top/index"
  end

  def judge
    data = params[:porker]
    # serviceにデータを渡す
    @message = "結果"
    hand = JudgeService.new.judge(data)
    @result = hand_to_str(hand)
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
