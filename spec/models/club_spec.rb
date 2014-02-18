require 'spec_helper'

describe Club do
  it { should belong_to :country                }
  it { should have_many :vinks                  }
  it { should have_many :comments               }
  it { should have_many(:users).through(:vinks) }
  it { should validate_presence_of :name        }
  it { should validate_presence_of :country_id  }
end
