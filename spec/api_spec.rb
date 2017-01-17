require 'spec_helper'
require 'rack/test'

module PageConfigurator
  describe Api do
    include Rack::Test::Methods

    let(:app) { PageConfigurator::Api.new }

    describe 'GET /pages' do
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
