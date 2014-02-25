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
      listing['job_title']      = job['title']
      listing['link']           = job['startup']['angellist_url']
      listing['creation_date']  = job['created_at']
      listing['salary_min']     = job['salary_min']
      listing['salary_max']     = job['salary_max']
      listing['company_url']    = job['startup']['company_url']
      listing['categories']     = job['tags'].inject([]) { |arr, tag| arr << tag['name'] }
      post_listing(listing)
    end
  end
end
