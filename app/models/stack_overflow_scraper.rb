class StackOverflowScraper < Scraper
  require 'nokogiri'
  require 'open-uri'

  attr_reader :target_url, :search_params, :doc

  TARGET_URL = "http://careers.stackoverflow.com/jobs/feed?"

  def initialize(search_params = {})
    @target_url = self.class::TARGET_URL
    @search_params = search_params
    super()
  end

  def scrape
    assemble_query
    @doc = Nokogiri::HTML(open(@target_url))
    process_jobs
  end

  def assemble_query
    pairs = []
    keywords, location, distance = "searchTerm", "location", "range"
    sub = Regexp.new("(keywords|location|distance|)")
    @search_params.each do |key, val|
      pair = "#{key}=#{val}"
      pairs << pair.gsub(sub, {'keywords' => keywords, 'location' => location, 'distance' => distance})
    end
    @target_url += pairs.join('&')
  end

  def process_jobs
    @doc.css('item').each do |element|
      listing = {}
      listing['job_title']         = parse_element(element, 'title')
      listing['link']              = parse_element(element, 'guid')
      listing['job_description']   = parse_element(element, 'description')
      listing['creation_time']     = parse_element(element, 'pubDate')
      listing['skills']            = parse_element(element, 'categories')
      post_listing(listing)
    end
  end

  def parse_element(element, name)
    parsed = element.css(name)
    if parsed.length > 0
      element.css(name).tap do |e|
        return name =~ /categories/ ? e.inject([]) { |arr, cat| arr << cat.to_str } : e[0].to_str
      end
    else
      return ""
    end
  end
end
