require 'sinatra/base'
require 'json'

module PageConfigurator
  class Api < Sinatra::Base
    get '/' do
        "Hello World"
    end

    get '/pages' do
    end

    get '/pages/:id' do
    end

    put '/pages/:id' do
    end

    post '/pages' do
    end

    delete '/pages/:id' do
    end
  end
end
