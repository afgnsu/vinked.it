require 'spec_helper'

describe VinkCalculator do
  let!(:club){ create(:club) }
  let!(:user){ create(:user) }

  describe "assign_vink_nr" do
    context "vinks already available" do
      let!(:vink1){ create(:vink, vink_nr: 1, club: club, user: user) }
      let!(:vink2){ create(:vink, vink_nr: 2, club: club, user: user) }

      it "assigns a vink_nr" do
        expect(VinkCalculator.new.assign_vink_nr(user)).to eq 3
      end
    end

    context "no vinks available" do
      it "assigns a vink_nr" do
        expect(VinkCalculator.new.assign_vink_nr(user)).to eq 1
      end
    end
  end

  describe "vinked?" do
    let!(:club2){ create(:club) }
    let!(:club3){ create(:club) }
    let!(:vink1){ create(:vink, vink_nr: 1, club: club, user: user) }
    let!(:user2){ create(:user) }
    let!(:vink2){ create(:vink, vink_nr: 1, club: club3, user: user2) }

    it "returns true when club is vinked" do
      expect(VinkCalculator.new.vinked?(club)).to eq true
    end

    it "returns false when club is not vinked" do
      expect(VinkCalculator.new.vinked?(club2)).to eq false
    end

    it "returns true when club is vinked by user" do
      expect(VinkCalculator.new.vinked?(club, user)).to eq true
    end

    it "returns false when club is not vinked by user" do
      expect(VinkCalculator.new.vinked?(club2)).to eq false
    end
  end

  describe "vinks?" do
    let!(:club2){ create(:club) }
    let!(:club3){ create(:club) }
    let!(:vink1){ create(:vink, vink_nr: 1, club: club, user: user) }
    let!(:user2){ create(:user) }
    let!(:vink2){ create(:vink, vink_nr: 1, club: club3, user: user2) }
    let!(:vink3){ create(:vink, vink_nr: 2, club: club3, user: user) }

    it "returns vinks when club is vinked" do
      expect(VinkCalculator.new.vinks?(club)).to eq 1
    end

    it "returns vinks when club is vinked many times" do
      expect(VinkCalculator.new.vinks?(club3)).to eq 2
    end

    it "returns vinks when club is vinked by user" do
      expect(VinkCalculator.new.vinks?(club, user)).to eq 1
    end

    it "returns vinks when club is not vinked by user" do
      expect(VinkCalculator.new.vinks?(club, user2)).to eq 0
    end

    it "returns false when club is vinked by many users" do
      expect(VinkCalculator.new.vinks?(club3)).to eq 2
    end
  end
end
