require 'sinatra/base'

# nodoc
class App < Sinatra::Base
  get '/api/v1/response' do
    'Hello, world!'
  end
end
