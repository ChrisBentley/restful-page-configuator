require 'sinatra/base'
require 'json'

module PageConfigurator
  class Api < Sinatra::Base
    get '/' do
        "Hello World"
    end

    get '/pages' do
        json = ConfigRepository.all
        [200, { "Content-Type" => "application/json" }, [json.to_json]]
    end

    get '/pages/:id' do
        json = ConfigRepository.search(params['id'])
        if json.nil?
            [404, { "Content-Type" => "application/json" }, [json.to_json]]
        else
            [200, { "Content-Type" => "application/json" }, [json.to_json]]
        end
    end

    put '/pages/:id' do
    end

    post '/pages' do
    end

    delete '/pages/:id' do
    end
  end
end
