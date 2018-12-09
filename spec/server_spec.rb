require_relative '../app/server.rb'
require 'rack/test'

set :environment, :test

# Tests for server.rb
describe 'Server' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  describe '/ad/validate' do
    # Test for HTTP POST for URL-matching pattern '/'
    it 'should return successfully on POST' do
      post '/ad/validate'
      expect(last_response).to be_ok
      json_result = JSON.parse(last_response.body)

      expect(json_result['errors']).to be_empty
    end
  end
end
