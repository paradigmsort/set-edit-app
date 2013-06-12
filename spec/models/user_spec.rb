# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'spec_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  subject { user }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_me) }
  it { should respond_to(:comments) }

  it { should be_valid }

  let(:user_2) { FactoryGirl.create(:user) }

  it(:email) { should_not == user_2.email }

  describe "comments" do
    before { mock_image_server }
    let(:old_comment) { FactoryGirl.create(:comment, user: user, created_at: 1.day.ago) }
    let(:new_comment) { FactoryGirl.create(:comment, user: user, created_at: 1.hour.ago) }
    before do
      old_comment.save
      new_comment.save
    end

    it "should be in the right order" do
      user.comments.should == [new_comment, old_comment]
    end
  end
end
