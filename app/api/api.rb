class API < Grape::API
  format :json
 
  resource :porker do
    get '/hello' do
      {hello: "world"}
    end

    post '/judge' do
      message = params[:]
      {hello: "world"}
    end
  end
end