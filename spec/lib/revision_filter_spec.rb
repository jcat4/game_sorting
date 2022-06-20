require './lib/revision_filter'

describe RevisionFilter do
  let(:filter) { RevisionFilter.new(list) }

  describe "#highest_revisions" do
    subject(:filtered) { filter.highest_revisions }

    context "no revisions" do
      let(:list) {[
        "SomeGame (USA)",
        "SomeGame (Europe)",
        "SomeGame (Japan)",
      ]}

      it "should return all games" do
        expect(filtered).to eq(list)
      end
    end

    context "one with rev, one without" do
      let(:list) {[
        "Boxxle (USA)",
        "Boxxle (USA, Europe) (Rev 1)",
      ]}

      it "should return revision 1" do
        expect(filtered).to contain_exactly("Boxxle (USA, Europe) (Rev 1)")
      end
    end

    context "multiple revisions" do
      let(:list) {[
        "SomeGame (USA)",
        "SomeGame (USA) (Rev 1)",
        "SomeGame (USA) (Rev 2)",
      ]}

      it "should return highest revision" do
        expect(filtered).to contain_exactly("SomeGame (USA) (Rev 2)")
      end
    end

    context "multiple revisions, multiple countries" do
      let(:list) {[
        "SomeGame (USA)",
        "SomeGame (USA) (Rev 1)",
        "SomeGame (USA) (Rev 2)",
        "SomeGame (Japan)",
        "SomeGame (Japan) (Rev 1)",
        "SomeGame (Japan) (Rev 2)",
      ]}

      it "should return highest revision for each country" do
        expect(filtered).to contain_exactly(
          "SomeGame (USA) (Rev 2)",
          "SomeGame (Japan) (Rev 2)"
        )
      end
    end
  end

end
