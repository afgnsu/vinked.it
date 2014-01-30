require 'spec_helper'

describe "Visit" do
  context "unregistered visitors" do
    let!(:visit){ create(:visit) }

    it "disallows access to the visits overview" do
      visit visits_path
      expect(page).to have_content(I18n.t(".visits.index_title"))
      expect(page).to have_content(visit.visit_nr)
    end

    it "doesn't show crud links" do
      visit visits_path
      expect(page).not_to have_content(I18n.t(".visits.new_title"))
      expect(page).not_to have_content(I18n.t(".helpers.edit"))
      expect(page).not_to have_content(I18n.t(".helpers.destroy"))
    end

    it "disallows adding a visit" do
      visit new_visit_path
      expect(page).not_to have_content(I18n.t(".visits.new_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end

    it "disallows editing a visit" do
      visit edit_visit_path(visit)
      expect(page).not_to have_content(I18n.t(".visits.edit_title"))
      expect(page).to have_content(I18n.t(".general.not_authorized"))
    end
  end

  describe "registered users" do
    let!(:other_user){ create(:user, role: "user") }
    let!(:other_visit){ create(:visit, user: other_user) }

    context "user" do
      let!(:user){ create(:user, role: "user") }

      before do
        sign_in(user)
      end

      it "allows adding a visit" do
        visit new_visit_path
        expect(page).to have_content(I18n.t(".visits.new_title"))
      end

      describe "visits index page" do
        let!(:own_visit){ create(:visit, user: user) }

        context "own visits" do
          it "allows access to the visits overview" do
            visit visits_path(user)
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(own_visit.visit_nr)
            expect(page).not_to have_content(other_visit.visit_nr)
          end

          it "shows crud links" do
            visit visits_path(user)
            expect(page).to have_content(I18n.t(".visits.new_title"))
            expect(page).to have_content(I18n.t(".helpers.edit"))
            expect(page).to have_content(I18n.t(".helpers.destroy"))
          end

          it "allows editing an own visit" do
            visit edit_visit_path(own_visit)
            expect(page).to have_content(I18n.t(".visits.edit_title"))
            expect(page).to have_content(own_visit.visit_date)
          end
        end

        context "other user's visits" do
          it "allows access to the visits overview" do
            visit visits_path(other_user)
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(other_visit.visit_nr)
            expect(page).not_to have_content(own_visit.visit_nr)
          end

          it "doesn't show crud links" do
            visit visits_path(other_user)
            expect(page).not_to have_content(I18n.t(".visits.new_title"))
            expect(page).not_to have_content(I18n.t(".helpers.edit"))
            expect(page).not_to have_content(I18n.t(".helpers.destroy"))
          end

          it "disallows editing an other user's visit" do
            visit edit_visit_path(other_visit)
            expect(page).not_to have_content(I18n.t(".visits.edit_title"))
            expect(page).not_to have_content(own_visit.visit_date)
          end
        end

        context "all visits" do
          it "allows access to the visits overview" do
            visit visits_path
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(other_visit.visit_nr)
            expect(page).to have_content(own_visit.visit_nr)
          end

          it "doesn't show crud links" do
            visit visits_path
            expect(page).not_to have_content(I18n.t(".visits.new_title"))
            expect(page).not_to have_content(I18n.t(".helpers.edit"))
            expect(page).not_to have_content(I18n.t(".helpers.destroy"))
          end
        end
      end
    end

    context "admin" do
      let!(:admin) { create(:user, role: "admin") }

      before do
        sign_in(admin)
      end

      it "allows adding a visit" do
        visit new_visit_path
        expect(page).to have_content(I18n.t(".visits.new_title"))
      end

      describe "visits index page" do
        let!(:own_visit){ create(:visit, user: user) }

        context "own visits" do
          it "allows access to the visits overview" do
            visit visits_path(user)
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(own_visit.visit_nr)
            expect(page).not_to have_content(other_visit.visit_nr)
          end

          it "shows crud links" do
            visit visits_path(user)
            expect(page).to have_content(I18n.t(".visits.new_title"))
            expect(page).to have_content(I18n.t(".helpers.edit"))
            expect(page).to have_content(I18n.t(".helpers.destroy"))
          end

          it "allows editing an own visit" do
            visit edit_visit_path(own_visit)
            expect(page).to have_content(I18n.t(".visits.edit_title"))
            expect(page).to have_content(own_visit.visit_date)
          end
        end

        context "other user's visits" do
          it "allows access to the visits overview" do
            visit visits_path(other_user)
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(other_visit.visit_nr)
            expect(page).not_to have_content(own_visit.visit_nr)
          end

          it "doesn't show crud links" do
            visit visits_path(other_user)
            expect(page).not_to have_content(I18n.t(".visits.new_title"))
            expect(page).not_to have_content(I18n.t(".helpers.edit"))
            expect(page).not_to have_content(I18n.t(".helpers.destroy"))
          end

          it "disallows editing an other user's visit" do
            visit edit_visit_path(other_visit)
            expect(page).not_to have_content(I18n.t(".visits.edit_title"))
            expect(page).not_to have_content(own_visit.visit_date)
          end
        end

        context "all visits" do
          it "allows access to the visits overview" do
            visit visits_path
            expect(page).to have_content(I18n.t(".visits.index_title"))
            expect(page).to have_content(other_visit.visit_nr)
            expect(page).to have_content(own_visit.visit_nr)
          end

          it "doesn't show crud links" do
            visit visits_path
            expect(page).not_to have_content(I18n.t(".visits.new_title"))
            expect(page).not_to have_content(I18n.t(".helpers.edit"))
            expect(page).not_to have_content(I18n.t(".helpers.destroy"))
          end
        end
      end
    end
  end
end