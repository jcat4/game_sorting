require './lib/game_grouper'
require 'pry'

describe GameGrouper do
  let(:grouper) { GameGrouper.new(game_versions) }

  describe '#group' do
    subject(:list) { grouper.group }

    context 'when single version for a single game' do
      let(:game_versions) { ['Bubsy II (USA).zip'] }

      it 'returns a single game obj for the version' do
        expect(list.size).to eq(1)
        expect(list.first.versions).to contain_exactly('Bubsy II (USA).zip')
      end
    end

    context 'when multiple versions for a single game' do
      let(:game_versions) do
        [
          'Bubsy II (Europe).zip',
          'Bubsy II (USA).zip'
        ]
      end

      it 'returns a single game obj for each version' do
        expect(list.size).to eq(1)
        expect(list.first.versions).to contain_exactly(
          'Bubsy II (Europe).zip',
          'Bubsy II (USA).zip'
        )
      end
    end

    context 'when multiple games with multiple versions' do
      let(:game_versions) do
        [
          'Bubsy II (Europe).zip',
          'Bubsy II (USA).zip',
          'Bugs Bunny Collection (Japan) (Rev 1) (SGB Enhanced).zip',
          'Bugs Bunny Collection (Japan) (SGB Enhanced).zip',
          'Bugs Bunny Crazy Castle 2, The (USA).zip',
          'Bugs Bunny Crazy Castle, The (USA, Europe).zip'
        ]
      end

      it 'returns a game object for each game' do
        expect(list.size).to eq(4)
        expect(list[0].versions).to contain_exactly(
          'Bubsy II (Europe).zip',
          'Bubsy II (USA).zip'
        )
        expect(list[1].versions).to contain_exactly(
          'Bugs Bunny Collection (Japan) (Rev 1) (SGB Enhanced).zip',
          'Bugs Bunny Collection (Japan) (SGB Enhanced).zip'
        )
        expect(list[2].versions).to contain_exactly(
          'Bugs Bunny Crazy Castle 2, The (USA).zip'
        )
        expect(list[3].versions).to contain_exactly(
          'Bugs Bunny Crazy Castle, The (USA, Europe).zip'
        )
      end
    end
  end
end
