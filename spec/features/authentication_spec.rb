require 'spec_helper'

describe "Authentication" do

  context "unregistered visitors" do
    it "shows the home page" do
      visit root_path
      expect(page).to have_content(I18n.t(".site.dashboard"))
    end

    it "shows a login option" do
      visit root_path
      expect(page).to have_content(I18n.t(".devise.sessions.sign_in"))
    end

    it "doesn't show options for profile and settings" do
      visit root_path
      expect(page).not_to have_content(I18n.t('.users.my_profile'))
      expect(page).not_to have_content(I18n.t('.users.settings'))
    end

    it "doesn't show the countries menu option" do
      visit root_path
      expect(page).not_to have_content(I18n.t(".countries.index_title"))
    end
      
    it "doesn't show the user's visits menu option" do
      visit root_path
      expect(page).not_to have_content(I18n.t(".visits.my_index_title"))
    end

    it "shows the leagues menu option" do
      visit root_path
      expect(page).to have_content(I18n.t(".leagues.index_title"))
    end

    it "shows the clubs menu option" do
      visit root_path
      expect(page).to have_content(I18n.t(".clubs.index_title"))
    end
  end

  describe "registered users" do
    context "users" do
      let!(:user)   { create(:user, role: "user") }

      before do
        sign_in(user)
      end

      it "shows the home page" do
        visit root_path
        expect(page).to have_content(I18n.t(".site.dashboard"))
      end

      it "shows options for profile and settings" do
        visit root_path
        expect(page).to have_content(I18n.t('.users.my_profile'))
        expect(page).to have_content(I18n.t('.users.settings'))
      end

      it "doesn't show the countries menu option" do
        visit root_path
        expect(page).not_to have_content(I18n.t(".countries.index_title"))
      end
        
      it "shows the user's visits menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".visits.my_index_title"))
      end

      it "shows the leagues menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".leagues.index_title"))
      end

      it "shows the clubs menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".clubs.index_title"))
      end
    end

    context "admins" do
      let!(:admin)   { create(:user, role: "admin") }

      before do
        sign_in(admin)
      end

      it "shows the home page" do
        visit root_path
        expect(page).to have_content(I18n.t(".site.dashboard"))
      end

      it "shows options for profile and settings" do
        visit root_path
        expect(page).to have_content(I18n.t('.users.my_profile'))
        expect(page).to have_content(I18n.t('.users.settings'))
      end

      it "shows the countries menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".countries.index_title"))
      end
        
      it "shows the user's visits menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".visits.my_index_title"))
      end

      it "shows the leagues menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".leagues.index_title"))
      end

      it "shows the clubs menu option" do
        visit root_path
        expect(page).to have_content(I18n.t(".clubs.index_title"))
      end
    end
  end

end