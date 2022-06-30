# frozen_string_literal: true

# European releases have a lot of edge cases,
# so simple regex won't cut it.
# TODO: Awful code, refactor lol
class EuropeFilter
  EU_TAG = ['Europe'].freeze
  EU_TAGS = [EU_TAG, 'Spain', 'Germany', 'Italy', 'Netherlands', 'United Kingdom', 'France'].freeze

  EN_TAG = 'En'
  LANG_TAGS = ['Fr', 'De', 'Es', 'It', 'Nl', 'Pt', 'Sv', 'No', 'Da', 'Fi', EN_TAG].freeze

  attr_reader :games

  def initialize(games)
    @games = games
  end

  def english_eu_releases
    # eu games
    # find all with En tag, prioritize Europe release
    # Edge case: will there ever be a Europe game without lang tags, but other country releases with them?
    #   If so, how can we be sure that the Europe release includes English?
    #   Do we just assume? Get En to be safe? Keep both to test manually?
    eu_releases = eu_games(games)
    en_eu_releases = english_games(eu_releases)

    en_eu_releases = eu_releases if en_eu_releases.empty?

    if en_eu_releases.size > 1
      en_eu_releases.select { |game| game.match?(tag_regex([EU_TAG])) }
    else
      en_eu_releases
    end
  end

  def eu_games(games)
    games.select { |game| game.match?(eu_tag_regex) }
  end

  # TODO
  # if it has language tags that DON'T include En, look for other
  # reviewing TODO, yeah, what if all EU releases aren't english? Still keep?
  # Add test for that.
  def english_games(games)
    games.select do |game|
      game.match?(all_lang_tags_regex) && game.match?(en_tag_regex)
    end
  end

  private

  def eu_tag_regex
    @eu_tag_regex ||= tag_regex(EU_TAGS)
  end

  def all_lang_tags_regex
    @all_lang_tags_regex ||= lang_tag_regex(LANG_TAGS)
  end

  def en_tag_regex
    @en_tag_regex ||= lang_tag_regex([EN_TAG])
  end

  def lang_tag_regex(langs)
    /\(.*#{langs.join('|')}(,[a-zA-Z]{2})?\)/
  end

  def tag_regex(tags)
    /\(.*#{tags.join('|')}.*\)/
  end
end
