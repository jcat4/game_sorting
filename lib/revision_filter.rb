class RevisionFilter
  REVISION_PATTERN = /\(Rev (\d+)\)/i

  attr_reader :games

  def initialize(games)
    @games = games
  end

  def highest_revisions
    grouped = games.group_by do |game|
      get_revision_number(game)
    end

    grouped[grouped.keys.max]
  end

  private

  def get_revision_number(game_title)
    game_title.match(REVISION_PATTERN)&.captures&.first.to_i
  end
end