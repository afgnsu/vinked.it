require 'spec_helper'

describe GraphBuilder do
  let!(:customer)   { create(:customer, name: "Philips") }
  let!(:company)    { create(:company, name: "Testservices Zuid", name_short: "TSZ") }
  let!(:manager)    { create(:user, first_name: "Mario", last_name: "Manager", role: "manager", company_id: company.id) }
  let!(:employee)   { create(:user, first_name: "Ed", last_name: "Employee", role: "employee", manager_id: manager.id, company_id: company.id) }
  let!(:balance)    { create(:balance, year: DateTime.now.year, bonus_from: 1600, holiday: 27, user: employee) }
  let!(:project)    { create(:project, name: "Lighting GAT", customer: customer, company: company) }
  let!(:projectuser){ create(:projectuser, rate: 75, user: employee, project: project) }

  describe "show_holidays"do
    let!(:unbillable) { create(:unbillable, name: "Private holiday", name_short: "P", count_for_bonus: false) }
    let!(:ts_jan)     { create(:timesheet, month: 1, year: DateTime.now.year, status: "approved", user: employee) }
    let!(:ts_feb)     { create(:timesheet, month: 2, year: DateTime.now.year, status: "open", user: employee) }
    let!(:act_jan1)   { create(:activity, day: 3, hours: 8.0, unbillable: unbillable, projectuser: nil, timesheet: ts_jan) }
    let!(:act_jan2)   { create(:activity, day: 4, hours: 8.0, unbillable: unbillable, projectuser: nil, timesheet: ts_jan) }
    let!(:act_feb)    { create(:activity, day: 3, hours: 8.0, unbillable: unbillable, projectuser: nil, timesheet: ts_feb) }

    it "calculates holiday balance for approved timesheets" do
      subject = GraphBuilder.new.show_holidays(employee)
      subject[1].should == ["Opgenomen", 2.0]
    end
  end

  describe "show_bonus_hours" do
    let!(:unbillable1) { create(:unbillable, name: "Management", name_short: "M", count_for_bonus: true) }
    let!(:ts_jan)   { create(:timesheet, month: 1, year: DateTime.now.year, status: "approved", user: employee) }
    let!(:act_bil)  { create(:activity, day: 3, hours: 1610.0, unbillable: nil, projectuser: projectuser, timesheet: ts_jan) }
    let!(:act_extra){ create(:activity, hours: 25.0, unbillable: unbillable1, projectuser: nil, timesheet: ts_jan) }

    it "calculates bonus hours for approved timesheets" do
      subject = GraphBuilder.new.show_bonus_hours(employee)
      subject[1].should == ["1e helft", 1635.0, 800.0]
    end
  end

  describe "show_turnover" do
    let!(:ts_jan) { create(:timesheet, month: 1, year: DateTime.now.year, status: "approved", user: employee) }
    let!(:act_jan){ create(:activity, day: 3, hours: 160.0, unbillable: nil, projectuser: projectuser, timesheet: ts_jan) }
    let!(:employee2)   { create(:user, first_name: "Jan", last_name: "Jansen", role: "employee", manager_id: manager.id, company_id: company.id) }
    let!(:balance2)    { create(:balance, year: DateTime.now.year, bonus_from: 1600, holiday: 27, user: employee2) }
    let!(:projectuser2){ create(:projectuser, rate: 100, user: employee2, project: project) }
    let!(:ts_jan2) { create(:timesheet, month: 1, year: DateTime.now.year, status: "approved", user: employee2) }
    let!(:act_jan2){ create(:activity, day: 3, hours: 140.0, unbillable: nil, projectuser: projectuser2, timesheet: ts_jan) }

    it "calculates turnover for employee" do
      users = User.where(role: "employee")
      subject = GraphBuilder.new.show_turnover(users, DateTime.now.year, 1)
      subject[1].should == ["jan", 26000.0]
    end
  end

end
