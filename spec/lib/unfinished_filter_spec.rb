require './lib/unfinished_filter'

describe UnfinishedFilter do
  let(:filter) { UnfinishedFilter.new(list) }

  describe "#final_releases" do
    subject(:filtered) { filter.final_releases }

    context "when only official releases" do
      let(:list) {[
        "Boxxle (USA)",
        "Boxxle (USA, Europe) (Rev 1)",
      ]}

      it "should return full list" do
        expect(filtered).to eq(list)
      end
    end

    # Capture all unreleased tags you can find into this single test
    context "when multiple unreleased versions" do
      let(:list) {[
        "SomeGame",
        "SomeGame (Demo)",
        "SomeGame (Proto)",
        "SomeGame (Beta)",
        "SomeGame (Kiosk)",
        "SomeGame (Possible Proto)",
        "SomeGame (Sample)",  # don't actually know what this is
      ]}

      it "should only return official releases" do
        expect(filtered).to contain_exactly("SomeGame")
      end
    end

    context "when ONLY unreleased versions exist" do
      let(:list) {[
        "SomeGame (Demo)",
        "SomeGame (Proto)",
        "SomeGame (Beta)",
      ]}

      it "should return full list" do
        expect(filtered).to eq(list)
      end
    end
  end

end