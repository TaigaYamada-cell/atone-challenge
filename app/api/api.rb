require 'json'
# todo:カレントディレクトリを設定
require '/Users/t.yamada/rails-project/atone-test/app/service/judge_service.rb'

class API < Grape::API
  format :json
 
  resource :porker do
    get '/hello' do
      {hello: "world"}
    end

    post '/judge' do
      # jsonを受け取る
      result = judge_hand(params[:params][:cards])
      {result: result}
    end
  end
end