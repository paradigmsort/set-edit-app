# == Schema Information
#
# Table name: cards
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  cost       :string(255)
#  typeline   :string(255)
#  text       :string(255)
#  power      :integer
#  toughness  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Card do
  before do
    mock_image_server
    @card = FactoryGirl.create(:card)
  end

  subject { @card }

  it { should respond_to(:name) }
  it { should respond_to(:cost) }
  it { should respond_to(:typeline) }
  it { should respond_to(:text) }
  it { should respond_to(:power) }
  it { should respond_to(:toughness) }
  it { should respond_to(:power_toughness) }

  it { should be_valid }

  it "should have non-nil power_toughness" do
    @card.power_toughness { should_not be_nil }
  end

  describe "with blank name" do
    before { @card.name = " " }

    it { should_not be_valid }
  end

  describe "with invalid cost" do
    before { @card.cost = "W1" }

    it { should_not be_valid }
  end

  describe "with blank typeline" do
    before { @card.typeline = " "}

    it { should_not be_valid }
  end

  describe "via power_toughness" do
    describe "successfully setting" do
      before do
        @card.power_toughness = "2/7"
        @card.save
      end

      its(:power) { should == 2 }
      its(:toughness) { should == 7 }
      its(:power_toughness) { should == "2/7" }
    end

    describe "unsuccessfully setting" do
      before { @card.power_toughness = "1/3/5" }

      it { should_not be_valid }
      it "should show correctly" do
        @card.power_toughness { should == "1/3/5"}
      end
    end

    describe "setting to nil" do
      before do
        @card.power_toughness = ""
        @card.save
      end

      it { should be_valid }
      its(:power) { should be_nil }
      its(:toughness) { should be_nil }
    end
  end
end
