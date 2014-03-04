class AngelListScraper < Scraper

  private

  def scrape
    first_query = AngellistApi.get_jobs
    num_pages = first_query.last_page
    first_query.jobs.each { |job| process_job(job) }
    (2..num_pages).each do |page_num|
      AngellistApi.get_jobs({:page => page_num})['jobs'].each { |job| process_job(job) }
    end
  end

  def process_job(job)
    role = job['tags'].detect { |tag| tag['tag_type'] == "RoleTag" }['name']
    if role =~ /developer/
      listing = {}
      listing['job_title']            = job['title']
      listing['link']                 = job['startup']['angellist_url']
      listing['creation_time']        = job['created_at']
      listing['salary_range_low']     = job['salary_min']
      listing['salary_range_high']    = job['salary_max']
      listing['company_url']          = job['startup']['company_url']
      listing['locations']            = normalize_params(job, 'LocationTag')
      listing['acceptable_languages'] = normalize_params(job, 'SkillTag')
      binding.pry
      post_listing(listing)
    end
  end

  def normalize_params(job, tag_type)
    tags = []
    job['tags'].each do |tag|
      if tag['tag_type'] == tag_type
        normalized_name = "PreferenceConstants::#{tag_type.pluralize.underscore.upcase}".constantize.detect { |pref| pref =~ Regexp.new(tag['display_name']) } || tag['display_name']
        tags << normalized_name
      end
    end
    tags
  end
end
