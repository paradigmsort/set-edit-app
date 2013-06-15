# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  user_id      :integer
#  card_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  card_version :integer
#

require 'spec_helper'

describe Comment do
  before do
    mock_image_server
    @comment = FactoryGirl.create(:comment)
  end

  subject { @comment }

  it { should respond_to(:card) }
  it { should respond_to(:user) }
  it { should respond_to(:content) }

  it { should be_valid }

  describe "with no user" do
    before { @comment.user_id = nil }

    it { should_not be_valid }
  end

  describe "with no card" do
    before { @comment.card_id = nil }

    it { should_not be_valid }
  end

  describe "with no content" do
    before { @comment.content = " " }

    it { should_not be_valid }
  end

  describe "accessing through user" do
    let(:new_comment) { FactoryGirl.create(:comment) }

    it "should work" do
      @comment.user.comments.should include(@comment)
    end

    it "should not return other comments" do
      @comment.user.comments.should_not include(new_comment)
    end
  end

  describe "accessing through card" do
    let(:new_comment) { FactoryGirl.create(:comment) }

    it "should work" do
      @comment.card.comments.should include(@comment)
    end

    it "should not return other comments" do
      @comment.card.comments.should_not include(new_comment)
    end
  end
end
