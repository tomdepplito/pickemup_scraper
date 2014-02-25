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
      listing = {}
      listing['job_title']         = element.css('title')[0].to_str
      listing['link']          = element.css('guid')[0].to_str
      listing['description']   = element.css('description')[0].to_str
      listing['creation_date'] = element.css('pubDate')[0].to_str
      listing['categories']    = element.css('categories').inject([]) { |arr, cat| arr << cat.to_str }
      post_listing(listing)
    end
  end
end
