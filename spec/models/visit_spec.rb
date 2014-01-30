require 'spec_helper'

describe Visit do
  it { should belong_to :user }
  it { should belong_to :club }
  it { should validate_presence_of :visit_nr }
  it { should validate_presence_of :visit_date }
  it { should validate_presence_of :league_id }
  it { should validate_presence_of :club_id }
  it { should validate_presence_of :away_club_id }
  it { should validate_presence_of :ground }
  it { should validate_presence_of :result }
  it { should validate_presence_of :season }
  it { should validate_presence_of :kickoff }
end