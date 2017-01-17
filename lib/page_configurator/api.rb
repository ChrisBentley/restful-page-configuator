require 'sinatra/base'
require 'json'

module PageConfigurator
  class Api < Sinatra::Base
    get '/' do
        "Hello World"
    end

    get '/pages' do
        json = ConfigRepository.all.to_json
        [200, { "Content-Type" => "application/json" }, [json]]
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
