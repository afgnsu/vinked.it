require 'spec_helper'

describe Country do
  it { should have_many :clubs }
  it { should validate_presence_of :country       }
  it { should validate_presence_of :country_short }
end