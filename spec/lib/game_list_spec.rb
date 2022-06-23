require './lib/game_list'

describe GameList do
  let(:list) { GameList.new(games) }

  describe '#games_to_keep' do
    subject(:keepers) { list.games_to_keep }

    context 'when some unreleased, mutiple revisions' do
      let(:games) do
        [
          'Donkey Kong Land III (USA, Europe) (Beta)',
          'Donkey Kong Land III (USA, Europe) (Rev 1) (SGB Enhanced)',
          'Donkey Kong Land III (USA, Europe) (SGB Enhanced)'
        ]
      end

      it 'should return non-beta, highest revision game' do
        expect(keepers).to contain_exactly('Donkey Kong Land III (USA, Europe) (Rev 1) (SGB Enhanced)')
      end
    end

    context 'when multiple regions, and some unreleased' do
      let(:games) do
        [
          'Go! Go! Tank (Japan) (Beta)',
          'Go! Go! Tank (Japan)',
          'Go! Go! Tank (USA)',
          'Go! Go! Tank (USA) (Beta)'
        ]
      end

      it 'should return official USA release' do
        expect(keepers).to contain_exactly('Go! Go! Tank (USA)')
      end
    end

    context 'when only beta released in USA, but officially released in EU' do
      let(:games) do
        [
          'Cannon Fodder (Europe) (En,Fr,De,Es,It)',
          'Cannon Fodder (USA) (En,Fr,De,Es,It) (Beta)'
        ]
      end

      it 'should return official Euro release' do
        expect(keepers).to contain_exactly('Cannon Fodder (Europe) (En,Fr,De,Es,It)')
      end
    end
  end
end
