require 'spec_helper'

describe Vink do
  it { should belong_to :user }
  it { should belong_to :club }
  it { should validate_presence_of :vink_date }
  it { should validate_presence_of :user_id }
  it { should validate_presence_of :club_id }
end