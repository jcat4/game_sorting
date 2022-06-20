class CountryFilter
  USA_REGEX =   /\(.*USA\)/
  EU_REGEX =    /\(.*Europe\)/
  JAPAN_REGEX = /\(.*Japan\)/

  attr_reader :games

  def initialize(games)
    @games = games
  end

  # USA > Europe > Japan > others
  def prioritized_countries
    return usa_games if usa_games.any?
    return eu_games if eu_games.any?
    return japan_games if japan_games.any?
    games
  end

  private

  def usa_games
    @usa_games ||= select_by_country(USA_REGEX)
  end

  def eu_games
    @eu_games ||= select_by_country(EU_REGEX)
  end

  def japan_games
    @japan_games ||= select_by_country(JAPAN_REGEX)
  end

  def select_by_country(regex)
    games.select { |game| game.match?(regex) }
  end
end