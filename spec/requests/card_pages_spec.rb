require 'spec_helper'

describe "Card Pages" do
  subject { page }

  describe "Card Index" do
    before do
     5.times { FactoryGirl.create(:card) }
     visit cards_path
   end

    it { should have_title("Cards") }

    it "should list all the cards" do
      Card.all.each do | card |
        page.should have_selector('table tr', text: card.name)
      end
    end
  end
end
