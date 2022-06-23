require './lib/europe_filter'

describe EuropeFilter do
  let(:filter) { EuropeFilter.new(list) }

  describe '#eu_games' do
    subject(:eu_games) { filter.eu_games(list) }

    context 'multiple country releases' do
      let(:list) do
        [
          'Bionic Commando (Europe)',
          'Bionic Commando (Japan)',
          'Bionic Commando (USA)'
        ]
      end

      it 'should only return Europe' do
        expect(eu_games).to contain_exactly('Bionic Commando (Europe)')
      end
    end

    context 'multiple EU releases' do
      let(:list) do
        [
          'Bionic Commando (USA)',
          'Bionic Commando (Japan)',
          'Bionic Commando (Europe)',
          'Bionic Commando (Spain)',
          'Bionic Commando (Germany)',
          'Bionic Commando (France)',
          'Bionic Commando (Italy)',
          'Bionic Commando (Netherlands)',
          'Bionic Commando (United Kingdom)'
        ]
      end

      it 'should only return Europe' do
        expect(eu_games).to contain_exactly(
          'Bionic Commando (Europe)',
          'Bionic Commando (Spain)',
          'Bionic Commando (Germany)',
          'Bionic Commando (France)',
          'Bionic Commando (Italy)',
          'Bionic Commando (Netherlands)',
          'Bionic Commando (United Kingdom)'
        )
      end
    end
  end

  describe '#english_games' do
    subject(:en_games) { filter.english_games(list) }

    context 'when only non-Euro English release' do
      let(:list) do
        [
          'Asterix & Obelix (Europe) (Fr,De) (Beta) (SGB Enhanced)',
          'Asterix & Obelix (Europe) (Fr,De) (SGB Enhanced)',
          'Asterix & Obelix (Spain) (En,Es) (SGB Enhanced)'
        ]
      end

      it 'should only return the english release' do
        expect(en_games).to contain_exactly('Asterix & Obelix (Spain) (En,Es) (SGB Enhanced)')
      end
    end
  end

  describe '#english_eu_releases' do
    subject(:en_eu_releases) { filter.english_eu_releases }

    context 'when Europe and other US releases' do
      let(:list) do
        [
          'SomeGame (Europe) (En,Es)',
          'SomeGame (Spain) (En,Es)'
        ]
      end

      it 'should prioritize Europe release' do
        expect(en_eu_releases).to contain_exactly('SomeGame (Europe) (En,Es)')
      end
    end

    context 'no Europe releases with explicit English tag' do
      let(:list) do
        [
          'SomeGame (Europe)',
          'SomeGame (Spain)',
          'SomeGame (Germany)'
        ]
      end

      it 'should prioritize Europe release' do
        expect(en_eu_releases).to contain_exactly('SomeGame (Europe)')
      end
    end

    context 'when ome lang tags, but no explicit English tags' do
      let(:list) do
        [
          'SomeGame (Europe)',
          'SomeGame (Spain) (Es)',
          'SomeGame (Germany) (Da)'
        ]
      end

      it 'should prioritize Europe release (hopefully English)' do
        expect(en_eu_releases).to contain_exactly('SomeGame (Europe)')
      end
    end
  end
end
