require 'spec_helper'

describe Club do
  it { should belong_to :country }
  it { should have_many :vinks }
  it { should have_many :comments }
  it { should have_many(:users).through(:vinks) }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :country_id       }
end

=begin

  describe ".per_letter" do
    pending "shows specific contacts when a letter is applied" do
      Contact.per_letter({ :letter => "V" }).should have(0).records
      Contact.per_letter({ :letter => "A" }).should have(1).record
    end
  end

  describe ".set_alphabet_letters" do
    it "includes all alphabet letters" do
      ("A".."Z").each do |letter|
        Contact.set_alphabet_letters.should include(letter)
      end
    end

    it "should not include a number" do
      Contact.set_alphabet_letters.should_not include("9")
    end
  end

  describe ".get_lastname_letters" do
    before :each do
      FactoryGirl.create(:contact, :relation => @relation, :last_name => "Adams")
    end

    it "includes A" do
      contacts = @relation.contacts
      Contact.get_lastname_letters(contacts).should include("A")
    end

    it "doesn't include B" do
      contacts = @relation.contacts
      Contact.get_lastname_letters(contacts).should_not include("B")
    end
  end

  describe ".get_contacts" do
    it "shows contacts for a specific letter" do
      Contact.get_contacts({ :letter => 'J' }).should include(@contact_a)
    end
  end
=end