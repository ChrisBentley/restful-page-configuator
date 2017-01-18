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

        if request.content_type != "application/json"
            return [406, { "Content-Type" => "text/plain" }, 'Content-Type must be application/json.']
        end

        begin
            config = JSON.parse(request.body.read.to_s)
        rescue
            return [400, { "Content-Type" => "text/plain" }, 'Provided JSON was invalid.']
        end

        if ConfigRepository.search(params['id']).nil?
            response_code = 201
        else
            response_code = 200
        end

        json = ConfigRepository.store(params['id'], config['value'])

        [response_code, { "Content-Type" => "application/json" }, [json.to_json]]
    end

    post '/pages' do
    end

    delete '/pages/:id' do
    end
  end
end
