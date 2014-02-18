class StackOverflowScraper < Scraper
  TARGET_URL = "http://careers.stackoverflow.com/jobs/feed?"

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

  def listings
    @doc.css('item').each do |element|
      title = element.css('title')[0].to_str
      link = element.css('guid')[0].to_str
      description = element.css('description')[0].to_str
      pub_date = element.css('pubDate')[0].to_str
      categories = element.css('categories').inject([]) { |arr, cat| arr << cat.to_str }
      # Post to pickemup site
      # Also, DRY up this method
    end
  end
end
