require './lib/country_filter'

describe CountryFilter do
  let(:filter) { CountryFilter.new(list) }

  describe "#prioritized_countries" do
    subject(:filtered) { filter.prioritized_countries }

    context "multiple country releases" do
      let(:list) {[
        "Bionic Commando (Europe)",
        "Bionic Commando (Japan)",
        "Bionic Commando (USA)",
      ]}

      it "should only return USA" do
        expect(filtered).to contain_exactly("Bionic Commando (USA)")
      end
    end

    context "only japan and europe releases" do
      let(:list) {[
        "Bionic Commando (Europe)",
        "Bionic Commando (Japan)",
      ]}

      it "should only return Europe" do
        expect(filtered).to contain_exactly("Bionic Commando (Europe)")
      end
    end

    context "only japan release" do
      let(:list) {[
        "Bionic Commando (Japan)",
      ]}

      it "should only return Japan" do
        expect(filtered).to contain_exactly("Bionic Commando (Japan)")
      end
    end

    # context "only european releases (weird case)" do
    #   let(:list) {[
    #     "Asterix & Obelix (Europe) (Fr,De) (Beta) (SGB Enhanced)",
    #     "Asterix & Obelix (Europe) (Fr,De) (SGB Enhanced)",
    #     "Asterix & Obelix (Spain) (En,Es) (SGB Enhanced)"
    #   ]}

    #   it "should only return English European titles" do

    #   end
    # end
  end
end