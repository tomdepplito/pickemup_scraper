class Scraper # This is basically an abstract class - Don't instantiate this
  include HTTParty
  PICKEMUP_POST_TIMEOUT = 3

  def initialize
    scrape
  end

  private

  def post_listing(listing)
    begin
      Timeout::timeout(PICKEMUP_POST_TIMEOUT) do
        return HTTParty.post(ENV["PICKEMUP_URL"] + "/external_job_listings/save_listing", body: {:job_listing => listing}.to_json, :headers => { 'Content-Type' => 'application/json' })
      end
    rescue
    end
  end
end
