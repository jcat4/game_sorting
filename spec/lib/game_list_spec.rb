require './lib/game_list'

describe GameList do
  let(:list) { GameList.new(games) }

  describe "#games_to_keep" do
    subject(:keepers) { list.games_to_keep }

    context "when some unreleased, mutiple revisions" do
      let(:games) {[
        "Donkey Kong Land III (USA, Europe) (Beta)",
        "Donkey Kong Land III (USA, Europe) (Rev 1) (SGB Enhanced)",
        "Donkey Kong Land III (USA, Europe) (SGB Enhanced)",
      ]}

      it "should return non-beta, highest revision game" do
        expect(keepers).to contain_exactly("Donkey Kong Land III (USA, Europe) (Rev 1) (SGB Enhanced)")
      end
    end

    context "when multiple regions, and some unreleased" do
      let(:games) {[
        "Go! Go! Tank (Japan) (Beta)",
        "Go! Go! Tank (Japan)",
        "Go! Go! Tank (USA)",
        "Go! Go! Tank (USA) (Beta)",
      ]}

      it "should return official USA release" do
        expect(keepers).to contain_exactly("Go! Go! Tank (USA)")
      end
    end
  end

end