require 'spec_helper'

describe "Clubs" do
  let!(:club){ create(:club) }

  context "unregistered visitors" do
    it "allows access to the clubs overview" do
      visit clubs_path
      expect(page).to have_content(I18n.t(".clubs.index_title"))
      expect(page).to have_content(club.name)
    end

    it "doesn't show crud links" do
      visit clubs_path
      expect(page).not_to have_content(I18n.t(".leagues.new_title"))
      expect(page).not_to have_content(I18n.t(".helpers.edit"))
      expect(page).not_to have_content(I18n.t(".helpers.destroy"))
    end

    it "disallows adding a club" do
      visit new_club_path
      expect(page).not_to have_content(I18n.t(".clubs.new_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end

    it "disallows editing a club" do
      visit edit_club_path(club)
      expect(page).not_to have_content(I18n.t(".clubs.edit_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "registered users" do
    context "user" do
      let!(:user)   { create(:user, role: "user") }

      before do
        sign_in(user)
      end

      it "allows access to the clubs overview" do
        visit clubs_path
        expect(page).to have_content(I18n.t(".clubs.index_title"))
        expect(page).to have_content(club.name)
      end

      it "doesn't show crud links" do
        visit clubs_path
        expect(page).not_to have_content(I18n.t(".leagues.new_title"))
        expect(page).not_to have_content(I18n.t(".helpers.edit"))
        expect(page).not_to have_content(I18n.t(".helpers.destroy"))
      end

      it "disallows adding a club" do
        visit new_club_path
        expect(page).not_to have_content(I18n.t(".clubs.new_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end

      it "disallows editing a club" do
        visit edit_club_path(club)
        expect(page).not_to have_content(I18n.t(".clubs.edit_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "admin" do
      let!(:admin) { create(:user, role: "admin") }
      let!(:league){ create(:league, name: "The Championship") }

      before do
        sign_in(admin)
      end

      it "allows access to clubs overview" do
        visit clubs_path
        expect(page).to have_content(I18n.t(".clubs.index_title"))
        expect(page).to have_content(club.name)
      end

      it "shows crud links" do
        visit clubs_path
        expect(page).to have_content(I18n.t(".clubs.new_title"))
        expect(page).to have_content(I18n.t(".helpers.edit"))
        expect(page).to have_content(I18n.t(".helpers.destroy"))
      end

      it "can add a new club" do
        visit clubs_path
        first(:link, I18n.t(".clubs.new_title")).click

        fill_in "club_name", with: "Charlton Athletic"
        select "The Championship", from: "club_league_id"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".clubs.messages.created"))
        expect(page).to have_content("Charlton Athletic")
        expect(page).to have_content("The Championship")
      end

      it "can edit a club" do
        visit clubs_path
        first(:link, I18n.t(".helpers.edit")).click

        fill_in "club_name", with: "Millwall"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".clubs.messages.updated"))
        expect(page).to have_content("Millwall")
        expect(page).not_to have_content(club.name)
      end

      it "can delete a club", js: true do
        visit clubs_path
        first(:link, I18n.t(".helpers.destroy")).click

        expect(page).to have_content(I18n.t(".clubs.messages.deleted"))
        expect(page).not_to have_content(club.name)
      end
    end
  end
end