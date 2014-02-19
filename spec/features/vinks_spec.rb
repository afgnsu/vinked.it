require 'spec_helper'

describe "Vinks" do
  let!(:club1){ create(:club, name: "Arsenal") }
  let!(:club2){ create(:club, name: "Chelsea") }
  let!(:club3){ create(:club, name: "Everton") }
  let!(:club4){ create(:club, name: "Hull City") }

  shared_examples "club_checks" do
    it "allows access to clubs overview to see own clubs" do
      visit clubs_path(view: "own")
      expect(page).to have_content(club1.name)
      expect(page).not_to have_content(club2.name)
      expect(page).not_to have_content(club3.name)
      expect(page).not_to have_content(club4.name)
    end

    it "allows access to clubs overview to see latest clubs" do
      visit clubs_path(view: "latest")
      expect(page).to have_content(club1.name)
      expect(page).to have_content(club2.name)
      expect(page).to have_content(club3.name)
      expect(page).to have_content(club4.name)
    end

    it "allows access to clubs overview to see all clubs" do
      visit clubs_path(view: "all")
      expect(page).to have_content(club1.name)
      expect(page).to have_content(club2.name)
      expect(page).to have_content(club3.name)
      expect(page).to have_content(club4.name)
    end
  end

  shared_examples "own_vink_list" do
    it "shows vink details" do
      visit root_path
      expect(page).to have_content(vink.club.name)
      expect(page).to have_content(vink.vink_nr)
      expect(page).to have_content(vink.vink_date.strftime("%d-%m-%Y"))
      expect(page).to have_content("1 clubs")
      expect(page).to have_content("1 vinkedit's")
    end
  end

  context "unregistered visitors" do
    it "disallows access to the clubs overview" do
      visit clubs_path(view: "all")
      expect(page).not_to have_content(I18n.t(".clubs.all_index_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "subscriptions" do
    context "basic" do
      let!(:user) { create(:user, role: "user", subscription: "basic") }
      let!(:vink) { create(:vink, user: user, club: club1, away_club_id: club2.id) }

      before do
        sign_in(user)
      end

      it_behaves_like "club_checks"
      it_behaves_like "own_vink_list"
    end

    context "premium" do
      let!(:user)   { create(:user, role: "user", subscription: "premium") }
      let!(:vink) { create(:vink, user: user, club: club1, away_club_id: club2.id) }

      before do
        sign_in(user)
      end

      it_behaves_like "club_checks"
      it_behaves_like "own_vink_list"
    end

  end

  describe "admins" do
    let!(:user)   { create(:user, role: "admin", subscription: "premium") }
    let!(:vink) { create(:vink, user: user, club: club1, away_club_id: club2.id) }

    before do
      sign_in(user)
    end

    it_behaves_like "club_checks"
    it_behaves_like "own_vink_list"

  end
end