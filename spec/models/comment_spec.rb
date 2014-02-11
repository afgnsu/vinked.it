require 'spec_helper'

describe Comment do
  it { should belong_to :user }
  it { should belong_to :commentable }
  it { should validate_presence_of :user_id           }
  it { should validate_presence_of :content           }
  it { should validate_presence_of :commentable_type  }
  it { should validate_presence_of :commentable_id    }

  describe "validations" do
    let!(:comment) { create(:comment) }

    describe "when content is too long" do
      before { comment.content = "a" * 141 }
      it { should_not be_valid }
    end
  end
end
