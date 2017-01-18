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
            ConfigRepository.initialize
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
            expect(last_response.headers['Content-Type']). to eq("text/plain")
            expect(last_response.body).to eq('404 not found')
        end
    end

    describe 'POST /pages' do
    end

    describe 'PUT /pages/foo' do
        before do
            ConfigRepository.initialize
            ConfigRepository.store('foo', 'some data')
        end

        it "returns a 200 (successful update) and the correct json response object for pages/foo" do
            put '/pages/foo', { 'value' => 'different data' }.to_json, "CONTENT_TYPE" => "application/json"
            expect(last_response.ok?).to be true
            expect(last_response.status).to eq(200)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq('different data'.to_json)
        end

        it "returns a 201 (successful creation) and the correct json response object for pages/new_foo" do
            put '/pages/new_foo', { 'value' => 'new data' }.to_json, "CONTENT_TYPE" => "application/json"
            expect(last_response.status).to eq(201)
            expect(last_response.headers['Content-Type']). to eq("application/json")
            expect(last_response.body).to eq('new data'.to_json)
        end

        it "returns a 406 (not acceptable) when the wrong content type is specified" do
            put '/pages/new_foo', { 'value' => 'new data' }.to_json, "CONTENT_TYPE" => "text/plain"
            expect(last_response.ok?).to be false
            expect(last_response.status).to eq(406)
            expect(last_response.headers['Content-Type']). to eq("text/plain")
            expect(last_response.body).to eq('Content-Type must be application/json.')
        end

        it "returns a 400 (bad request) when the provided json is not parseable" do
            put '/pages/new_foo', 'this isn\'t json', "CONTENT_TYPE" => "application/json"
            expect(last_response.ok?).to be false
            expect(last_response.status).to eq(400)
            expect(last_response.headers['Content-Type']). to eq("text/plain")
            expect(last_response.body).to eq('Provided JSON was invalid.')
        end
    end

    describe 'DELETE /pages/foo' do
        before do
            ConfigRepository.initialize
            ConfigRepository.store('foo', 'some data')
        end

        it "returns a 200 (successful deletion) and the correct response message for pages/foo" do
            delete '/pages/foo'
            expect(last_response.ok?).to be true
            expect(last_response.status).to eq(200)
            expect(last_response.headers['Content-Type']). to eq("text/plain")
            expect(last_response.body).to eq('foo successfully deleted.')
        end

        it "returns a 404 (not found) and the correct response message for pages/foo_non_existant" do
            delete '/pages/foo_non_existant'
            expect(last_response.ok?).to be false
            expect(last_response.status).to eq(404)
            expect(last_response.headers['Content-Type']). to eq("text/plain")
            expect(last_response.body).to eq('404 not found')
        end
    end
  end
end
