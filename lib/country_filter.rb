class CountryFilter
  attr_reader :games

  def initialize(games)
    @games = games
  end

  def filter_countries
    return usa_games if usa_games.any?
    return eu_games if eu_games.any?
    return japan_games if japan_games.any?
    games
  end

  private

  def usa_games
    games.select { |game| game.match? /\(.*USA\)/ }
  end

  def eu_games
    games.select { |game| game.match? /\(.*Europe\)/ }
  end

  def japan_games
    games.select { |game| game.match? /\(.*Japan\)/ }
  end
end