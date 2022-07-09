require './lib/game_parser'

describe GameParser do
  let(:parser) { GameParser }

  describe '.parse' do
    subject(:parsed) { parser.parse(game) }

    # FIXME: Is it possible to have no tags? If so, it's not working lol
    context "when no tags" do
      let(:game) { 'Bubsy II.zip' }

      it "should correctly split game" do
        expect(parsed[0]).to eq('Bubsy II')
        expect(parsed[1]).to eq('')
        expect(parsed[2]).to eq('.zip')
      end
    end

    context "when single tag" do
      let(:game) { 'Bubsy II (Europe).zip' }

      it "should correctly split game" do
        expect(parsed[0]).to eq('Bubsy II')
        expect(parsed[1]).to eq('(Europe)')
        expect(parsed[2]).to eq('.zip')
      end
    end

    context "when multiple tags" do
      let(:game) { 'Bugs Bunny Collecton (Japan) (Rev 1) (SGB Enhanced).zip' }

      it "should correctly split game" do
        expect(parsed[0]).to eq('Bugs Bunny Collecton')
        expect(parsed[1]).to eq('(Japan) (Rev 1) (SGB Enhanced)')
        expect(parsed[2]).to eq('.zip')
      end
    end
  end

  describe ".name_for" do
    subject(:name) { parser.name_for(game) }

    context "when multiple tags" do
      let(:game) { 'Bugs Bunny Collecton (Japan) (Rev 1) (SGB Enhanced).zip' }

      it "should return correct game name" do
        expect(name).to eq('Bugs Bunny Collecton')
      end
    end
  end
end