require 'spec_helper'

describe "Clubs" do
  let!(:club){ create(:club) }

  context "unregistered visitors" do
    it "disallows access to the clubs overview" do
      visit clubs_path
      expect(page).not_to have_content(I18n.t(".clubs.index_title"))
    end
  end

  describe "subscriptions" do
    context "basic" do
      let!(:user)   { create(:user, role: "user", subscription: "basic") }

      before do
        sign_in(user)
      end

      it "allows access to clubs overview to see own clubs" do
        visit clubs_path(view: "own")
        expect(page).to have_content(I18n.t(".clubs.my_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "allows access to clubs overview to see latest clubs" do
        visit clubs_path(view: "latest")
        expect(page).to have_content(I18n.t(".clubs.latest_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "allows access to clubs overview to see all clubs" do
        visit clubs_path(view: "all")
        expect(page).to have_content(I18n.t(".clubs.all_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "disallows access to clubs overview to maintenance clubs" do
        visit clubs_path
        expect(page).not_to have_content(I18n.t(".clubs.clubs_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end

      it "doesn't show add club button" do
        visit clubs_path(view: "all")
        expect(page).not_to have_content(I18n.t(".clubs.new_title"))
      end

      it "disallows adding a club" do
        visit new_club_path
        expect(page).not_to have_content(I18n.t(".clubs.new_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end
    end

    context "premium" do
      let!(:user)   { create(:user, role: "user", subscription: "premium") }

      before do
        sign_in(user)
      end

      it "allows access to clubs overview to see own clubs" do
        visit clubs_path(view: "own")
        expect(page).to have_content(I18n.t(".clubs.my_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "allows access to clubs overview to see latest clubs" do
        visit clubs_path(view: "latest")
        expect(page).to have_content(I18n.t(".clubs.latest_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "allows access to clubs overview to see all clubs" do
        visit clubs_path(view: "all")
        expect(page).to have_content(I18n.t(".clubs.all_index_title"))
        expect(page).not_to have_content(I18n.t(".general.not_authorized"))
      end

      it "disallows access to clubs overview to maintenance clubs" do
        visit clubs_path
        expect(page).not_to have_content(I18n.t(".clubs.clubs_title"))
        expect(page).to have_content(I18n.t(".general.not_authorized"))
      end

      it "allows adding a club" do
        visit clubs_path(view: "all")
        expect(page).to have_content(I18n.t(".clubs.new_title"))
      end

      it "can add a new club" do
        visit clubs_path(view: "all")
        first(:link, I18n.t(".clubs.new_title")).click

        select "England", from: "club_country_id"
        fill_in "club_name", with: "Charlton Athletic"
        click_button I18n.t(".general.save")

        expect(page).to have_content(I18n.t(".clubs.messages.created"))
        expect(page).to have_content("Charlton Athletic")
      end
    end
  end

  describe "admins" do
    let!(:admin)   { create(:user, role: "admin", subscription: "premium") }

    before do
      sign_in(admin)
    end

    it "allows access to clubs overview to see own clubs" do
      visit clubs_path(view: "own")
      expect(page).to have_content(I18n.t(".clubs.my_index_title"))
      expect(page).not_to have_content(I18n.t(".general.not_authorized"))
    end

    it "allows access to clubs overview to see latest clubs" do
      visit clubs_path(view: "latest")
      expect(page).to have_content(I18n.t(".clubs.latest_index_title"))
      expect(page).not_to have_content(I18n.t(".general.not_authorized"))
    end

    it "allows access to clubs overview to see all clubs" do
      visit clubs_path(view: "all")
      expect(page).to have_content(I18n.t(".clubs.all_index_title"))
      expect(page).not_to have_content(I18n.t(".general.not_authorized"))
    end

    it "allows access to clubs overview to maintenance clubs" do
      visit clubs_path
      expect(page).to have_content(I18n.t(".clubs.clubs_title"))
      expect(page).not_to have_content(I18n.t(".general.not_authorized"))
    end

    it "allows adding a club" do
      visit new_club_path
      expect(page).to have_content(I18n.t(".clubs.new_title"))
      expect(page).not_to have_content(I18n.t(".general.not_authorized"))
    end

    it "can add a new club" do
      visit clubs_path
      first(:link, I18n.t(".clubs.new_title")).click

      select "England", from: "club_country_id"
      fill_in "club_name", with: "Charlton Athletic"
      click_button I18n.t(".general.save")

      expect(page).to have_content(I18n.t(".clubs.messages.created"))
      expect(page).to have_content("Charlton Athletic")
    end
  end
end