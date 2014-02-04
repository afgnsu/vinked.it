require 'spec_helper'

describe VinkCalculator do
  let!(:club){ create(:club) }
  let!(:user){ create(:user) }

  describe "assign_vink_nr" do
    context "vinks already available" do
      let!(:vink1){ create(:vink, vink_nr: 1, club: club, user: user) }
      let!(:vink2){ create(:vink, vink_nr: 2, club: club, user: user) }

      it "assigns a vink_nr" do
        expect(VinkCalculator.new(user).assign_vink_nr).to eq 3
      end
    end

    context "no vinks available" do
      it "assigns a vink_nr" do
        expect(VinkCalculator.new(user).assign_vink_nr).to eq 1
      end
    end
  end
end