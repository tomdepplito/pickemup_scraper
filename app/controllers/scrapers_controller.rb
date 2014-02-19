class ScrapersController < ApplicationController
  include HTTParty

  def get_token
    scraper = AngelListScraper.new({})
    client = OAuth2::Client.new(ENV["ANGEL_LIST_CLIENT_ID"], ENV["ANGEL_LIST_CLIENT_SECRET"], :site => scraper.target_url)
    c = HTTParty.post("https://angel.co/api/oauth/authorize?response_type=code&client_id=8985610c29378fff7889a906a6e7f320&redirect_uri=http://localhost:8080/oauth/callback")
    client.auth_code.authorize_url(:redirect_uri => 'http://localhost:8080/oauth2/callback', :url => scraper.target_url)
    token = client.auth_code.get_token('', :redirect_uri => 'http://localhost:8080/oauth2/callback', :headers => {})
    response = token.get('/1/jobs', :params => {})
    response.class.name
  end
end
