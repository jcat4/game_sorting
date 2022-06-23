require './lib/europe_filter'

class CountryFilter
  USA_REGEX =   /\(.*USA\)/
  JAPAN_REGEX = /\(.*Japan\)/
  # TODO: where does Australia fit into all this?

  attr_reader :games

  def initialize(games)
    @games = games
  end

  # USA > Europe > Japan > others
  def prioritized_countries
    return usa_games if usa_games.any?
    return english_eu_games if english_eu_games.any?
    return japan_games if japan_games.any?
    games
  end

  private

  def usa_games
    @usa_games ||= select_by_country(USA_REGEX)
  end

  def english_eu_games
    @english_eu_games ||=
      EuropeFilter.new(games).english_eu_releases
  end

  def japan_games
    @japan_games ||= select_by_country(JAPAN_REGEX)
  end

  def select_by_country(regex)
    games.select { |game| game.match?(regex) }
  end
end