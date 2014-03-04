module PreferenceConstants
  extend ActiveSupport::Concern

  LOCATION_TAGS = ['San Francisco, CA', 'Portland, OR', 'Seattle, WA',
                   'New York City, NY', 'Chicago, IL', 'Boston, MA',
                   'Austin, TX', 'Los Angeles, CA', 'Cincinnati, OH']

  SKILL_TAGS    = ['Ruby', 'Python', 'Javascript', 'Java', 'PHP', 'Scala', 'C', 'C++', 'C#', 'Objective C', 'Clojure']
end
