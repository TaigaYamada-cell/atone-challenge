require 'httpclient'

class JudgeService
  def judge(data)
    # APIを叩く
    # 一旦ただエラーを返すだけ。
    # todo:ハードコーディングを修正する
    url = "http://localhost:3000/api/porker/judge"
    ffa
    # client = HTTPClient.new
    # response = client.post(url, {text: 'data'}, 'Content-Type' => 'application/json')
  end
end

# 役を判定して結果を返す
def judge_hand(cards)
  hand = nil

  # これどうにかならんか。いけてないのはわかる
  if(HandCheckService.high_card_check(cards))
    hand = "ハイカード"
  end
  if(HandCheckService.one_pair_check(cards))
    hand = "ワンペア"
  end
  if(HandCheckService.two_pair_check(cards))
    hand = "ツーペア"
  end
  if(HandCheckService.three_of_a_kind_check(cards))
    hand = "スリー・オブ・ア・カインド"
  end
  if(HandCheckService.straight_check(cards))
    hand = "ストレート"
  end
  if(HandCheckService.flush_check(cards))
    hand = "フラッシュ"
  end
  if(HandCheckService.full_house_check(cards))
    hand = "フルハウス"
  end
  if(HandCheckService.four_of_a_kind_check(cards))
    hand = "フォー・オブ・ア・カインド"
  end
  if(HandCheckService.straight_flush_check(cards))
    hand = "ストレートフラッシュ"
  end
  

  return hand
end