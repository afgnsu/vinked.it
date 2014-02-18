require 'spec_helper'

describe "Leagues" do
  let!(:league){ create(:league) }

  context "unregistered visitors" do
    it "disallows access to the leagues overview" do
      visit leagues_path
      expect(page).not_to have_content(I18n.t(".leagues.index_title"))
      expect(page).not_to have_content(league.name)
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "registered users" do
    context "basic subscription" do
      let!(:user)   { create(:user, role: "user", subscription: "basic") }

      before do
        sign_in(user)
      end

      it "disallows access to leagues overview" do
        visit leagues_path
        expect(page).not_to have_content(I18n.t(".leagues.index_title"))
        expect(page).not_to have_content(league.name)
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "premium subscription" do
      let!(:user)   { create(:user, role: "user", subscription: "premium") }

      before do
        sign_in(user)
      end

      it "disallows access to leagues overview" do
        visit leagues_path
        expect(page).not_to have_content(I18n.t(".leagues.index_title"))
        expect(page).not_to have_content(league.name)
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "admin" do
      let!(:admin)   { create(:user, role: "admin", subscription: "premium") }

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

        fill_in "league[name]", with: "The Championship"
        select "England", from: "league_country_id"
        fill_in "league[level]", with: "2"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".leagues.messages.created"))
        expect(page).to have_content("The Championship")
      end

      it "can edit a league" do
        visit leagues_path
        first(:link, I18n.t(".helpers.edit")).click

        fill_in "league[name]", with: "League One"
        fill_in "league[level]", with: "3"
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