require 'spec_helper'

describe "Countries" do
  let!(:country){ create(:country) }

  context "unregistered visitors" do
    it "disallows access to countries overview" do
      visit countries_path
      expect(page).not_to have_content(I18n.t(".countries.index_title"))
      expect(page).not_to have_content(country.name)
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "registered users" do
    context "user" do
      let!(:user)   { create(:user, role: "user") }

      before do
        sign_in(user)
      end

      it "disallows access to countries overview" do
        visit countries_path
        expect(page).not_to have_content(I18n.t(".countries.index_title"))
        expect(page).not_to have_content(country.name)
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "admin" do
      let!(:admin)   { create(:user, role: "admin") }

      before do
        sign_in(admin)
      end

      it "allows access to countries overview" do
        visit countries_path
        expect(page).to have_content(I18n.t(".countries.index_title"))
        expect(page).to have_content(country.name)
      end

      it "shows crud links" do
        visit countries_path
        expect(page).to have_content(I18n.t(".countries.new_title"))
        expect(page).to have_content(I18n.t(".helpers.edit"))
        expect(page).to have_content(I18n.t(".helpers.destroy"))
      end

      it "can add a new country" do
        visit countries_path
        first(:link, I18n.t(".countries.new_title")).click

        fill_in "country_name", with: "Scotland"
        fill_in "country_name_short", with: "SCO"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".countries.messages.created"))
        expect(page).to have_content("Scotland")
      end

      it "can edit an country" do
        visit countries_path
        expect(page).to have_content("England")

        first(:link, I18n.t(".helpers.edit")).click

        fill_in "country_name", with: "Ireland"
        fill_in "country_name_short", with: "IRL"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".countries.messages.updated"))
        expect(page).to have_content("Ireland")
        expect(page).not_to have_content(country.name)
      end

      it "can delete a country", js: true do
        visit countries_path
        first(:link, I18n.t(".helpers.destroy")).click

        expect(page).to have_content(I18n.t(".countries.messages.deleted"))
        expect(page).not_to have_content(country.name)
      end
    end
  end
end
