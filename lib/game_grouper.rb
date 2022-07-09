require './lib/game'
require './lib/game_parser'

# parses and groups list of game versions into an array of game objects
class GameGrouper
  attr_reader :game_versions

  def initialize(game_versions)
    @game_versions = game_versions
  end

  def group
    grouped = game_versions.group_by do |version|
      name_for(version)
    end

    grouped.map do |_, versions|
      Game.new(versions)
    end
  end

  private

  def name_for(game_version)
    GameParser.name_for(game_version)
  end
end
