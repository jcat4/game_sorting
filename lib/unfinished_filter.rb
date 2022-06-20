# This will filter out any unfinished titles (betas, demos, etc.)
class UnfinishedFilter
  UNRELEASED_TAGS = %w[
    Demo
    Proto
    Beta
    Kiosk
    Possible\ Proto
    Sample
  ]

  attr_reader :games

  def initialize(games)
    @games = games
  end

  # only return unfinished versions if no official releases exist
  def final_releases
    official_releases = games.reject do |game|
      game.match?(unreleased_regex)
    end

    official_releases.empty? \
      ? games
      : official_releases
  end

  private

  def unreleased_regex
    @unreleased_regex ||= /\(.*#{UNRELEASED_TAGS.join("|")}.*\)/
  end
end