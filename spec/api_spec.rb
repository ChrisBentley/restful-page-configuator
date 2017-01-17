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
        before do
            ConfigRepository.initialize
            ConfigRepository.store('foo', 'some data')
            ConfigRepository.store('foo_two', 'more data')
        end

        it "returns a 200 and the correct json response object for pages/foo" do
            get '/pages/foo'
            expect(last_response.ok?).to be true
            expect(last_response.status).to eq(200)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq('some data'.to_json)
        end

        it "returns a 200 and the correct json response object for pages/foo_two" do
            get '/pages/foo_two'
            expect(last_response.ok?).to be true
            expect(last_response.status).to eq(200)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq('more data'.to_json)
        end

        it "returns a 404 and a 'null' response for pages/foo_three" do
            get '/pages/foo_three'
            expect(last_response.ok?).to be false
            expect(last_response.status).to eq(404)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq('null')
        end
    end

    describe 'POST /pages' do
    end

    describe 'PUT /pages/foo' do
    end

    describe 'DELETE /pages/foo' do
    end
  end
end
