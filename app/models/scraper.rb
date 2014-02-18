class Scraper
  # This is basically an abstract class - Don't instantiate this

  require 'nokogiri'
  require 'open-uri'

  TARGET_URL = "http://"

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
end
