require 'spec_helper'

describe Club do
  it { should have_many :vinks }
  it { should validate_presence_of :name       }
end