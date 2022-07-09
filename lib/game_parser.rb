# frozen_string_literal: true

# Parses games into name, tags, and extension
class GameParser
  NAME_PATTERN = '([^\(\)]+)'
  TAG_PATTERN  = '(\s+\(.*\))*'
  EXT_PATTERN  = '(\.\S{2,3})'
  PARSE_PATTERN = /#{NAME_PATTERN}#{TAG_PATTERN}#{EXT_PATTERN}/

  def self.parse(game)
    game.match(PARSE_PATTERN)[1..].map { |m| m.to_s.strip }
  end

  def self.name_for(game)
    parse(game)[0]
  end
end