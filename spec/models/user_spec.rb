require 'spec_helper'

describe User do
  #it { should have_many :visits }
  it { should validate_presence_of :email         }
  it { should validate_presence_of :role          }
  it { should validate_presence_of :first_name    }
  it { should validate_presence_of :last_name     }
  it { should validate_presence_of :screen_name   }
  it { should validate_presence_of :locale        }
  it { should validate_presence_of :subscription  }

  describe "validations" do
    let!(:user) { create(:user, first_name: "John", last_name: "Van Arkelen", email: "john@bla.com") }

    describe "when first_name is too long" do
      before { user.first_name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when last_name is too long" do
      before { user.last_name = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when location is too long" do
      before { user.location = "a" * 51 }
      it { should_not be_valid }
    end

    describe "when screen_name is too long" do
      before { user.last_name = "a" * 16 }
      it { should_not be_valid }
    end

    describe "with a password that's too short" do
      before { user.password = "a" * 7 }
      it { should be_invalid }
    end

    describe "when password is not present" do
      before { user.password = "" }
      it { should_not be_valid }
    end

    describe "when email address is already taken" do
      before do
        user_with_same_email = user.dup
        user_with_same_email.email = user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
    end
  end

  describe "roles" do
    let!(:user) { create(:user, role: "user") }
    let!(:admin){ create(:user, role: "admin") }

    context "user?" do
      it "sets user as user" do
        expect(user.user?).to be_true
      end

      it "sets user not as admin" do
        expect(user.admin?).to be_false
      end
    end

    context "admin?" do
      it "sets user as admin" do
        expect(admin.admin?).to be_true
      end

      it "sets admin not as user" do
        expect(admin.user?).to be_false
      end
    end
  end

  describe "full_name" do
    let!(:user) { create(:user, first_name: "Piet", last_name: "Jansen") }

    it "assigns a full name" do
      expect(user.full_name).to eq "Piet Jansen"
    end
  end

  describe "subscriptions" do
    let!(:user_none)    { create(:user, subscription: "none") }
    let!(:user_basic)   { create(:user, subscription: "basic") }
    let!(:user_premium) { create(:user, subscription: "premium") }

    context "basic?" do
      it "sets basic as basic" do
        expect(user_basic.basic?).to be_true
      end

      it "sets none not as basic" do
        expect(user_none.basic?).to be_false
      end

      it "sets premium not as basic" do
        expect(user_premium.basic?).to be_false
      end
    end

    context "premium?" do
      it "sets premium as premium" do
        expect(user_premium.premium?).to be_true
      end

      it "sets none not as premium" do
        expect(user_none.premium?).to be_false
      end

      it "sets basic not as premium" do
        expect(user_basic.premium?).to be_false
      end
    end
  end

end
