require 'spec_helper'

describe Club do
  it { should belong_to :league }
  it { should have_many :visits }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :league_id }
end