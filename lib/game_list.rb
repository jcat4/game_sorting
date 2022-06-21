require './lib/country_filter'
require './lib/revision_filter'
require './lib/unfinished_filter'

class GameList
  attr_accessor :games

  def initialize(games = [])
    @games = games
  end

  def games_to_keep
    filtered = filter_countries(games)
    filtered = filter_revisions(filtered)
    filter_unfinished(filtered)
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