class API < Grape::API
  format :json
 
  resource :porker do
    get '/hello' do
      {hello: "world"}
    end
  end
end