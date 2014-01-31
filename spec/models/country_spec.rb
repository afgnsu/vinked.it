require 'spec_helper'

describe Country do
  it { should validate_presence_of :country       }
  it { should validate_presence_of :country_short }
end