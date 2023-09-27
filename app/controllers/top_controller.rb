class TopController < ApplicationController
  def index
    @message = "ようこそ"
    render template:"top/index"
  end

  def judge
    data = params[:porker]
    # serviceにデータを渡す
    @result = JudgeService.new.judge(data)
  end
end
