require 'sinatra'

get '/' do
  erb :index
end

get '/hello-world' do
  content_type :json
  { output: 'Hello World!' }.to_json
end

post '/hello-world' do
  content_type :json
  { output: 'Hello World!' }.to_json
end
