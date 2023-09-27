require 'httpclient'

class JudgeService
  def judge(data)
    # 配列に変換する
    # APIを叩く
    # 一旦ただエラーを返すだけ。
    # todo:ハードコーディングを修正する
    url = "http://localhost:3000/api/porker/judge"
    ffa
    # client = HTTPClient.new
    # response = client.post(url, {text: 'data'}, 'Content-Type' => 'application/json')
  end
end
