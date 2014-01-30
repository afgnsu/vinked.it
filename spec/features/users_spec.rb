require 'spec_helper'

describe "Users" do

  context "unregistered visitors" do
    it "redirects to the login page" do
      visit users_path
      page.should have_content("Inloggen")
    end
  end

  describe "registered users" do
    let!(:customer) { create(:customer, name: "Philips") }
    let!(:company) { create(:company, name: "Development") }
    let!(:manager) { create(:user, first_name: "Mario", last_name: "Manager", role: "manager", company_id: company.id) }
    let!(:user1)   { create(:user, first_name: "Ed", last_name: "Employee", role: "employee", manager_id: manager.id, company_id: company.id) }
    let!(:user2)   { create(:user, first_name: "Henk", last_name: "Jansen", role: "employee", manager_id: nil, company_id: company.id) }
    let!(:project)     { create(:project, name: "Lighting GAT", customer: customer, company: company) }
    let!(:projectuser1) { create(:projectuser, rate: 75, user: user1, project: project) }
    let!(:projectuser2) { create(:projectuser, rate: 50, user: user2, project: project) }
    let!(:ts_jan)   { create(:timesheet, month: 1, year: 2013, status: "approved", user: user1) }
    let!(:activity1) { create(:activity, activity_date: "03-01-2013", location: "Eindhoven", hours: 88, km: 40, comment: "testje", projectuser: projectuser1, timesheet: ts_jan) }
    let!(:ts_feb)   { create(:timesheet, month: 2, year: 2013, status: "approved", user: user1) }
    let!(:activity2) { create(:activity, activity_date: "03-02-2013", location: "Eindhoven", hours: 22, km: 40, comment: "testje", projectuser: projectuser1, timesheet: ts_feb) }
    let!(:ts_mar)   { create(:timesheet, month: 3, year: 2013, status: "approved", user: user2) }
    let!(:activity3) { create(:activity, activity_date: "03-02-2013", location: "Eindhoven", hours: 18, km: 40, comment: "testje", projectuser: projectuser2, timesheet: ts_feb) }

    context "admins" do
      let!(:admin) { create(:user, first_name: "Arie", last_name: "Admin", role: "admin", company_id: company.id) }

      before do
        sign_in(admin)
      end

      context "overviews" do
        it "can see the users overview" do
          visit users_path
          page.should have_content("Medewerkers")
          page.should have_content(user1.full_name)
          page.should have_content(user2.full_name)
        end

        it "can see the financial overview" do
          visit users_path(view: "financial")

          page.should have_content("Omzet overzicht")
          page.should have_content("110.0")
          page.should have_content("8.250,00")
          page.should have_content("1.732,50")
          page.should have_content("9.982,50")
          page.should have_content("128.0")
          page.should have_content("62,50")
          page.should have_content("9.150,00")
          page.should have_content("1.921,50")
          page.should have_content("11.071,50")
        end

        it "can see the availability overview" do
          visit users_path(view: "availability")
          page.should have_content("Inzet overzicht")
          page.should have_content("75,00")
          page.should have_content("50,00")
        end
      end

      context "employee details" do
        it "cannot see extended employee info" do
          visit user_path(user1)

          within("#employee_info") do
            page.should have_content("Inzet")
            page.should have_content("Omzet")
            page.should have_content("Declaraties")
            page.should have_content("Timesheets")
          end
        end
      end

      it "can see crud links" do
        visit users_path

        page.should have_content("Toevoegen medewerker")
        within(".table-striped") do
          page.should have_content("wijzigen")
        end
      end

      context "filter" do
        let!(:company2) { create(:company, name: "Testservices Midden", name_short: "TSM") }
        let!(:user3)   { create(:user, first_name: "Theo", last_name: "Twee", role: "employee", manager_id: nil, company_id: company2.id) }

        it "can filter users" do
          visit users_path

          select company2.name, from: "company"
          click_button "Filter"

          page.should have_content(user3.full_name)
          page.should_not have_content(user2.full_name)
          page.should_not have_content(user1.full_name)
        end
      end

      context "map" do
        it "shows a map button" do
          visit users_path
          page.should have_content("Inzetkaart")

          click_link("Inzetkaart")
          page.should have_content("Inzetkaart")
          page.should have_css(".map_container")
        end
      end

      it "can add a new employee" do
        visit users_path
        click_link "Toevoegen medewerker"

        fill_in "user_first_name", with: "Nico"
        fill_in "user_last_name", with: "New"
        fill_in "user_email", with: "nico.new@salves.nl"
        select "1", from: "user_birth_date_3i"
        select "januari", from: "user_birth_date_2i"
        select "1975", from: "user_birth_date_1i"
        select "Medewerker", from: "user_role"
        select "Vast", from: "user_contract"
        fill_in "user_contract_hours", with: "40"
        fill_in "user_salary", with: "4500"
        select manager.full_name, from: "user_manager_id"
        select company.name, from: "user_company_id"
        select "1", from: "user_start_date_3i"
        select "januari", from: "user_start_date_2i"
        select "2013", from: "user_start_date_1i"
        click_button I18n.t(".general.save")

        page.should have_content("Medewerker is succesvol toegevoegd")
        page.should have_content("Nico New")
      end

      it "can add a new external employee" do
        visit users_path
        click_link "Toevoegen medewerker"

        fill_in "user_first_name", with: "Ed"
        fill_in "user_last_name", with: "External"
        fill_in "user_email", with: "ed.external@salves.nl"
        select "1", from: "user_birth_date_3i"
        select "januari", from: "user_birth_date_2i"
        select "1975", from: "user_birth_date_1i"
        select "Medewerker", from: "user_role"
        select "Tijdelijk", from: "user_contract"
        fill_in "user_contract_hours", with: "40"
        fill_in "user_salary", with: "0"
        select manager.full_name, from: "user_manager_id"
        select company.name, from: "user_company_id"
        select "1", from: "user_start_date_3i"
        select "januari", from: "user_start_date_2i"
        select "2013", from: "user_start_date_1i"
        click_button I18n.t(".general.save")

        page.should have_content("Medewerker is succesvol toegevoegd")
        page.should have_content("Ed External")
      end

      it "can edit an employee" do
        visit users_path
        first(:link, "wijzigen").click

        page.should_not have_selector("input", text: "Wachtwoord")
        page.should have_selector("select", text: manager.full_name)
        page.should have_selector("select", text: company.name)
        page.should have_selector("select", text: Time.now.year)

        fill_in "user_first_name", with: "Theo"
        fill_in "user_last_name", with: "Nieuw"
        select "Development", from: "user_company_id"
        click_button I18n.t(".general.save")

        page.should have_content(I18n.t(".users.message_update"))
        page.should have_content("Nieuw")
      end

      context "user adoption" do
        it "should be possible to adopt an user" do
          visit user_path(user1)
          expect(page).to have_link "Overnemen"

          click_link "Overnemen"
          expect(page).to have_content(user1.full_name)
          expect(page).to_not have_content(admin.full_name)
          within(".adoption_alert") do
            expect(page).to have_content("Let op: Je bent momenteel ingelogd als gebruiker Ed Employee! Terug naar mijn eigen account")
          end

          click_link "Terug naar mijn eigen account"

          within(".navbar") do
            expect(page).to_not have_content(user1.full_name)
            expect(page).to have_content(admin.full_name)
          end
        end
      end
    end

    context "manager" do
      before do
        sign_in(manager)
      end

      it "can see the team users overview" do
        visit users_path(scope: "team")
        page.should have_content("Mijn team")
        page.should have_content(user1.full_name)
        page.should_not have_content(user2.full_name)
      end

      context "overviews" do
        it "can see the users overview" do
          visit users_path
          page.should have_content("Medewerkers")
          page.should have_content(user1.full_name)
          page.should have_content(user2.full_name)
        end

        it "cannot see the financial overview" do
          visit users_path(view: "financial")
          page.should have_content("Omzet overzicht")
        end

        it "cannot see the availability overview" do
          visit users_path(view: "availability")
          page.should have_content("Inzet overzicht")
        end
      end

      context "employee details" do
        it "cannot see extended employee info" do
          visit user_path(user1)

          within("#employee_info") do
            page.should have_content("Inzet")
            page.should have_content("Omzet")
            page.should have_content("Declaraties")
            page.should have_content("Timesheets")
          end
        end
      end

      it "cannot see crud links" do
        visit users_path

        within(".table-striped") do
          page.should_not have_content("Toevoegen medewerker")
          page.should_not have_content("wijzigen")
          page.should_not have_content("verwijderen")
        end
      end

      it "can see the filter selector" do
        visit users_path
        page.should have_button("Filter")
      end

      it "can see his own profile" do
        visit user_path(manager)
        page.should have_content(manager.first_name)
        page.should have_content(manager.last_name)
        page.should have_content(manager.email)
      end

      it "cannot see his own extended employee info" do
        visit user_path(manager)

        within("#employee_info") do
          page.should_not have_content("Inzet")
          page.should_not have_content("Omzet")
          page.should_not have_content("Declaraties")
          page.should_not have_content("Tiemsheets")
        end
      end

      it "can edit his own profile" do
        visit user_path(manager)
        click_link "Wijzigen profiel"

        page.should_not have_selector("select", text: manager.full_name)
        page.should_not have_selector("select", text: company.name)
        page.should_not have_selector("select", text: Time.now.year)

        fill_in "user_first_name", with: "Theo"
        fill_in "user_last_name", with: "Nieuw"
        fill_in "user_password", with: "blabla11"
        click_button I18n.t(".general.save")

        page.should have_content(I18n.t(".users.message_update"))
        page.should have_content("Theo Nieuw")
      end

      context "user adoption" do
        it "cannot adopt an user" do
          visit user_path(user1)
          expect(page).to_not have_button "Overnemen"
        end
      end
    end

    context "employee" do
      let!(:other_user) { create(:user, first_name: "Piet", last_name: "De Vries", role: "employee", company_id: company.id) }

      before do
        sign_in(user1)
      end

      context "overviews" do
        it "cannot see users overview" do
          visit users_path
          page.should have_content("Je hebt geen toegang tot deze pagina!")
          page.should_not have_content("Medewerkers")
        end

        it "cannot see the financial overview" do
          visit users_path(view: "financial")
          page.should have_content("Je hebt geen toegang tot deze pagina!")
        end

        it "cannot see the availability overview" do
          visit users_path(view: "availability")
          page.should have_content("Je hebt geen toegang tot deze pagina!")
        end
      end

      it "cannot see the filter selector" do
        visit users_path
        page.should_not have_button("OK")
      end

      context "own profile" do
        it "can see his own profile" do
          visit user_path(user1)

          page.should have_content(user1.first_name)
          page.should have_content(user1.last_name)
          page.should have_content(user1.email)
          page.should have_content("Wijzigen profiel")
          page.should_not have_content("Naar vorige pagina")
        end

        it "cannot see extended employee info" do
          visit user_path(user1)

          within("#employee_info") do
            page.should_not have_content("Inzet")
            page.should_not have_content("Omzet")
            page.should_not have_content("Declaraties")
            page.should_not have_content("Tiemsheets")
          end
        end

        it "can edit his own profile" do
          visit user_path(user1)
          click_link "Wijzigen profiel"

          page.should_not have_selector("select", text: manager.full_name)
          page.should_not have_selector("select", text: company.name)
          page.should_not have_selector("select", text: Time.now.year)

          fill_in "user_first_name", with: "Theo"
          fill_in "user_last_name", with: "Nieuw"
          fill_in "user_password", with: "blabla11"
          click_button I18n.t(".general.save")

          page.should have_content(I18n.t(".users.message_update"))
          page.should have_content("Theo Nieuw")
        end

        it "can edit his own profile without providing a password" do
          visit user_path(user1)
          click_link "Wijzigen profiel"

          page.should_not have_selector("input", text: "Rol")
          page.should_not have_selector("input", text: "Afdeling")

          fill_in "user_first_name", with: "Theo"
          fill_in "user_last_name", with: "Nieuw"
          click_button I18n.t(".general.save")

          page.should have_content(I18n.t(".users.message_update"))
          page.should have_content("Theo Nieuw")
        end

        it "can not edit profile of other user" do
          visit edit_user_path(other_user)
          page.should_not have_selector("input", text: "Rol")
          page.should_not have_selector("input", text: "Email")
          page.should_not have_selector("input", text: "Voornaam")
        end

        it "cannot adopt an user" do
          visit user_path(user1)
          expect(page).to_not have_button "Overnemen"
        end
      end
    end

    context "external" do
      let!(:external) { create(:user, role: "external", company_id: company.id) }

      before do
        sign_in(external)
      end

      it "shows the manual option" do
        visit users_path
        within(".navbar") do
          page.should have_content("Handleiding")
        end
      end

      context "own profile" do
        it "can see his own profile" do
          visit user_path(external)
          page.should have_content(external.first_name)
          page.should have_content(external.last_name)
          page.should have_content(external.email)
          page.should have_content("Wijzigen profiel")
          page.should_not have_content("Naar vorige pagina")
        end

        it "cannot adopt an user" do
          visit user_path(external)
          expect(page).to_not have_button "Overnemen"
        end

        it "cannot see extended employee info" do
          visit user_path(external)

          within("#employee_info") do
            page.should_not have_content("Inzet")
            page.should_not have_content("Omzet")
            page.should_not have_content("Declaraties")
            page.should_not have_content("Tiemsheets")
          end
        end
      end

      context "overviews" do
        it "cannot see users overview" do
          visit users_path
          page.should have_content("Je hebt geen toegang tot deze pagina!")
        end

        it "cannot see the financial overview" do
          visit users_path(view: "financial")
          page.should have_content("Je hebt geen toegang tot deze pagina!")
        end

        it "cannot see the availability overview" do
          visit users_path(view: "availability")
          page.should have_content("Je hebt geen toegang tot deze pagina!")
        end
      end
    end
  end
end