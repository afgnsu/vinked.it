require 'spec_helper'

describe "Leagues" do
  let!(:league){ create(:league) }

  context "unregistered visitors" do
    it "allows access to the leagues overview" do
      visit leagues_path
      expect(page).to have_content(I18n.t(".leagues.index_title"))
      expect(page).to have_content(league.name)
    end

    it "doesn't show crud links" do
      visit leagues_path
      expect(page).not_to have_content(I18n.t(".leagues.new_title"))
      expect(page).not_to have_content(I18n.t(".helpers.edit"))
      expect(page).not_to have_content(I18n.t(".helpers.destroy"))
    end

    it "disallows adding a league" do
      visit new_league_path
      expect(page).not_to have_content(I18n.t(".leagues.new_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end

    it "disallows editing a league" do
      visit edit_league_path(league)
      expect(page).not_to have_content(I18n.t(".leagues.edit_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "registered users" do
    context "user" do
      let!(:user)   { create(:user, role: "user") }

      before do
        sign_in(user)
      end

      it "allows access to leagues overview" do
        visit leagues_path
        expect(page).to have_content(I18n.t(".leagues.index_title"))
        expect(page).to have_content(league.name)
      end

      it "doesn't show crud links" do
        visit leagues_path
        expect(page).not_to have_content(I18n.t(".leagues.new_title"))
        expect(page).not_to have_content(I18n.t(".helpers.edit"))
        expect(page).not_to have_content(I18n.t(".helpers.destroy"))
      end

      it "disallows adding a league" do
        visit new_league_path
        expect(page).not_to have_content(I18n.t(".leagues.new_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end

      it "disallows editing a league" do
        visit edit_league_path(league)
        expect(page).not_to have_content(I18n.t(".leagues.edit_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "admin" do
      let!(:admin)   { create(:user, role: "admin") }

      before do
        sign_in(admin)
      end

      it "allows access to leagues overview" do
        visit leagues_path
        expect(page).to have_content(I18n.t(".leagues.index_title"))
        expect(page).to have_content(league.name)
      end

      it "shows crud links" do
        visit leagues_path
        expect(page).to have_content(I18n.t(".leagues.new_title"))
        expect(page).to have_content(I18n.t(".helpers.edit"))
        expect(page).to have_content(I18n.t(".helpers.destroy"))
      end

      it "can add a new league" do
        visit leagues_path
        first(:link, I18n.t(".leagues.new_title")).click

        fill_in "league_name", with: "The Championship"
        select "2", from: "league.level"
        select "England", from: "league_country_id"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".leagues.messages.created"))
        expect(page).to have_content("The Championship")
      end

      it "can edit a league" do
        visit leagues_path
        first(:link, I18n.t(".helpers.edit")).click

        fill_in "league_name", with: "League One"
        select "3", from: "league.level"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".leagues.messages.updated"))
        expect(page).to have_content("League One")
        expect(page).not_to have_content(league.name)
      end

      it "can delete a league", js: true do
        visit leagues_path
        first(:link, I18n.t(".helpers.destroy")).click

        expect(page).to have_content(I18n.t(".leagues.messages.deleted"))
        expect(page).not_to have_content(league.name)
      end
    end
  end
end