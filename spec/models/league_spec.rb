require 'spec_helper'

describe League do
  it { should belong_to :country }
  it { should have_many :clubs }
  it { should have_many(:visits).through(:clubs) }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :country_id }
end