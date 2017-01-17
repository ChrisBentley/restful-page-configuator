require 'spec_helper'
require 'rack/test'

module PageConfigurator
  describe Api do
    include Rack::Test::Methods

    let(:app) { PageConfigurator::Api.new }

    describe 'GET /' do
        it "returns_hello_world" do
            get '/'
            expect(last_response.ok?).to be true
            expect(last_response.body).to eq('Hello World')
        end
    end

    describe 'GET /pages' do
        before do
            ConfigRepository.store('foo', 'some data')
        end

        it "returns a 200 and a correct json response object" do
            get '/pages'
            expect(last_response.ok?).to be true
            expect(last_response.status).to eq(200)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq({ 'foo': 'some data' }.to_json)
        end
    end

    describe 'GET /pages/:id' do
    end

    describe 'POST /pages' do
    end

    describe 'PUT /pages/foo' do
    end

    describe 'DELETE /pages/foo' do
    end
  end
end
