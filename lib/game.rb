require './lib/country_filter'
require './lib/revision_filter'
require './lib/unfinished_filter'

class Game
  attr_accessor :versions

  def initialize(versions = [])
    @versions = versions
  end

  def versions_to_keep
    filtered = filter_unfinished(versions)
    filtered = filter_countries(filtered)
    filter_revisions(filtered)
  end

  private

  def filter_countries(list)
    CountryFilter.new(list).prioritized_countries
  end

  def filter_revisions(list)
    RevisionFilter.new(list).highest_revisions
  end

  def filter_unfinished(list)
    UnfinishedFilter.new(list).final_releases
  end

end