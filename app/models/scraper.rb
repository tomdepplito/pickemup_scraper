class Scraper # This is basically an abstract class - Don't instantiate this

  include HTTParty
  require 'nokogiri'
  require 'open-uri'

  TARGET_URL = "http://"
  PICKEMUP_POST_TIMEOUT = 3

  attr_reader :target_url, :search_params, :doc

  def initialize(search_params)
    @target_url = self.class::TARGET_URL
    @search_params = search_params
    scrape
  end

  def listings
  end

  private

  def scrape
    assemble_query
    @doc = Nokogiri::HTML(open(@target_url))
  end

  def assemble_query
  end

  def post_listing(listing)
    begin
      Timeout::timeout(PICKEMUP_POST_TIMEOUT) do
        return HTTParty.post(ENV["PICKEMUP_URL"] + "/external_job_listings/save_listing", body: {:job_listing => listing}.to_json, :headers => { 'Content-Type' => 'application/json' })
      end
    rescue
    end
  end
end
