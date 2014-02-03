require 'spec_helper'

describe "Authentication" do

  context "unregistered visitors" do
    it "shows the home page" do
      visit root_path
      expect(page).not_to have_content(I18n.t('.clubs.index_title'))
    end

    it "shows a login option" do
      visit root_path
      expect(page).to have_content(I18n.t(".devise.sessions.sign_in"))
    end

    it "doesn't show vinked.it's" do
      visit root_path
      expect(page).not_to have_content(I18n.t('.clubs.index_title'))
    end
  end

  describe "registered users" do
    context "basic subscription" do
      let!(:user)   { create(:user, role: "user", subscription: "basic") }

      before do
        sign_in(user)
      end

      it "shows the home page" do
        visit root_path
        expect(page).to have_content(I18n.t('.clubs.index_title'))
      end

      it "shows a logout option" do
        visit root_path
        expect(page).to have_content(I18n.t(".devise.sessions.sign_out"))
      end

      it "shows vinked.it's" do
        visit root_path
        expect(page).to have_content(I18n.t('.clubs.index_title'))
      end
    end

    context "premium subscription" do
      let!(:user)   { create(:user, role: "user", subscription: "premium") }

      before do
        sign_in(user)
      end

      it "shows the home page" do
        visit root_path
        expect(page).to have_content(I18n.t('.clubs.index_title'))
      end

      it "shows a login option" do
        visit root_path
        expect(page).to have_content(I18n.t(".devise.sessions.sign_out"))
      end

      it "shows vinked.it's" do
        visit root_path
        expect(page).to have_content(I18n.t('.clubs.index_title'))
      end
    end
  end
end