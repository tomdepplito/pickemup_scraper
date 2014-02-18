require 'spec_helper'

describe Scraper do
  let (:scraper) { Scraper.new({}) }

  describe '#new' do
    it 'should have a target URL' do
      scraper.target_url.should =~ /http:\/\//
    end

    it 'should have search params' do
      scraper.search_params.should be_a_kind_of Hash
    end
  end
end

