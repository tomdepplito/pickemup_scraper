# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
PickemupScraper::Application.initialize!

ENV["PICKEMUP_URL"] = Rails.env.production? ? "http://pickemup.me" : "http://127.0.0.1:8080"
